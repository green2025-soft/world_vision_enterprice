<?php

namespace Modules\Core\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Modules\Core\Traits\ApiResponse;

class BaseApiController extends Controller
{
    use ApiResponse;

    protected $model; // Eloquent model class like Role::class, User::class

    protected string $title;

    /**
     * Return paginated list response
     */
    protected function listResponse($paginated)
    {
        return $this->paginated($paginated, "{$this->title} list fetched successfully.");
    }

    protected function allItems(){
        $data = $this->indexQuery();
        return $this->listItems($data->get(), "{$this->title} list fetched successfully.");

    }

    /**
     * Return response after resource creation
     */
    protected function createdResponse($data)
    {
        return $this->created($data, "{$this->title} created successfully.");
    }

    /**
     * Return response for successful data fetch
     */
    protected function successResponse($data)
    {
        return $this->success($data, "{$this->title} fetched successfully.");
    }

    /**
     * Return response after resource update
     */
    protected function updatedResponse($data)
    {
        return $this->success($data, "{$this->title} updated successfully.");
    }

    /**
     * Return response after resource deletion
     */
    protected function deletedResponse()
    {
        return $this->success(null, "{$this->title} deleted successfully.");
    }
	
	public function indexQuery()
	{
		$query = ($this->model)::query();
		return $query->search()->orderByDesc('id');
	}

    /**
     * Display a listing of the resource.
     */
    public function indexData()
    {
        $data = $this->indexQuery()->smartPaginate();
        return $this->listResponse($data);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function saveData($request)
    {
        // validation should be called before this method in the controller
        $createData = ($this->model)::create($request->all());
        return $this->createdResponse($createData);
    }

    /**
     * Display the specified resource.
     */
		public function showData($id, $with = null)
		{
			$query = ($this->model)::query();

			if ($with) {
				$query->with($with);
			}

			$data = $query->findOrFail($id);

			return $this->successResponse($data);
		}


    /**
     * Update the specified resource in storage.
     */
    public function updateData($request, $id)
    {
        $updateData = ($this->model)::findOrFail($id);
        $updateData->update($request->all());
        return $this->updatedResponse($updateData);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroyData($id)
    {
        ($this->model)::where('id', $id)->delete();
        return $this->deletedResponse();
    }
}
