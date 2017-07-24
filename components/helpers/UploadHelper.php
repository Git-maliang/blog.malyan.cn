<?php
/**
 * Created by PhpStorm.
 * User: M
 * Date: 17/7/20
 * Time: 上午11:23
 */

namespace app\components\helpers;

use Yii;
use yii\web\UploadedFile;

class UploadHelper
{
    public static function markDownUpload()
    {
        $uploadedFile = UploadedFile::getInstanceByName('file');
        $fileName = time() . rand(999,9999) . '.' . $uploadedFile->getExtension();
        if($uploadedFile->saveAs(Yii::getAlias('@static') . '/' . $fileName)){
            return [
                'state' => 'success',
                'type' => $uploadedFile->type,
                'size' => $uploadedFile->size,
                'original' => $uploadedFile->name,
                'url' => $fileName,
                'title' => $fileName
            ];
        }else{
            return ['state' => ''];
        }
    }
}