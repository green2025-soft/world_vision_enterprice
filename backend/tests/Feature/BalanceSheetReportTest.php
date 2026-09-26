<?php

namespace Tests\Feature;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Schema;
use Modules\Accounting\Http\Controllers\Api\AccountsReportController;
use Modules\Accounting\Http\Requests\AccountHeadRequest;
use Modules\Accounting\Models\AccountHead;
use PHPUnit\Framework\Attributes\DataProvider;
use Tests\TestCase;

class BalanceSheetReportTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        // Never run this report's fixtures or the application's migrations on the live database.
        config([
            'database.default' => 'balance_sheet_test',
            'database.connections.balance_sheet_test' => [
                'driver' => 'sqlite',
                'database' => ':memory:',
                'prefix' => '',
                'foreign_key_constraints' => true,
            ],
        ]);

        Schema::create('acc_account_heads', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('code')->unique();
            $table->unsignedBigInteger('parent_id')->nullable();
            $table->string('type');
            $table->string('system_key')->nullable()->unique();
            $table->string('cash_flow_activity')->nullable();
            $table->boolean('is_debit');
            $table->boolean('status')->default(true);
            $table->timestamps();
        });

        Schema::create('acc_journal_entries', function (Blueprint $table) {
            $table->id();
            $table->date('date');
            $table->string('voucher_type')->nullable();
            $table->string('voucher_no')->nullable();
            $table->string('reference')->nullable();
            $table->text('narration')->nullable();
            $table->unsignedBigInteger('branch_id')->nullable();
            $table->string('status')->default('pending');
            $table->timestamps();
        });

        Schema::create('acc_journal_entry_details', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('journal_entry_id');
            $table->unsignedBigInteger('account_type_id');
            $table->unsignedBigInteger('account_category_id');
            $table->unsignedBigInteger('control_group_id');
            $table->unsignedBigInteger('ledger_group_id');
            $table->unsignedBigInteger('ledger_account_id');
            $table->text('remarks')->nullable();
            $table->decimal('debit', 15, 2)->default(0);
            $table->decimal('credit', 15, 2)->default(0);
            $table->timestamps();
        });

        Route::get('/_test/balance-sheet', [AccountsReportController::class, 'balanceSheet']);
        Route::get('/_test/income-expenditure', [AccountsReportController::class, 'incomeExpenditure']);
        Route::get('/_test/trial-balance', [\Modules\Accounting\Http\Controllers\Api\TrialBalanceController::class, 'index']);
        Route::get('/_test/receipts-payments', [\Modules\Accounting\Http\Controllers\Api\ReceiptsPaymentsController::class, 'index']);
        Route::get('/_test/ledger-report', [\Modules\Accounting\Http\Controllers\Api\LedgerReportController::class, 'index']);
        Route::get('/_test/ledger-report/accounts', [\Modules\Accounting\Http\Controllers\Api\LedgerReportController::class, 'accounts']);
        Route::get('/_test/changes-in-equity', [\Modules\Accounting\Http\Controllers\Api\ChangesInEquityController::class, 'index']);
        Route::get('/_test/cash-bank-book', [\Modules\Accounting\Http\Controllers\Api\CashBankBookController::class, 'index']);
        Route::get('/_test/cash-flow-statement', [\Modules\Accounting\Http\Controllers\Api\CashFlowStatementController::class, 'index']);
        Route::post('/_test/accounts', fn (AccountHeadRequest $request) => response()->json($request->validated()));
        Route::put('/_test/accounts/{chart_of_account}', fn (AccountHeadRequest $request) => response()->json($request->validated()));
        $this->withoutMiddleware();
    }

    protected function tearDown(): void
    {
        Carbon::setTestNow();
        Model::preventLazyLoading(false);
        DB::disconnect('balance_sheet_test');

        parent::tearDown();
    }

    public function test_balances_are_cumulative_through_month_end_and_exclude_rejected_and_future_entries(): void
    {
        $this->seedAccounts();
        $this->postEntry('2024-12-01', 1, 100);
        $this->postEntry('2025-02-28', 1, 60);
        $this->postEntry('2025-02-10', 2, 40);
        $this->postEntry('2025-03-01', 1, 800);
        $this->postEntry('2025-02-11', 1, 900, 'rejected');
        $this->postContraEntry(15);

        $response = $this->getJson('/_test/balance-sheet?month=2025-02');

        $response->assertOk()->assertJsonPath('status', true)->assertJsonPath('data.month', '2025-02-28');
        $accounts = $response->json('data.coa');
        $this->assertSame([100000, 200000], array_column($accounts, 'code'));
        $this->assertTotals($accounts[0], 200, 15, 185);
        $this->assertTotals($accounts[0]['children'][0], 200, 0, 200);
        $this->assertTotals($accounts[0]['children'][0]['children'][0], 200, 0, 200);
        $this->assertTotals($accounts[0]['children'][1], 0, 15, 15);
        $this->assertTotals($accounts[0]['children'][1]['children'][0], 0, 15, 15);
        $this->assertTotals($accounts[1], 15, 200, 185);
        // Debit-normal descendants retain their actual normal balance under the liability root.
        $this->assertTotals($accounts[1]['children'][0], 15, 200, -185);
        $this->assertTotals($accounts[1]['children'][0]['children'][0], 15, 200, -185);
        $this->assertTotals($accounts[0]['children'][0]['children'][1], 0, 0, 0);
        $this->assertTotals($accounts[0]['children'][2], 0, 0, 0);
    }

    public function test_branch_filter_and_all_branches_have_consistent_totals(): void
    {
        $this->seedAccounts();
        $this->postEntry('2024-12-01', 1, 100);
        $this->postEntry('2025-02-28', 1, 60);
        $this->postEntry('2025-02-10', 2, 40);

        $all = $this->getJson('/_test/balance-sheet?month=2025-02')->assertOk();
        $zero = $this->getJson('/_test/balance-sheet?month=2025-02&branch_id=0')->assertOk();
        $this->assertSame($all->json('data.coa'), $zero->json('data.coa'));
        $this->assertEquals(200, $all->json('data.coa.0.balance'));

        $branch = $this->getJson('/_test/balance-sheet?month=2025-02&branch_id=1')->assertOk();
        $this->assertEquals(1, $branch->json('data.branch_id'));
        $this->assertTotals($branch->json('data.coa.0'), 160, 0, 160);
        $this->assertTotals($branch->json('data.coa.0.children.0.children.0'), 160, 0, 160);

        $other = $this->getJson('/_test/balance-sheet?month=2025-02&branch_id=2')->assertOk();
        $this->assertTotals($other->json('data.coa.0'), 40, 0, 40);

        $empty = $this->getJson('/_test/balance-sheet?month=2025-02&branch_id=99')->assertOk();
        $this->assertTotals($empty->json('data.coa.0'), 0, 0, 0);
    }

    public function test_pending_entries_are_included_alongside_approved_entries(): void
    {
        $this->seedAccounts();
        $this->postEntry('2025-02-01', 1, 25.45, 'pending');
        $this->postEntry('2025-02-02', 1, 75.02, 'approved');
        $this->postEntry('2025-02-03', 1, 900, 'rejected');

        $response = $this->getJson('/_test/balance-sheet?month=2025-02')->assertOk();

        $this->assertTotals($response->json('data.coa.0'), 100.47, 0, 100.47);
        $this->assertTotals($response->json('data.coa.1'), 0, 100.47, 100.47);
    }

    public function test_report_tree_is_sorted_bounded_and_does_not_lazy_load_relations(): void
    {
        $this->seedAccounts();
        Model::preventLazyLoading();
        DB::flushQueryLog();
        DB::enableQueryLog();

        $response = $this->getJson('/_test/balance-sheet?month=2025-02')->assertOk();

        $queries = DB::getQueryLog();
        DB::disableQueryLog();
        // Three hierarchy levels, three grouped totals, and one report-role lookup.
        $this->assertLessThanOrEqual(7, count($queries), 'The response must not query parent or deeper children during serialization.');
        $accounts = $response->json('data.coa');
        $this->assertSame([100000, 200000], array_column($accounts, 'code'));
        $this->assertSame([110000, 120000, 130000], array_column($accounts[0]['children'], 'code'));
        $this->assertSame([111000, 112000], array_column($accounts[0]['children'][0]['children'], 'code'));

        foreach ($accounts as $root) {
            $this->assertArrayNotHasKey('parent', $root);
            $this->assertSame($root['type'], $root['root_type']);
            foreach ($root['children'] as $category) {
                $this->assertArrayNotHasKey('parent', $category);
                $this->assertSame($root['type'], $category['root_type']);
                foreach ($category['children'] as $control) {
                    $this->assertArrayNotHasKey('parent', $control);
                    $this->assertSame($root['type'], $control['root_type']);
                    $this->assertSame([], $control['children']);
                }
            }
        }

        $this->assertSame([], $accounts[0]['children'][2]['children']);
    }

    public function test_february_cutoff_does_not_overflow_when_today_is_the_thirty_first(): void
    {
        Carbon::setTestNow(Carbon::parse('2025-03-31 12:00:00'));
        $this->seedAccounts();
        $this->postEntry('2025-02-28', 1, 10);
        $this->postEntry('2025-03-01', 1, 20);

        $response = $this->getJson('/_test/balance-sheet?month=2025-02')->assertOk();

        $response->assertJsonPath('data.month', '2025-02-28');
        $this->assertEquals(10, $response->json('data.coa.0.balance'));
    }

    public function test_empty_chart_of_accounts_returns_an_empty_report(): void
    {
        $this->getJson('/_test/balance-sheet?month=2024-02')
            ->assertOk()
            ->assertJsonPath('data.month', '2024-02-29')
            ->assertJsonPath('data.coa', []);
    }

    #[DataProvider('invalidQueryProvider')]
    public function test_invalid_report_parameters_return_validation_errors(array $query, string $field): void
    {
        $this->getJson('/_test/balance-sheet?'.http_build_query($query))
            ->assertUnprocessable()
            ->assertJsonValidationErrors($field);
    }

    public static function invalidQueryProvider(): array
    {
        return [
            'missing month' => [[], 'month'],
            'empty month' => [['month' => ''], 'month'],
            'invalid month' => [['month' => '2025-13'], 'month'],
            'non-padded month' => [['month' => '2025-2'], 'month'],
            'full date' => [['month' => '2025-02-01'], 'month'],
            'month array' => [['month' => ['2025-02']], 'month'],
            'negative branch' => [['month' => '2025-02', 'branch_id' => -1], 'branch_id'],
            'non-numeric branch' => [['month' => '2025-02', 'branch_id' => 'all'], 'branch_id'],
            'fractional branch' => [['month' => '2025-02', 'branch_id' => '1.5'], 'branch_id'],
            'depth below range' => [['month' => '2025-02', 'depth' => 0], 'depth'],
            'depth above range' => [['month' => '2025-02', 'depth' => 5], 'depth'],
        ];
    }

    public function test_month_and_june_balances_include_all_prior_years_at_every_ledger_level(): void
    {
        $this->seedAccounts();
        $this->postEntry('2020-01-01', 1, 100);
        $this->postEntry('2026-06-30', 1, 25.50);
        $this->postEntry('2026-07-01', 1, 30);
        $this->postEntry('2026-09-30', 1, 10);
        $this->postEntry('2026-10-01', 1, 900);
        $this->postEntry('2026-06-01', 2, 50);
        $this->postEntry('2026-06-01', 1, 999, 'rejected');

        Model::preventLazyLoading();
        foreach (['2026-06' => 125.50, '2026-09' => 165.50] as $month => $expected) {
            $response = $this->getJson('/_test/balance-sheet?month='.$month.'&branch_id=1&depth=4')->assertOk();
            $root = $response->json('data.coa.0');
            $group = $root['children'][0]['children'][0]['children'][0];
            $ledger = $group['children'][0];
            $this->assertTotals($root, $expected, 0, $expected);
            $this->assertTotals($group, $expected, 0, $expected);
            $this->assertTotals($ledger, $expected, 0, $expected);
            $this->assertSame([], $ledger['children']);
            $this->assertArrayNotHasKey('parent', $ledger);
        }

        $all = $this->getJson('/_test/balance-sheet?month=2026-09&branch_id=0&depth=4')->assertOk();
        $this->assertEquals(215.50, $all->json('data.coa.0.balance'));
        $summary = $this->getJson('/_test/balance-sheet?month=2026-09&branch_id=1&depth=1')->assertOk();
        $this->assertSame([], $summary->json('data.coa.0.children.0.children'));
        $this->assertEquals(165.50, $summary->json('data.coa.0.balance'));
    }

    public function test_income_over_expenditure_uses_a_stable_key_and_reconciles_every_ancestor(): void
    {
        $this->seedEarningsAccounts();
        $this->postOperatingEntry('2026-09-01', 1, 1649.50, 1213.53);
        AccountHead::findOrFail(70)->update(['name' => 'Renamed accumulated surplus', 'code' => 219999]);
        $response = $this->getJson('/_test/balance-sheet?month=2026-09&depth=4')->assertOk();
        $summary = $response->json('data.income_over_expenditure');
        $this->assertTrue($summary['configured']);
        $this->assertSame(70, $summary['account_id']);
        $this->assertSame('Renamed accumulated surplus', $summary['account_name']);
        $this->assertEquals(1649.50, $summary['income_balance']);
        $this->assertEquals(1213.53, $summary['expense_balance']);
        $this->assertEquals(435.97, $summary['unclosed_balance']);
        $this->assertEquals(0, $summary['posted_balance']);
        $this->assertEquals(435.97, $summary['reported_balance']);
        $coa = $response->json('data.coa');
        foreach ([2, 30, 70] as $id) {
            $account = $this->reportAccount($coa, $id);
            $this->assertEquals(435.97, $account['total_credit'] - $account['total_debit']);
        }
        $this->assertEquals($coa[0]['balance'], $coa[1]['balance']);
        $adjustment = $this->reportAccount($coa, 'income-over-expenditure-unclosed');
        $this->assertTrue($adjustment['is_report_adjustment']);
        $this->assertEquals(435.97, $adjustment['balance']);
        $this->assertEquals(0, $this->reportAccount($coa, 72)['balance']);
        $this->assertSame(2, DB::table('acc_journal_entries')->count());
        $this->assertSame(4, DB::table('acc_journal_entry_details')->count());

        $shallow = $this->getJson('/_test/balance-sheet?month=2026-09&depth=1')->assertOk();
        $this->assertEquals(435.97, $shallow->json('data.coa.1.balance'));
    }

    public function test_partial_and_complete_closing_entries_are_not_counted_twice(): void
    {
        $this->seedEarningsAccounts();
        $this->postOperatingEntry('2026-09-01', 1, 100, 40);
        $this->postClosingEntry('2026-09-30', 60, 20);
        $this->postClosingEntry('2026-10-01', 40, 20);

        $partial = $this->getJson('/_test/balance-sheet?month=2026-09&depth=4')->assertOk();
        $this->assertEquals(40, $partial->json('data.income_over_expenditure.posted_balance'));
        $this->assertEquals(40, $partial->json('data.income_over_expenditure.income_balance'));
        $this->assertEquals(20, $partial->json('data.income_over_expenditure.expense_balance'));
        $this->assertEquals(20, $partial->json('data.income_over_expenditure.unclosed_balance'));
        $this->assertEquals(60, $partial->json('data.coa.1.balance'));

        $closed = $this->getJson('/_test/balance-sheet?month=2026-10&depth=4')->assertOk();
        $this->assertEquals(60, $closed->json('data.income_over_expenditure.posted_balance'));
        $this->assertEquals(0, $closed->json('data.income_over_expenditure.unclosed_balance'));
        $this->assertEquals(60, $closed->json('data.coa.1.balance'));
        $target = $this->reportAccount($closed->json('data.coa'), 70);
        $this->assertCount(1, $target['children']);
        $this->assertEquals(60, $this->reportAccount($closed->json('data.coa'), 72)['balance']);
    }

    public function test_earnings_respect_cumulative_cutoffs_statuses_and_branch_filters(): void
    {
        $this->seedEarningsAccounts();
        $this->postOperatingEntry('2020-01-01', 1, 10, 0);
        $this->postOperatingEntry('2026-06-30', 1, 20, 5);
        $this->postOperatingEntry('2026-07-01', 1, 100, 30);
        $this->postOperatingEntry('2026-07-01', 2, 40, 0);
        $this->postOperatingEntry('2026-10-01', 1, 999, 0);
        $this->postOperatingEntry('2026-07-01', 1, 777, 0, 'rejected');
        foreach ([['2026-06', 1, 25], ['2026-09', 1, 95], ['2026-09', 2, 40], ['2026-09', 0, 135]] as [$month, $branch, $expected]) {
            $response = $this->getJson('/_test/balance-sheet?month='.$month.'&branch_id='.$branch)->assertOk();
            $this->assertEquals($expected, $response->json('data.income_over_expenditure.reported_balance'));
            $this->assertEquals($expected, $response->json('data.coa.0.balance'));
            $this->assertEquals($expected, $response->json('data.coa.1.balance'));
        }
    }

    public function test_loss_is_deducted_and_missing_mapping_is_reported_without_fabricating_a_balance(): void
    {
        $this->seedEarningsAccounts();
        $this->postOperatingEntry('2026-09-01', 1, 10, 30);
        $response = $this->getJson('/_test/balance-sheet?month=2026-09&depth=4')->assertOk();
        $this->assertEquals(-20, $response->json('data.coa.1.balance'));
        $this->assertEquals(20, $this->reportAccount($response->json('data.coa'), 70)['total_debit']);
        $this->assertEquals(-20, $this->reportAccount($response->json('data.coa'), 'income-over-expenditure-unclosed')['balance']);

        AccountHead::findOrFail(70)->update(['system_key' => null]);
        $missing = $this->getJson('/_test/balance-sheet?month=2026-09')->assertOk();
        $missing->assertJsonPath('data.income_over_expenditure.configured', false);
        $this->assertEquals(-20, $missing->json('data.income_over_expenditure.unclosed_balance'));
        $this->assertEquals(0, $missing->json('data.coa.1.balance'));
    }

    public function test_report_role_is_unique_and_remains_valid_when_an_account_is_renamed(): void
    {
        $this->seedEarningsAccounts();
        $data = ['name' => 'New surplus name', 'code' => 213000, 'parent_id' => 30, 'status' => 1, 'system_key' => AccountHead::INCOME_OVER_EXPENDITURE_KEY];
        $this->putJson('/_test/accounts/70', $data)->assertOk()->assertJsonPath('system_key', AccountHead::INCOME_OVER_EXPENDITURE_KEY);
        $this->postJson('/_test/accounts', $data)->assertUnprocessable()->assertJsonValidationErrors('system_key');
        $this->putJson('/_test/accounts/70', [...$data, 'parent_id' => 10])->assertUnprocessable()->assertJsonValidationErrors('system_key');
    }

    public function test_migration_assigns_the_key_to_the_existing_account(): void
    {
        $this->seedEarningsAccounts();
        Schema::table('acc_account_heads', function (Blueprint $table) {
            $table->dropUnique(['system_key']);
            $table->dropColumn('system_key');
        });
        $migration = require base_path('Modules/Accounting/database/migrations/2026_09_26_150000_add_system_key_to_acc_account_heads_table.php');
        $migration->up();
        $this->assertSame(AccountHead::INCOME_OVER_EXPENDITURE_KEY, AccountHead::findOrFail(70)->system_key);
        $this->assertSame(1, AccountHead::whereNotNull('system_key')->count());
    }

    public function test_income_statement_separates_month_from_financial_year_and_excludes_other_years(): void
    {
        $this->seedEarningsAccounts();
        $this->postOperatingEntry('2025-06-30', 1, 900, 600);
        $this->postOperatingEntry('2025-07-01', 1, 100, 40);
        $this->postOperatingEntry('2025-09-30', 1, 80, 20, 'pending');
        $this->postOperatingEntry('2025-09-10', 2, 30, 10);
        $this->postOperatingEntry('2025-10-01', 1, 700, 500);
        $this->postOperatingEntry('2025-09-15', 1, 800, 700, 'rejected');

        $fy = $this->getJson('/_test/income-expenditure?month=2025-09&depth=4')->assertOk()
            ->assertJsonPath('data.start_date', '2025-07-01')
            ->assertJsonPath('data.month', '2025-09-30')
            ->assertJsonPath('data.financial_year', 'FY 2025-26');
        $this->assertSame([300000, 400000], array_column($fy->json('data.coa'), 'code'));
        $this->assertTotals($fy->json('data.coa.0'), 0, 210, 210);
        $this->assertTotals($fy->json('data.coa.1'), 70, 0, 70);
        $this->assertTotals($this->reportAccount($fy->json('data.coa'), 103), 0, 210, 210);

        $month = $this->getJson('/_test/income-expenditure?month=2025-09&period=month&branch_id=1')->assertOk()
            ->assertJsonPath('data.start_date', '2025-09-01');
        $this->assertTotals($month->json('data.coa.0'), 0, 80, 80);
        $this->assertTotals($month->json('data.coa.1'), 20, 0, 20);
        $all = $this->getJson('/_test/income-expenditure?month=2025-09&period=month&branch_id=0')->assertOk();
        $this->assertTotals($all->json('data.coa.0'), 0, 110, 110);
        $branch = $this->getJson('/_test/income-expenditure?month=2025-09&branch_id=1')->assertOk();
        $this->assertTotals($branch->json('data.coa.0'), 0, 180, 180);
    }

    public function test_income_statement_financial_year_resets_in_july_and_handles_june_and_leap_february(): void
    {
        $this->seedEarningsAccounts();
        $this->postOperatingEntry('2023-07-01', 1, 100, 20);
        $this->postOperatingEntry('2024-02-29', 1, 50, 10);
        $this->postOperatingEntry('2024-06-30', 1, 30, 5);
        $this->postOperatingEntry('2024-07-01', 1, 10, 3);
        Carbon::setTestNow('2026-01-31');
        $this->getJson('/_test/income-expenditure?month=2024-02')->assertOk()
            ->assertJsonPath('data.financial_year', 'FY 2023-24')->assertJsonPath('data.month', '2024-02-29')
            ->assertJsonPath('data.coa.0.balance', 150);
        $this->getJson('/_test/income-expenditure?month=2024-06')->assertOk()
            ->assertJsonPath('data.start_date', '2023-07-01')->assertJsonPath('data.coa.0.balance', 180);
        $this->getJson('/_test/income-expenditure?month=2024-07')->assertOk()
            ->assertJsonPath('data.financial_year', 'FY 2024-25')->assertJsonPath('data.start_date', '2024-07-01')
            ->assertJsonPath('data.coa.0.balance', 10);
    }

    public function test_income_statement_validates_filters_and_handles_empty_data(): void
    {
        foreach ([['month' => 'bad'], ['month' => '2026-09', 'period' => 'all'], ['month' => '2026-09', 'branch_id' => -1], ['month' => '2026-09', 'depth' => 5]] as $query) {
            $this->getJson('/_test/income-expenditure?'.http_build_query($query))->assertUnprocessable();
        }
        $this->getJson('/_test/income-expenditure?month=2026-09')->assertOk()->assertJsonPath('data.coa', []);
    }

    public function test_trial_balance_opening_month_movement_and_closing_reconcile_without_synthetic_earnings(): void
    {
        $this->seedEarningsAccounts();
        $this->postOperatingEntry('2025-06-30', 1, 100, 40);
        $this->postOperatingEntry('2026-09-01', 1, 80, 20, 'pending');
        $this->postOperatingEntry('2026-09-30', 2, 30, 10);
        $this->postOperatingEntry('2026-10-01', 1, 900, 800);
        $this->postOperatingEntry('2026-09-10', 1, 700, 600, 'rejected');
        $response = $this->getJson('/_test/trial-balance?month=2026-09')->assertOk()
            ->assertJsonPath('data.start_date', '2026-09-01')->assertJsonPath('data.month', '2026-09-30');
        $totals = $response->json('data.totals');
        $this->assertEquals(['opening_debit' => 100, 'opening_credit' => 100, 'period_debit' => 140, 'period_credit' => 140, 'closing_debit' => 210, 'closing_credit' => 210], $totals);
        $coa = $response->json('data.coa');
        $this->assertEquals(60, $this->reportAccount($coa, 60)['opening_debit']);
        $this->assertEquals(140, $this->reportAccount($coa, 60)['closing_debit']);
        $this->assertEquals(0, $this->reportAccount($coa, 70)['closing_credit']);
        $branch = $this->getJson('/_test/trial-balance?month=2026-09&branch_id=1&depth=1')->assertOk();
        $this->assertEquals(100, $branch->json('data.totals.period_debit'));
        $this->assertSame([], $branch->json('data.coa.0.children.0.children'));
        $this->assertEquals(180, $branch->json('data.totals.closing_debit'));
        $this->getJson('/_test/trial-balance?month=2026-09&branch_id=99')->assertOk()->assertJsonPath('data.totals.closing_debit', 0);
    }

    public function test_trial_balance_keeps_opposite_account_balances_on_separate_sides(): void
    {
        $this->seedAccounts();
        $this->postEntry('2025-02-01', 1, 100);
        $this->postContraEntry(15);
        $response = $this->getJson('/_test/trial-balance?month=2025-03')->assertOk();
        $this->assertEquals(100, $response->json('data.coa.0.opening_debit'));
        $this->assertEquals(15, $response->json('data.coa.0.opening_credit'));
        $this->assertEquals(100, $response->json('data.totals.closing_debit'));
        $this->assertEquals(100, $response->json('data.totals.closing_credit'));
    }

    public function test_trial_balance_handles_empty_chart_and_validates_filters(): void
    {
        $this->getJson('/_test/trial-balance?month=2024-02')->assertOk()
            ->assertJsonPath('data.month', '2024-02-29')->assertJsonPath('data.coa', [])
            ->assertJsonPath('data.totals.opening_debit', 0);
        foreach (['month=invalid', 'month=2026-09&branch_id=-1', 'month=2026-09&depth=5'] as $query) {
            $this->getJson('/_test/trial-balance?'.$query)->assertUnprocessable();
        }
    }

    public function test_receipts_payments_month_and_fy_have_distinct_openings_and_cash_activity(): void
    {
        $this->seedEarningsAccounts();
        AccountHead::findOrFail(50)->update(['system_key' => 'cash_in_hand', 'name' => 'Renamed cash group', 'code' => 111199]);
        $this->postOperatingEntry('2025-06-30', 1, 100, 40);
        $this->postOperatingEntry('2025-07-01', 1, 80, 20);
        $this->postOperatingEntry('2025-09-30', 1, 30, 10, 'pending');
        $this->postOperatingEntry('2025-09-01', 2, 50, 5);
        $this->postOperatingEntry('2025-10-01', 1, 900, 800);
        $this->postOperatingEntry('2025-09-10', 1, 700, 600, 'rejected');
        $response = $this->getJson('/_test/receipts-payments?month=2025-09&branch_id=1')->assertOk()
            ->assertJsonPath('data.financial_year', 'FY 2025-26')->assertJsonPath('data.fy_start_date', '2025-07-01');
        $this->assertEquals(['opening' => 120, 'receipts' => 30, 'payments' => 10, 'closing' => 140, 'total_receipts' => 150, 'total_payments' => 150], $response->json('data.current.totals'));
        $this->assertEquals(['opening' => 60, 'receipts' => 110, 'payments' => 30, 'closing' => 140, 'total_receipts' => 170, 'total_payments' => 170], $response->json('data.fiscal.totals'));
        $this->assertSame('Renamed cash group', $response->json('data.current.groups.opening.0.name'));
        $this->getJson('/_test/receipts-payments?month=2025-09&branch_id=0')->assertOk()->assertJsonPath('data.current.totals.receipts', 80);
        $this->getJson('/_test/receipts-payments?month=2025-09&branch_id=99')->assertOk()->assertJsonPath('data.current.totals.receipts', 0);
    }

    public function test_receipts_payments_excludes_internal_transfers_and_non_cash_entries_and_preserves_mixed_cash_amounts(): void
    {
        $this->seedEarningsAccounts();
        AccountHead::findOrFail(50)->update(['system_key' => 'cash_in_hand']);
        AccountHead::findOrFail(51)->update(['system_key' => 'cash_at_bank']);
        $this->postEntry('2025-08-01', 1, 100);
        $transfer = DB::table('acc_journal_entries')->insertGetId(['date' => '2025-09-01', 'branch_id' => 1, 'status' => 'approved']);
        $this->insertDetail($transfer, [1, 10, 20, 50, 60], 0, 40);
        $this->insertDetail($transfer, [1, 11, 23, 51, 61], 40, 0);
        $this->postClosingEntry('2025-09-02', 80, 20);
        $mixed = DB::table('acc_journal_entries')->insertGetId(['date' => '2025-09-03', 'branch_id' => 1, 'status' => 'approved', 'voucher_type' => 'receipt']);
        $this->insertDetail($mixed, [1, 10, 20, 50, 60], 50, 0);
        $this->insertDetail($mixed, [4, 110, 111, 112, 113], 10, 0);
        $this->insertDetail($mixed, [3, 100, 101, 102, 103], 0, 60);
        $response = $this->getJson('/_test/receipts-payments?month=2025-09&depth=4')->assertOk();
        $this->assertEquals(50, $response->json('data.current.totals.receipts'));
        $this->assertEquals(0, $response->json('data.current.totals.payments'));
        $this->assertEquals(150, $response->json('data.current.totals.closing'));
        $receiptRows = collect($response->json('data.current.groups.receipts'))->keyBy('id');
        $this->assertEquals(60, $receiptRows[103]['amount']);
        $this->assertEquals(-10, $receiptRows[113]['amount']);
        $this->assertEquals(311101, $receiptRows[103]['code']);
        $this->assertSame('Account 411101', $receiptRows[113]['name']);
        $this->assertCount(2, $response->json('data.current.groups.closing'));
    }

    public function test_receipts_payments_requires_cash_mapping_and_valid_filters(): void
    {
        $this->getJson('/_test/receipts-payments?month=2026-09')->assertUnprocessable();
        foreach (['month=bad', 'month=2026-09&depth=5', 'month=2026-09&branch_id=-1'] as $query) {
            $this->getJson('/_test/receipts-payments?'.$query)->assertUnprocessable();
        }
    }

    public function test_receipts_payments_include_all_cash_voucher_types_and_reconcile(): void
    {
        $this->seedEarningsAccounts();
        AccountHead::findOrFail(50)->update(['system_key' => 'cash_in_hand']);
        $this->postEntry('2025-06-30', 1, 100);
        $this->postEntry('2025-07-01', 1, 40);
        $this->postEntry('2025-09-01', 1, 50);
        $this->postOperatingEntry('2025-09-02', 1, 30, 10);
        $response = $this->getJson('/_test/receipts-payments?month=2025-09')->assertOk();
        $this->assertEquals(140, $response->json('data.current.totals.opening'));
        $this->assertEquals(80, $response->json('data.current.totals.receipts'));
        $this->assertEquals(10, $response->json('data.current.totals.payments'));
        $this->assertEquals(210, $response->json('data.current.totals.closing'));
        foreach (['current', 'fiscal'] as $period) {
            $this->assertEquals(220, $response->json('data.'.$period.'.totals.total_receipts'));
            $this->assertEquals(220, $response->json('data.'.$period.'.totals.total_payments'));
        }
    }

    public function test_ledger_report_opening_running_balance_and_branch_filters(): void
    {
        $this->seedEarningsAccounts();
        $this->postEntry('2025-08-31', 1, 100);
        $this->postOperatingEntry('2025-09-01', 1, 50, 30, 'pending');
        $this->postEntry('2025-09-30', 2, 20);
        $this->postEntry('2025-10-01', 1, 900);
        $this->postEntry('2025-09-10', 1, 800, 'rejected');
        $query = 'start_date=2025-09-01&end_date=2025-09-30&account_type_id=1&account_category_id=10&control_group_id=20&ledger_group_id=50';
        $response = $this->getJson('/_test/ledger-report?'.$query)->assertOk();
        $this->assertEquals(100, $response->json('data.opening_balance'));
        $this->assertEquals([150, 120, 140], array_column($response->json('data.rows'), 'balance'));
        $this->assertEquals(['debit' => 70, 'credit' => 30, 'balance' => 140], $response->json('data.totals'));
        $this->assertSame('111101', (string) $response->json('data.rows.0.account_code'));
        $branch = $this->getJson('/_test/ledger-report?'.$query.'&branch_id=1&ledger_account_id=60')->assertOk();
        $this->assertCount(2, $branch->json('data.rows'));
        $this->assertEquals(120, $branch->json('data.totals.balance'));
        $this->getJson('/_test/ledger-report?'.$query.'&branch_id=99')->assertOk()->assertJsonPath('data.rows', [])->assertJsonPath('data.opening_balance', 0);
    }

    public function test_ledger_report_validates_hierarchy_dates_and_carries_opening_without_activity(): void
    {
        $this->seedAccounts();
        $this->postEntry('2025-08-01', 1, 40);
        $query = ['start_date' => '2025-09-01', 'end_date' => '2025-09-30', 'account_type_id' => 1, 'account_category_id' => 10, 'control_group_id' => 20, 'ledger_group_id' => 50];
        $this->getJson('/_test/ledger-report?'.http_build_query($query))->assertOk()->assertJsonPath('data.rows', [])->assertJsonPath('data.totals.balance', 40);
        foreach ([['end_date' => '2025-08-01'], ['control_group_id' => 23], ['ledger_account_id' => 62], ['branch_id' => -1], ['start_date' => 'invalid']] as $invalid) {
            $this->getJson('/_test/ledger-report?'.http_build_query(array_merge($query, $invalid)))->assertUnprocessable();
        }
        $this->getJson('/_test/ledger-report/accounts')->assertOk()->assertJsonPath('data.0.code', '100000');
    }

    public function test_ledger_report_supports_control_group_general_ledger_and_account_scopes(): void
    {
        $this->seedAccounts();
        DB::table('acc_account_heads')->insert([
            ['id' => 150, 'parent_id' => 20, 'code' => '111200', 'name' => 'Second ledger', 'type' => 'asset', 'is_debit' => true],
            ['id' => 160, 'parent_id' => 150, 'code' => '111201', 'name' => 'Second account', 'type' => 'asset', 'is_debit' => true],
        ]);
        $this->postEntry('2025-09-01', 1, 50);
        $journal = DB::table('acc_journal_entries')->insertGetId(['date' => '2025-09-02', 'branch_id' => 1, 'status' => 'approved']);
        $this->insertDetail($journal, [1, 10, 20, 150, 160], 30, 0);
        $this->insertDetail($journal, [2, 30, 40, 52, 62], 0, 30);
        $base = '/_test/ledger-report?start_date=2025-09-01&end_date=2025-09-30&account_type_id=1&account_category_id=10&control_group_id=20';
        $this->getJson($base)->assertOk()->assertJsonCount(2, 'data.rows')->assertJsonPath('data.totals.balance', 80);
        $this->getJson($base.'&ledger_group_id=50')->assertOk()->assertJsonCount(1, 'data.rows')->assertJsonPath('data.totals.balance', 50);
        $this->getJson($base.'&ledger_group_id=150&ledger_account_id=160')->assertOk()->assertJsonPath('data.totals.balance', 30);
        $this->getJson($base.'&ledger_account_id=160')->assertUnprocessable();
    }

    public function test_ledger_particulars_prefer_remarks_and_fall_back_to_voucher_narration(): void
    {
        $this->seedAccounts();
        foreach (['Amount paid to supplier.', 'Amount paid by customer.', null, '', '   '] as $remarks) {
            $id = DB::table('acc_journal_entries')->insertGetId([
                'date' => '2025-09-01', 'branch_id' => 1, 'status' => 'approved', 'narration' => '  Voucher narration  ',
            ]);
            $this->insertDetail($id, [1, 10, 20, 50, 60], 10, 0);
            DB::table('acc_journal_entry_details')->where('journal_entry_id', $id)->update(['remarks' => $remarks]);
        }
        $response = $this->getJson('/_test/ledger-report?start_date=2025-09-01&end_date=2025-09-30&account_type_id=1&account_category_id=10&control_group_id=20')->assertOk();
        $this->assertSame([
            'Amount paid to supplier.', 'Amount paid by customer.', 'Voucher narration', 'Voucher narration', 'Voucher narration',
        ], array_column($response->json('data.rows'), 'particulars'));
    }

    public function test_equity_four_periods_roll_forward_and_closing_journals_do_not_duplicate_surplus(): void
    {
        $this->seedEarningsAccounts();
        AccountHead::findOrFail(30)->update(['system_key' => 'equity_funds']);
        $this->postEntry('2025-07-01', 1, 100);
        $this->postOperatingEntry('2026-07-01', 1, 100, 40);
        $this->postOperatingEntry('2026-08-01', 1, 50, 10);
        $this->postOperatingEntry('2026-09-01', 1, 30, 10);
        $this->postClosingEntry('2026-09-02', 180, 60);
        $response = $this->getJson('/_test/changes-in-equity?month=2026-09')->assertOk();
        $this->assertEquals(['current' => 200, 'previous' => 160, 'fiscal' => 100, 'previous_fiscal' => 0], $response->json('data.opening'));
        $this->assertEquals(['current' => 220, 'previous' => 200, 'fiscal' => 220, 'previous_fiscal' => 100], $response->json('data.closing'));
        foreach ($response->json('data.periods') as $period) {
            $key = $period['key'];
            $movement = array_sum(array_map(fn ($row) => $row['amounts'][$key], $response->json('data.rows')));
            $this->assertEquals($response->json('data.closing.'.$key), $response->json('data.opening.'.$key) + $movement);
        }
        $this->assertSame('2026-08-01', $response->json('data.periods.1.start_date'));
        $this->assertSame('2025-07-01', $response->json('data.periods.3.start_date'));
        $this->assertSame('2026-06-30', $response->json('data.periods.3.end_date'));
    }

    public function test_equity_filters_branch_status_and_excludes_liabilities(): void
    {
        $this->seedEarningsAccounts();
        AccountHead::findOrFail(30)->update(['system_key' => 'equity_funds', 'name' => 'Renamed funds', 'code' => 215000]);
        $this->postOperatingEntry('2026-07-01', 1, 10, 0, 'pending');
        $this->postOperatingEntry('2026-07-01', 2, 30, 0);
        $this->postOperatingEntry('2026-07-01', 1, 800, 0, 'rejected');
        $this->postOperatingEntry('2026-08-01', 1, 900, 0);
        DB::table('acc_account_heads')->insert(['id' => 200, 'parent_id' => 2, 'code' => 220000, 'name' => 'Liabilities', 'type' => 'liability', 'is_debit' => false]);
        $journal = DB::table('acc_journal_entries')->insertGetId(['date' => '2026-07-01', 'branch_id' => 1, 'status' => 'approved']);
        $this->insertDetail($journal, [2, 200, 200, 200, 200], 0, 1000);
        $this->getJson('/_test/changes-in-equity?month=2026-07&branch_id=1')->assertOk()->assertJsonPath('data.closing.current', 10);
        $this->getJson('/_test/changes-in-equity?month=2026-07')->assertOk()->assertJsonPath('data.closing.current', 40);
        $this->getJson('/_test/changes-in-equity?month=2026-07&branch_id=99')->assertOk()->assertJsonPath('data.closing.current', 0);
        $this->getJson('/_test/changes-in-equity?month=2026-07')->assertJsonPath('data.periods.1.start_date', '2026-06-01');
    }

    public function test_equity_requires_mapping_and_valid_filters(): void
    {
        $this->getJson('/_test/changes-in-equity?month=2026-09')->assertUnprocessable();
        foreach (['month=bad', 'month=2026-09&depth=5', 'month=2026-09&branch_id=-1'] as $query) {
            $this->getJson('/_test/changes-in-equity?'.$query)->assertUnprocessable();
        }
    }

    public function test_cash_bank_book_tracks_opening_transfers_overdrafts_and_branch_filters(): void
    {
        $this->seedEarningsAccounts();
        AccountHead::findOrFail(50)->update(['system_key' => 'cash_in_hand', 'name' => 'Renamed cash']);
        AccountHead::findOrFail(51)->update(['system_key' => 'cash_at_bank']);
        $this->postEntry('2025-08-31', 1, 100);
        $transfer = DB::table('acc_journal_entries')->insertGetId(['date' => '2025-09-01', 'branch_id' => 1, 'status' => 'approved', 'narration' => 'Cash to bank transfer', 'voucher_no' => 'CV-1']);
        $this->insertDetail($transfer, [1, 10, 20, 50, 60], 0, 40);
        $this->insertDetail($transfer, [1, 11, 23, 51, 61], 40, 0);
        $this->postOperatingEntry('2025-09-30', 1, 0, 80, 'pending');
        $this->postEntry('2025-09-10', 2, 20);
        $this->postEntry('2025-09-15', 1, 999, 'rejected');
        $this->postEntry('2025-10-01', 1, 888);
        $response = $this->getJson('/_test/cash-bank-book?start_date=2025-09-01&end_date=2025-09-30&branch_id=1')->assertOk();
        $this->assertEquals(['cash' => 100, 'bank' => 0], $response->json('data.opening'));
        $this->assertEquals(['cash' => -20, 'bank' => 40], $response->json('data.closing'));
        $this->assertEquals([60, 60, -20], array_column($response->json('data.rows'), 'cash'));
        $this->assertEquals([0, 40, 40], array_column($response->json('data.rows'), 'bank'));
        $this->assertSame('Cash to bank transfer', $response->json('data.rows.0.particulars'));
        $this->assertSame('CV-1', $response->json('data.rows.0.voucher_no'));
        $this->assertEquals(['debit' => 40, 'credit' => 120], $response->json('data.totals'));
        $this->getJson('/_test/cash-bank-book?start_date=2025-09-01&end_date=2025-09-30')->assertOk()->assertJsonCount(4, 'data.rows')->assertJsonPath('data.closing.cash', 0);
    }

    public function test_cash_bank_book_carries_balances_in_empty_period_and_validates_dates_and_mapping(): void
    {
        $this->getJson('/_test/cash-bank-book?start_date=2025-09-01&end_date=2025-09-30')->assertUnprocessable();
        $this->seedAccounts();
        AccountHead::findOrFail(50)->update(['system_key' => 'cash_in_hand']);
        $this->postEntry('2025-08-01', 1, 100);
        $this->getJson('/_test/cash-bank-book?start_date=2025-09-01&end_date=2025-09-30')->assertOk()->assertJsonPath('data.rows', [])->assertJsonPath('data.opening.cash', 100)->assertJsonPath('data.closing.cash', 100);
        foreach (['start_date=bad&end_date=2025-09-30', 'start_date=2025-09-02&end_date=2025-09-01', 'start_date=2025-09-01&end_date=2025-09-30&branch_id=-1'] as $query) {
            $this->getJson('/_test/cash-bank-book?'.$query)->assertUnprocessable();
        }
    }

    public function test_cash_flow_classifies_periods_and_reconciles_to_cash_book(): void
    {
        $this->seedEarningsAccounts();
        AccountHead::findOrFail(50)->update(['system_key' => 'cash_in_hand']);
        foreach ([3 => 'operating', 4 => 'operating', 21 => 'investing', 30 => 'financing'] as $id => $activity) AccountHead::findOrFail($id)->update(['cash_flow_activity' => $activity]);
        $this->postEntry('2025-06-30', 1, 100);
        $this->postOperatingEntry('2025-07-01', 1, 10, 0);
        $this->postOperatingEntry('2025-09-01', 1, 100, 40);
        $this->postEntry('2025-09-02', 1, 50);
        $purchase = DB::table('acc_journal_entries')->insertGetId(['date' => '2025-09-03', 'branch_id' => 1, 'status' => 'approved']);
        $this->insertDetail($purchase, [1, 10, 21, 21, 21], 20, 0);
        $this->insertDetail($purchase, [1, 10, 20, 50, 60], 0, 20);
        $this->postOperatingEntry('2025-09-01', 2, 200, 0);
        $this->postOperatingEntry('2025-09-01', 1, 700, 0, 'rejected');
        $this->postOperatingEntry('2025-10-01', 1, 900, 0);
        $response = $this->getJson('/_test/cash-flow-statement?month=2025-09&branch_id=1')->assertOk();
        $totals = $response->json('data.current.totals');
        $this->assertEquals(110, $totals['opening']);
        $this->assertEquals(60, $totals['operating']);
        $this->assertEquals(-20, $totals['investing']);
        $this->assertEquals(50, $totals['financing']);
        $this->assertEquals(200, $totals['closing']);
        $this->assertEquals(0, $totals['difference']);
        $this->assertEquals(70, $response->json('data.fiscal.totals.operating'));
        $this->assertEquals(100, $response->json('data.fiscal.totals.opening'));
        $book = $this->getJson('/_test/cash-bank-book?start_date=2025-09-01&end_date=2025-09-30&branch_id=1')->assertOk();
        $this->assertEquals($book->json('data.closing.cash'), $totals['closing']);
        $this->getJson('/_test/cash-flow-statement?month=2025-09')->assertOk()->assertJsonPath('data.current.totals.closing', 400);
    }

    public function test_cash_flow_flags_ambiguous_allocation_and_honours_inherited_overrides(): void
    {
        $this->seedEarningsAccounts();
        AccountHead::findOrFail(50)->update(['system_key' => 'cash_in_hand']);
        AccountHead::findOrFail(3)->update(['cash_flow_activity' => 'operating']);
        AccountHead::findOrFail(4)->update(['cash_flow_activity' => 'investing']);
        $id = DB::table('acc_journal_entries')->insertGetId(['date' => '2025-09-01', 'branch_id' => 1, 'status' => 'approved']);
        $this->insertDetail($id, [1, 10, 20, 50, 60], 50, 0);
        $this->insertDetail($id, [3, 100, 101, 102, 103], 0, 60);
        $this->insertDetail($id, [4, 110, 111, 112, 113], 10, 0);
        $this->getJson('/_test/cash-flow-statement?month=2025-09')->assertOk()->assertJsonPath('data.current.totals.unclassified', 50)->assertJsonPath('data.current.totals.difference', 0);
        AccountHead::findOrFail(113)->update(['cash_flow_activity' => 'operating', 'name' => 'Renamed expense']);
        $this->getJson('/_test/cash-flow-statement?month=2025-09')->assertOk()->assertJsonPath('data.current.totals.operating', 50)->assertJsonPath('data.current.totals.unclassified', 0);
    }

    public function test_cash_flow_excludes_transfers_and_non_cash_journals(): void
    {
        $this->seedEarningsAccounts();
        AccountHead::findOrFail(50)->update(['system_key' => 'cash_in_hand']);
        AccountHead::findOrFail(51)->update(['system_key' => 'cash_at_bank']);
        $this->postEntry('2025-08-01', 1, 100);
        $id = DB::table('acc_journal_entries')->insertGetId(['date' => '2025-09-01', 'branch_id' => 1, 'status' => 'approved']);
        $this->insertDetail($id, [1, 10, 20, 50, 60], 0, 40);
        $this->insertDetail($id, [1, 11, 23, 51, 61], 40, 0);
        $this->postClosingEntry('2025-09-01', 80, 20);
        $this->getJson('/_test/cash-flow-statement?month=2025-09')->assertOk()->assertJsonPath('data.current.totals.net_change', 0)->assertJsonPath('data.current.totals.closing', 100)->assertJsonPath('data.current.totals.difference', 0);
        $this->getJson('/_test/cash-flow-statement?month=bad')->assertUnprocessable();
    }

    private function seedEarningsAccounts(): void
    {
        $this->seedAccounts();
        foreach ([
            [4, 400000, null, 'expense', true],
            [100, 310000, 3, 'income', false], [101, 311000, 100, 'income', false],
            [102, 311100, 101, 'income', false], [103, 311101, 102, 'income', false],
            [110, 410000, 4, 'expense', true], [111, 411000, 110, 'expense', true],
            [112, 411100, 111, 'expense', true], [113, 411101, 112, 'expense', true],
            [70, 213000, 30, 'liability', false], [71, 213100, 70, 'liability', false], [72, 213101, 71, 'liability', false],
        ] as [$id, $code, $parentId, $type, $isDebit]) {
            DB::table('acc_account_heads')->insert(['id' => $id, 'code' => $code, 'parent_id' => $parentId, 'name' => 'Account '.$code, 'type' => $type, 'is_debit' => $isDebit]);
        }
        AccountHead::findOrFail(70)->update(['system_key' => AccountHead::INCOME_OVER_EXPENDITURE_KEY]);
    }

    private function postOperatingEntry(string $date, int $branch, float $income, float $expense, string $status = 'approved'): void
    {
        foreach ([['income', $income], ['expense', $expense]] as [$type, $amount]) {
            if ($amount === 0.0) {
                continue;
            }
            $id = DB::table('acc_journal_entries')->insertGetId(['date' => $date, 'branch_id' => $branch, 'status' => $status, 'voucher_type' => $type === 'income' ? 'Receipt Voucher' : 'Payment Voucher']);
            if ($type === 'income') {
                $this->insertDetail($id, [1, 10, 20, 50, 60], $amount, 0);
                $this->insertDetail($id, [3, 100, 101, 102, 103], 0, $amount);
            } else {
                $this->insertDetail($id, [4, 110, 111, 112, 113], $amount, 0);
                $this->insertDetail($id, [1, 10, 20, 50, 60], 0, $amount);
            }
        }
    }

    private function postClosingEntry(string $date, float $income, float $expense): void
    {
        $id = DB::table('acc_journal_entries')->insertGetId(['date' => $date, 'branch_id' => 1, 'status' => 'approved']);
        $this->insertDetail($id, [3, 100, 101, 102, 103], $income, 0);
        $this->insertDetail($id, [4, 110, 111, 112, 113], 0, $expense);
        $this->insertDetail($id, [2, 30, 70, 71, 72], 0, $income - $expense);
    }

    private function reportAccount(array $accounts, $id): ?array
    {
        foreach ($accounts as $account) {
            if ($account['id'] === $id) {
                return $account;
            }
            if ($found = $this->reportAccount($account['children'], $id)) {
                return $found;
            }
        }
        return null;
    }

    private function seedAccounts(): void
    {
        foreach ([
            [2, 200000, null, 'liability', false],
            [1, 100000, null, 'asset', true],
            [3, 300000, null, 'income', false],
            [12, 130000, 1, 'asset', true],
            [11, 120000, 1, 'asset', false],
            [10, 110000, 1, 'asset', true],
            [21, 112000, 10, 'asset', true],
            [20, 111000, 10, 'asset', true],
            [23, 121000, 11, 'asset', false],
            [30, 210000, 2, 'liability', true],
            [40, 211000, 30, 'liability', true],
            [50, 111100, 20, 'asset', true],
            [60, 111101, 50, 'asset', true],
            [51, 121100, 23, 'asset', false],
            [61, 121101, 51, 'asset', false],
            [52, 211100, 40, 'liability', true],
            [62, 211101, 52, 'liability', true],
        ] as [$id, $code, $parentId, $type, $isDebit]) {
            DB::table('acc_account_heads')->insert([
                'id' => $id,
                'name' => 'Account '.$code,
                'code' => (string) $code,
                'parent_id' => $parentId,
                'type' => $type,
                'is_debit' => $isDebit,
            ]);
        }
    }

    private function postEntry(string $date, int $branch, float $amount, string $status = 'approved'): void
    {
        $journalId = DB::table('acc_journal_entries')->insertGetId([
            'date' => $date,
            'branch_id' => $branch,
            'status' => $status,
        ]);

        $this->insertDetail($journalId, [1, 10, 20, 50, 60], $amount, 0);
        $this->insertDetail($journalId, [2, 30, 40, 52, 62], 0, $amount);
    }

    private function postContraEntry(float $amount): void
    {
        $journalId = DB::table('acc_journal_entries')->insertGetId([
            'date' => '2025-02-12',
            'branch_id' => 1,
            'status' => 'approved',
        ]);

        $this->insertDetail($journalId, [1, 11, 23, 51, 61], 0, $amount);
        $this->insertDetail($journalId, [2, 30, 40, 52, 62], $amount, 0);
    }

    private function insertDetail(int $journalId, array $accountIds, float $debit, float $credit): void
    {
        DB::table('acc_journal_entry_details')->insert([
            'journal_entry_id' => $journalId,
            'account_type_id' => $accountIds[0],
            'account_category_id' => $accountIds[1],
            'control_group_id' => $accountIds[2],
            'ledger_group_id' => $accountIds[3],
            'ledger_account_id' => $accountIds[4],
            'debit' => $debit,
            'credit' => $credit,
        ]);
    }

    private function assertTotals(array $account, float $debit, float $credit, float $balance): void
    {
        $this->assertEquals($debit, $account['total_debit']);
        $this->assertEquals($credit, $account['total_credit']);
        $this->assertEquals($balance, $account['balance']);
    }
}
