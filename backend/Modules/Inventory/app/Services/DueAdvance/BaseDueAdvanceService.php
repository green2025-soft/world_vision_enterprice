<?php

namespace Modules\Inventory\Services\DueAdvance;

use Illuminate\Support\Facades\DB;
use Modules\Inventory\Services\Accounts\TypeAccountResolver;
abstract class BaseDueAdvanceService
{
    protected string $type;
    protected string $referencePrefix;
    protected int $referenceLength = 4;
    protected string $referenceKey = 'reference_no';

    protected function modelClass() {}

    public function __construct(protected TypeAccountResolver $typeAccountResolver){}

     public function storeOrUpdate(array $data, ?int $id = null)
    {
        return DB::transaction(function () use ($data, $id) {
               $modelClass = $this->modelClass();
               if(!$id || $this->referenceKey == 'id'){
                    $data['reference_no'] = $this->generateReferenceNo($id);
               }
               $data = $this->prepareData($data);
               $model = $id ? $modelClass::findOrFail($id): new $modelClass();
               $model->fill($data)->save();

               $data['reference_id']        = $model->id;
               $accountData = $this->prepareAccountingData($data,  $model);
               
               $this->typeAccountResolver->resolve($this->type)->recordTransaction($accountData, $this->type);
               return $model;
        });
    }

    abstract protected function prepareData(array $data): array;
    abstract protected function prepareAccountingData(array $data, $model): array;

    protected function generateReferenceNo(?int $id = null): string
    {
        $modelClass = $this->modelClass();
        $number     = 1;
        $lastRef    = '';
        if($this->referenceKey =='id'){
            $number = $id ?? ((int) $modelClass::max('id') + 1);
        }else{
        $lastRef = $modelClass::where($this->referenceKey, 'like', $this->referencePrefix . '%')
            ->orderBy('id', 'desc')->value($this->referenceKey);
        }

        $number = $lastRef ? (int) str_replace($this->referencePrefix,'',$lastRef) + 1: $number;
        
        return $this->referencePrefix.str_pad($number, $this->referenceLength,'0', STR_PAD_LEFT);
    }

    protected function prepareDeleteAccountingData($model): array
    {
        return [
            'source'   => $this->type,
            'sourceId' => $model->id,
        ];
    }


    public function delete( $model)
    {
        return DB::transaction(function () use ($model) {
             $accountData = $this->prepareDeleteAccountingData($model);
             $this->typeAccountResolver->resolve($this->type)->deleteEntry($accountData);
             $model->delete();
        });
    }

}