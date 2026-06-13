<?php 
namespace Modules\Inventory\Services\Payment;

use Illuminate\Support\Facades\DB;
use Modules\Inventory\Services\Accounts\TypeAccountResolver;


abstract class BasePayment {

    
    public function __construct(
        protected TypeAccountResolver $typeAccountResolver
    ) {}

     protected function modelClass() {}


     protected function relationKey() {}

    public function storeOrUpdate(array $data, ?int $id = null)
    {
        return DB::transaction(function () use ($data, $id) {

            $isUpdate = $id !== null;

            if (!$id) {
                $data['invoice_no'] = $this->generateInvoiceNo();
            }

            $model = $id
                ? $this->update($id, $data)
                : $this->create($data);

            $this->after($model, $data, $isUpdate);

            return $model;
        });
    }


    protected function create(array $data)
    {
        $class = $this->modelClass();

        return $class::create(array_merge($data, [
            'created_by' => auth()->id(),
        ]));

    }


   protected function update(int $id, array $data)
    {
        $class = $this->modelClass();

        $model = $class::findOrFail($id);

        $model->update($data);

        return $model;
    }


    protected function after($model,$data, bool $isUpdate)
    {
        // override in child
    }

     protected function prefix()
    {
        // override in child
    }

    public function delete(int $id): void
    {
        DB::transaction(function () use ($id) {
            $class = $this->modelClass();
            $model = $class::findOrFail($id);

            $this->afterDelete($model);
            $model->delete();

        });
    }

    protected function afterDelete($model): void
    {
        
    }

    protected function generateInvoiceNo(): string
    {
        $prefix = $this->prefix();
        $class = $this->modelClass();
        $lastInvoiceNo = $class::where('invoice_no', 'like', $prefix . '%')
            ->latest('invoice_no')
            ->value('invoice_no');

        $nextNumber = 1;

        if ($lastInvoiceNo) {
            $lastNumber = (int) substr($lastInvoiceNo, strlen($prefix));
            $nextNumber = $lastNumber + 1;
        }

        $paddedNumber = str_pad($nextNumber, 4, '0', STR_PAD_LEFT);

        return $prefix . $paddedNumber;
    }


    protected function paymentData($model, $data){

        $paymentData =  $data;
        $paymentData['date']                    = $data['payment_date'];
        $paymentData['adjustment']              = $data['adjustment'];
        $paymentData['payment']                 = $data['payment'];
        $paymentData['amount']                  = $data['payment'];
        $paymentData['total_amount']            = $model->total_amount;
        $paymentData['reference_id']            = $model->id;
        $paymentData['reference_no']            = $model->invoice_no;

        return $paymentData;

    }



}