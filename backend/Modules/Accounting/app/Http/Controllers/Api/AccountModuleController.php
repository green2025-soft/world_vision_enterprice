<?php
namespace Modules\Accounting\Http\Controllers\Api;

use Modules\Core\Http\Controllers\Api\BaseApiController;
use Modules\Accounting\Models\AccountModule;
use Modules\Accounting\Http\Requests\AccountModuleRequest;
use Modules\Accounting\Models\AuditLog;
use Illuminate\Support\Facades\DB;

class AccountModuleController extends BaseApiController
{
    protected string $title = 'Account Module';

    public function __construct()
    {
        $this->model = AccountModule::class;
    }

    public function index()
    {
        $query = $this->indexQuery()->with('accountHeads', 'accounts');
        return $this->listResponse($query->smartPaginate());
    }

    public function store(AccountModuleRequest $request)
    {
        $validated = $request->validated();

        DB::beginTransaction();

        $data = $validated;
        unset($data['accounts']);

        $entry = $this->model::create($data);

        foreach ($validated['accounts'] as $acc) {
            $entry->accounts()->create($acc);
        }

        $response = $this->createdResponse($entry);

        AuditLog::record("Created {$this->title}", [
            'module_entry_id' => $entry->id,
            'data' => $response->getData()->data 
        ], $entry->id);

        DB::commit();

        return $response;
    }

    public function show($id)
    {
        return $this->showData($id, ['accounts', 'accountHeads']);
    }

    public function update(AccountModuleRequest $request, $id)
    {
        $validated = $request->validated();

        DB::beginTransaction();

        $entry = $this->model::findOrFail($id);
        $oldData = $entry->load('accounts')->toArray();

        $entry->update($validated);
        $entry->accounts()->delete();

        foreach ($validated['accounts'] as $acc) {
            $entry->accounts()->create($acc);
        }

        AuditLog::record("Updated {$this->title}", [
            'module_entry_id' => $entry->id,
            'old' => $oldData,
            'new' => $validated
        ],  $id);

        DB::commit();

        return $this->updatedResponse($entry->load('accounts'));
    }

    public function destroy($id)
    {
        $entry = $this->model::with('accounts')->findOrFail($id);

        AuditLog::record("Deleted {$this->title}", [
            'module_entry_id' => $entry->id,
            'data' => $entry->toArray()
        ],  $id);

        return $this->destroyData($id);
    }
}
