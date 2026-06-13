<?php

namespace Modules\Inventory\Services\Inventory\Stock;

class StockType
{
    public const PURCHASE = 'purchase';
    public const SALE = 'sale';
    public const SALE_RETURN = 'sale_return';
    public const PURCHASE_RETURN = 'purchase_return';
    public const TRANSFER = 'transfer';
    public const WASTAGE = 'wastage';
    public const ADJUSTMENT = 'adjustment';

    public static function isStockIn(string $type): bool
    {
        return in_array($type, [
            self::PURCHASE,
            self::SALE_RETURN,
            self::ADJUSTMENT,
            self::TRANSFER, // optional
        ]);
    }

    public static function isStockOut(string $type): bool
    {
        return in_array($type, [
            self::SALE,
            self::PURCHASE_RETURN,
            self::WASTAGE,
        ]);
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