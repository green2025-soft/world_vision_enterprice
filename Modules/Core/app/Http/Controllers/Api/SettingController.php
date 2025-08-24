<?php

namespace Modules\Core\Http\Controllers\Api;

use Illuminate\Http\Request;

use Modules\Core\Models\Setting;

class SettingController extends BaseApiController
{


    public function __construct()
    {
  
    }

     public function index()
    {
        $settings = Setting::all()->pluck('value', 'key');
        return $this->success($settings, 'Settings fetched successfully');
    }
   public function update(Request $request)
    {
        $data = $request->all();

        if ($request->hasFile('app_logo')) {
            $oldLogo = Setting::where('key', 'app_logo')->value('value');
            $url = uploadImage($request->file('app_logo'), 'setting', $oldLogo);
            $this->updateSetting('app_logo', $url);
        }

        if ($request->hasFile('icon_logo')) {
            $oldIcon = Setting::where('key', 'icon_logo')->value('value');
            $url = uploadImage($request->file('icon_logo'), 'setting', $oldIcon);
            $this->updateSetting('icon_logo', $url);
        }

        foreach ($data as $key => $value) {
            if (in_array($key, ['app_logo', 'icon_logo'])) continue;
            $this->updateSetting($key, $value);
        }

        return $this->success(null, 'Settings updated successfully');
    }


    protected function updateSetting($key, $value)
    {
        Setting::updateOrCreate(['key' => $key], [
            'value' => $value,
            'type' => 'text', // or dynamic type if needed
        ]);
    }
}
