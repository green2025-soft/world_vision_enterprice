<?php

namespace Modules\Accounting\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Accounting\Models\AccountHead;
use Modules\Accounting\Http\Requests\AccountHeadRequest;
use Modules\Accounting\Models\AuditLog;
use Illuminate\Support\Facades\DB;
use Modules\Accounting\Models\VoucherType;

class ChartOfAccountController extends BaseApiController
{
    protected string $title = 'Chart Of Account';

    public function __construct()
    {
        $this->model = AccountHead::class;
    }

    public function index()
    {
        $query = $this->model::whereNull('parent_id')
            ->with('childrenRecursive');
            
        return $this->listItems($query->get(), "{$this->title} list fetched successfully.");
        
    }

    public function store(AccountHeadRequest $request)
    {
        $data               = $request->validated();

        DB::beginTransaction();
        $parent             = $this->model::find($data['parent_id']);
        $data['type']       = $parent->type;
        $data['is_debit']   = $parent->is_debit;
        $data['code']       = $this->codeNo($data['parent_id'], true);
        
        $data               = $this->model::create($data);
 
        $response = $this->createdResponse( $data);
        
        $resData = $response->getData()->data;
    
        AuditLog::record('Created '.$this->title, [
            'data' => $resData
        ], $resData->code);

        DB::commit();
        return $response;
    }

    public function show($id)
    {
        return $this->showData($id);
    }

    public function update(AccountHeadRequest $request, $id)
    {
        
        $validated  = $request->validated();
        DB::beginTransaction();
        $oldData    = $this->model::find($id);
        $this->model::where('id', $id)->whereNotNull('parent_id')->update($validated);
        $response   = $this->updateData($request, $id);

        AuditLog::record('Updated '.$this->title, [
            'id'    => $id,
            'old'   => $oldData,
            'new'   => $response->getData()->data,
        ], $oldData->code);
        DB::commit();
        return $response;
    }

    public function destroy($id)
    {
        $accountHead = $this->model::where('id', $id)->whereNotNull('parent_id')->firstOrFail();
        AuditLog::record('Deleted '.$this->title, [
            'id'    => $id,
            'data'  => $accountHead
        ], $accountHead->code);

        return $this->destroyData($id);
    }



    public function codeNo($parentId, $isController = false)
    {
        return DB::transaction(function () use ($parentId, $isController) {
            // Step 1: Parent must exist
            $parent = AccountHead::findOrFail($parentId);

            $childIds = $this->getAllDescendantIds($parentId);
            
            $newCode = null;

            if (empty($childIds)) {

                $newCodeInt = (int)$parent->code + 1;
                $newCode = str_pad($newCodeInt, 5, '0', STR_PAD_LEFT);
            } else {
                
                $lastCode = AccountHead::whereIn('id', $childIds)->max('code');
                $newCodeInt = (int)$lastCode + 1;
                $newCode = str_pad($newCodeInt, 5, '0', STR_PAD_LEFT);
            }

            $exists = AccountHead::where('code', $newCode)->exists();

            if ($exists) {
                return $this->codeNo($parentId, $isController);
            }

            return $isController ? $newCode : $this->successResponse($newCode);
        });
    }

    private function getAllDescendantIds($parentId): array
    {
        $ids = [];

        $children = AccountHead::where('parent_id', $parentId)->get();

        foreach ($children as $child) {
            $ids[] = $child->id;
            $ids = array_merge($ids, $this->getAllDescendantIds($child->id));
        }

        return $ids;
    }




    public function accountHeads($id=''){
        $query = $this->indexQuery()->whereNotNull('parent_id')->where('status',1);
        if ($id){
              return $this->showData($id);
        }
        return $this->listResponse($query->smartPaginate());
    }

    

    public function voucherTypes(){
        $query = VoucherType::whereNotNull('is_manual');
        return $this->listResponse($query->smartPaginate());
    }
}
