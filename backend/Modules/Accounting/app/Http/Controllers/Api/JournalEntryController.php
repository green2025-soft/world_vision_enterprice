<?php

namespace Modules\Accounting\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Accounting\Models\JournalEntry;
use Modules\Accounting\Http\Requests\JournalEntryRequest;
use Modules\Accounting\Services\JournalEntryService;

class JournalEntryController extends BaseApiController
{
    protected string $title = 'Journal Entry';

    protected JournalEntryService $service;

    public function __construct(JournalEntryService $service)
    {
        $this->model = JournalEntry::class;
        $this->service = $service;
    }

    public function index()
    {
        $query = $this->indexQuery()->with('details.ledgerAccount');
        return $this->listResponse($query->smartPaginate());
    }

    public function store(JournalEntryRequest $request)
    {
        $entry = $this->service->create($request->validated());
        return $this->createdResponse($entry->load('details.ledgerAccount'));
    }

    public function show($id)
    {
        return $this->showData($id, ['details.ledgerAccount', 'branch']);
    }

    public function update(JournalEntryRequest $request, $id)
    {
        $entry = $this->model::findOrFail($id);

        if (!is_null($entry->source_id)) {
            return response()->json([
                'message' => 'This journal entry is auto-generated and cannot be edited.',
            ], 403);
        }

        
        $entry = $this->service->update($id, $request->validated());
        return $this->updatedResponse($entry->load('details.ledgerAccount'));
    }

    public function destroy($id)
    {
        $entry = $this->model::findOrFail($id);

        if (!is_null($entry->source_id)) {
            return response()->json([
                'message' => 'This journal entry is auto-generated and cannot be edited.',
            ], 403);
        }
        $this->service->delete($id);
        return $this->deletedResponse();
    }

    public function generateReferenceNo(){

        return $this->successResponse($this->service->generateReferenceNo());

    }
}
