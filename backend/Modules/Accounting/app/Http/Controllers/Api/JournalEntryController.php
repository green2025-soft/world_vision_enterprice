<?php

namespace Modules\Accounting\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Accounting\Models\JournalEntry;
use Modules\Accounting\Http\Requests\JournalEntryRequest;
use Modules\Accounting\Services\AccountEntryService;

class JournalEntryController extends BaseApiController
{
    protected string $title = 'Journal Entry';

    protected AccountEntryService $service;

    public function __construct(AccountEntryService $service)
    {
        $this->model = JournalEntry::class;
        $this->service = $service;
    }

    public function index()
    {
        $query = $this->indexQuery()->with('details.accountHead');
        return $this->listResponse($query->smartPaginate());
    }

    public function store(JournalEntryRequest $request)
    {
        $entry = $this->service->createEntry($request->validated());
        return $this->createdResponse($entry->load('details.accountHead'));
    }

    public function show($id)
    {
        return $this->showData($id, ['details.accountHead']);
    }

    public function update(JournalEntryRequest $request, $id)
    {
        
        $entry = $this->service->updateEntry($id, $request->validated());
        return $this->updatedResponse($entry->load('details.accountHead'));
    }

    public function destroy($id)
    {
        $this->service->deleteEntry($id);
        return $this->deletedResponse();
    }
    public function generateReferenceNo(){

        return $this->successResponse($this->service->generateReferenceNo());

    }
}
