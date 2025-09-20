<?php

use Illuminate\Support\Facades\Storage;

use function Illuminate\Log\log;

if (!function_exists('uploadImage')) {
    /**
     * Upload image to given folder, delete old image if exists.
     *
     * @param \Illuminate\Http\UploadedFile $file
     * @param string $folder
     * @param string|null $oldPath
     * @return string URL of uploaded file
     */
    function uploadImage($file, $folder, $oldPath = null): string
    {
        // Delete old file if exists
        if ($oldPath) {
            $oldPathRelative = str_replace('/storage/', '', parse_url($oldPath, PHP_URL_PATH));
            if (Storage::disk('public')->exists($oldPathRelative)) {
                Storage::disk('public')->delete($oldPathRelative);
            }
        }

        // Store new file
        $path = $file->store($folder, 'public');
        
        // Return public url
        return Storage::url($path);
    }



}


if (!function_exists('dbDateFormat')) {
    function dbDateFormat($date){
        $date = str_replace(['/','.'],['-'], $date);
        $dateCheck = validateDate($date);
        if ($dateCheck) {
            return date('Y-m-d', strtotime($date));
        }
    }
}



if (!function_exists('validateDate')) {
    function validateDate($date)
    {
        $timestamp = strtotime($date);
        return $timestamp ? $date : null;
    }
}
