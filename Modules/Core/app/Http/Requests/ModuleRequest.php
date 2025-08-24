<?php

namespace Modules\Core\Http\Requests;

use Illuminate\Validation\Rule;

class ModuleRequest extends BaseRequest
{
    protected array $rules = [
        'name' => ['required', 'string', 'max:255', 'unique:modules,name'],
        'slug' => ['required', 'string', 'max:255', 'unique:modules,slug'],
        'status' => ['nullable', 'boolean'],
    ];

    public function rules(): array
    {
        if (in_array($this->method(), ['PUT', 'PATCH'])) {
            $moduleId = $this->route('module')??null;
              

            $this->rules['name'] = [
                'required',
                'string',
                'max:255',
                Rule::unique('modules', 'name')->ignore($moduleId),
            ];

            $this->rules['slug'] = [
                'required',
                'string',
                'max:255',
                Rule::unique('modules', 'slug')->ignore($moduleId),
            ];
        }

        return $this->rules;
    }
}
