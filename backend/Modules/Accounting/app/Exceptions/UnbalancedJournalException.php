<?php

namespace Modules\Accounting\Exceptions;

use RuntimeException;

class UnbalancedJournalException extends RuntimeException
{
    public function __construct(
        float $debit,
        float $credit
    ) {
        parent::__construct(
            "Journal is not balanced. " .
            "Debit: {$debit}, Credit: {$credit}."
        );
    }
}
