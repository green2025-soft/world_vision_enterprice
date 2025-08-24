<?php 
namespace Modules\Core\Traits;

use Illuminate\Http\JsonResponse;

trait HandlesModelQueries
{
     protected array $searchable = [];
    protected int $limit = 10;
    protected int $offset = 0;
    public function scopeSearch($query, ?string $term = null)
	{
		$term = $term ?? request('search');

		if ($term) {
			$query->where(function ($q) use ($term) {
				// Main model fields
				foreach ($this->searchable ?? [] as $field) {
					$q->orWhere($field, 'LIKE', "%{$term}%");
				}

				// Relation fields
				if (property_exists($this, 'searchableRelations')) {
					foreach ($this->searchableRelations as $relation => $fields) {
						// ✅ Normalize: convert string to array
						$fields = is_array($fields) ? $fields : [$fields];

						$q->orWhereHas($relation, function ($relQuery) use ($fields, $term) {
							$relQuery->where(function ($r) use ($fields, $term) {
								foreach ($fields as $field) {
									$r->orWhere($field, 'LIKE', "%{$term}%");
								}
							});
						});
					}
				}
			});
		}

		return $query;
	}



    public function scopePaginateData($query)
    {
        $limit = (int) request('per_page', $this->limit);
        $offset = (int) request('offset', $this->offset);

        return $query->offset($offset)->limit($limit)->get();
    }

    public function scopeSmartPaginate($query)
    {
        $limit = (int) request('per_page', $this->limit);
        return $query->paginate($limit);
    }
}
