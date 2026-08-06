<?php

namespace Modules\Inventory\Services\Inventory\Stock;

class StockType
{
    public const PURCHASE         = 'purchase';
    public const SALE             = 'sale';
    public const PURCHASE_RETURN  = 'purchase_return';
    public const SALE_RETURN      = 'sale_return';
    public const TRANSFER_IN      = 'transfer_in';
    public const TRANSFER_OUT     = 'transfer_out';
    public const ADJUSTMENT_IN    = 'adjustment_in';
    public const ADJUSTMENT_OUT   = 'adjustment_out';
    public const DAMAGE           = 'damage';
    public const WASTAGE          = 'wastage';

    public static function stockIn(): array
    {
        return [
            self::PURCHASE,
            self::TRANSFER_IN,
            self::SALE_RETURN,
            self::ADJUSTMENT_IN,
        ];
    }

    public static function stockOut(): array
    {
        return [
            self::SALE,
            self::TRANSFER_OUT,
            self::PURCHASE_RETURN,
            self::ADJUSTMENT_OUT,
            self::DAMAGE,
            self::WASTAGE,
        ];
    }

    public static function isStockIn(string $type): bool
    {
        return in_array($type, self::stockIn());
    }

    public static function isStockOut(string $type): bool
    {
        return in_array($type, self::stockOut());
    }


    public static function stockInTypes(): array
    {
        return self::stockIn();
    }

    public static function stockTypesByName(): array
    {
        return [
            self::PURCHASE         => 'Purchase',
            self::SALE             => 'Sale',
            self::PURCHASE_RETURN  => 'Purchase Return',
            self::SALE_RETURN      => 'Sale Return',
            self::TRANSFER_IN      => 'Transfer In',
            self::TRANSFER_OUT     => 'Transfer Out',
            self::ADJUSTMENT_IN    => 'Adjustment In',
            self::ADJUSTMENT_OUT   => 'Adjustment Out',
            self::DAMAGE           => 'Damage',
            self::WASTAGE          => 'Wastage',
        ];
    }

     public static function getTypeName(string $type): string
    {
        return self::stockTypesByName()[$type] ?? ucfirst(str_replace('_', ' ', $type));
    }

    public static function stockOutTypes(): array
    {
        return self::stockOut();
    }

    public static function reverseType(string $type): ?string
    {
        return match ($type) {
            self::SALE_RETURN     => self::SALE,
            self::PURCHASE_RETURN => self::PURCHASE,
            default              => null,
        };
    }

   
}