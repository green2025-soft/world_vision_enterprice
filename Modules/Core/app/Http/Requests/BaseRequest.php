<?php

namespace Modules\Core\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Http\Exceptions\HttpResponseException;

abstract class BaseRequest extends FormRequest
{
    protected array $rules = [];
    protected array $messages = [];

    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return $this->rules;
    }

    public function messages(): array
    {
        return $this->messages;
    }

    public function attributes(): array
    {
        return [
            // override from extending request classes as needed
        ];
    }

    public function getModelId(): int|string|null
    {
        foreach ($this->route()?->parameters() ?? [] as $param) {
            if (is_object($param) && method_exists($param, 'getKey')) {
                return $param->getKey();
            }

            if (is_numeric($param)) {
                return $param;
            }
        }

        return null;
    }

    // ✅ Validation error handling
    protected function failedValidation(Validator $validator)
    {
        throw new HttpResponseException(response()->json([
            'success' => false,
            'message' => 'Validation errors',
            'errors' => $validator->errors()
        ], 422));
    }
}
