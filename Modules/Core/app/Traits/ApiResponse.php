<?php 
namespace Modules\Core\Traits;

use Illuminate\Http\JsonResponse;

trait ApiResponse
{
    protected function respond(
        bool $status,
        string $message,
        int $code = 200,
        mixed $data = null,
        array $extra = []
    ): JsonResponse {
        $response = [
            'status' => $status,
            'message' => $message,
        ];

        if (!is_null($data)) {
            $response['data'] = $data;
        }

        return response()->json(array_merge($response, $extra), $code);
    }

    public function success(mixed $data = null, string $message = 'Success'): JsonResponse
    {
        return $this->respond(true, $message, 200, $data);
    }

    public function created(mixed $data = null, string $message = 'Created'): JsonResponse
    {
        return $this->respond(true, $message, 201, $data);
    }


      public function listItems(mixed $data = null, string $message = 'Success'): JsonResponse
    {
        return $this->respond(true, $message, 200, $data);
    }

    public function noContent(string $message = 'No Content'): JsonResponse
    {
        return $this->respond(true, $message, 204);
    }

    public function error(string $message = 'Server Error', int $code = 500, mixed $data = null): JsonResponse
    {
        return $this->respond(false, $message, $code, $data);
    }

    public function notFound(string $message = 'Resource not found'): JsonResponse
    {
        return $this->respond(false, $message, 404);
    }

    public function unauthorized(string $message = 'Unauthorized'): JsonResponse
    {
        return $this->respond(false, $message, 401);
    }

    public function forbidden(string $message = 'Forbidden'): JsonResponse
    {
        return $this->respond(false, $message, 403);
    }

    public function validationError(array $errors, string $message = 'Validation failed'): JsonResponse
    {
        return $this->respond(false, $message, 422, null, ['errors' => $errors]);
    }

   public function paginated($collection, string $message = 'Success'): JsonResponse
    {
        if ($collection instanceof \Illuminate\Contracts\Pagination\Paginator) {

            return $this->respond(true, $message, 200, $collection->items(), [
                'pagination' => [
                    'total' => $collection->total(),
                    'per_page' => $collection->perPage(),
                    'current_page' => $collection->currentPage(),
                    'last_page' => $collection->lastPage(),
                ],
            ]);
        }

        // Fallback for empty or incorrect data — use default pagination metadata
        return $this->respond(true, $message, 200, [], [
            'pagination' => [
                'total' => 0,
                'per_page' => 0, 
                'current_page' => 1,
                'last_page' => 1,
            ],
        ]);
    }


}
