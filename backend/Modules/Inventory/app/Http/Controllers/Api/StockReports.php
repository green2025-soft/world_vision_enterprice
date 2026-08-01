<?php

namespace Modules\Inventory\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;
use Illuminate\Http\Request;
use Modules\Inventory\Services\Inventory\Stock\StockReportService;



class StockReports extends BaseApiController
{

    
    protected string $title = 'Stock Report';

    public function __construct()
    {
        
    }

    public function index(Request $request, StockReportService $stockReport)
    {
         $request->validate([
            'product_id'    => 'nullable|integer',
            'branch_id'     => 'required|integer|min:1',
            'from_date'     => 'required|date',
            'to_date'       => 'required|date|after_or_equal:from_date',
        ]);

        $filters = [
            'product_id'    => $request->product_id,
            'branch_id'     => $request->branch_id,
            'from_date'     => $request->from_date,
            'to_date'       => $request->to_date,
        ];

        return $this->successResponse($stockReport->getStockReport($filters));
    }

   

 
}
