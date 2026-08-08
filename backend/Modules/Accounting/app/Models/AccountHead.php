<?php

namespace Modules\Accounting\Models;
use Illuminate\Database\Eloquent\Builder;
use InvalidArgumentException;
use RuntimeException;

class AccountHead extends AccBaseModel
{
    protected $fillable = [
        'name', 'code', 'parent_id', 'type', 'is_debit', 'remarks', 'branch_id', 'status'
    ];

      protected $casts = [
        'code' => 'integer',
        'is_debit' => 'boolean',
        'status' => 'boolean',
    ];

    protected array $searchable = ['name', 'code'];


    public function parent()
    {
        return $this->belongsTo(AccountHead::class, 'parent_id');
    }

    public function children()
    {
        return $this->hasMany(AccountHead::class, 'parent_id');
    }

    public function childrenRecursive()
    {
        return $this->children()->with('childrenRecursive');
    }


      /*
    |--------------------------------------------------------------------------
    | Main Account Types
    |--------------------------------------------------------------------------
    */


    public const MAIN_CODES = [
        'asset'     => 100000,
        'liability' => 200000,
        'equity'    => 300000,
        'income'    => 400000,
        'expense'   => 500000,
    ];


     /* Root account */
    public function root(): self
    {
        $account = $this;

        while ($account->parent_id) {
            $account = $account->parent;

            if (!$account) {
                break;
            }
        }

        return $account;
    }

    /* Root type from parent_id */
    public function getRootTypeAttribute(): ?string
    {
        return $this->root()->type;
    }

    /* Account level */
    public function getLevelAttribute(): int
    {
        $level = 0;
        $account = $this;

        while ($account->parent_id && $level < 10) {
            $account = $account->parent;

            if (!$account) {
                break;
            }

            $level++;
        }

        return $level;
    }

    /* Type from code */
    public static function typeFromCode(int $code): ?string
    {
        return match ((int) ($code / 100000)) {
            1 => 'asset',
            2 => 'liability',
            3 => 'equity',
            4 => 'income',
            5 => 'expense',
            default => null,
        };
    }

    /* Main code */
    public static function mainCode(string $type): int
    {
        return self::MAIN_CODES[$type]
            ?? throw new InvalidArgumentException(
                "Invalid account type: {$type}"
            );
    }

    /* Generate next child code only */
    public static function nextChildCode(self $parent): int
    {
        $increment = match ($parent->level) {
            0 => 10000,
            1 => 1000,
            2 => 100,
            3, 4 => 1,
            default => throw new RuntimeException(
                'Maximum account level reached.'
            ),
        };

        $lastCode = self::where(
            'parent_id',
            $parent->id
        )->max('code');

        return ($lastCode ?: $parent->code) + $increment;
    }

    public function scopeMain(Builder $query): Builder
    {
        return $query->whereNull('parent_id');
    }

    public function scopeActive(Builder $query): Builder
    {
        return $query->where('status', true);
    }
    
}
