<?php
/**
 * Created by PhpStorm.
 * User: M
 * Date: 17/7/24
 * Time: 上午9:54
 */

namespace app\components\validators;

use app\assets\ValidationAsset;

class ImageValidator extends \yii\validators\ImageValidator
{
    public $imageId = 'avatar-image';

    /**
     * @inheritdoc
     */
    public function clientValidateAttribute($model, $attribute, $view)
    {
        ValidationAsset::register($view);
        $options = $this->getClientOptions($model, $attribute);
        return 'validation.image(attribute, messages, ' . json_encode($options, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE) . ', deferred, "'. $this->imageId .'");';
    }
}