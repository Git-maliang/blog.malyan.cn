<?php
/**
 * Created by PhpStorm.
 * User: M
 * Date: 17/7/24
 * Time: 上午9:57
 */

namespace app\assets;

use yii\web\AssetBundle;

class ValidationAsset extends AssetBundle
{
    public $basePath = '@staticHost';
    public $baseUrl = '@staticHost';

    public $js = [
        'js/validation.js'
    ];
    
    public $depends = [
        'yii\web\YiiAsset',
    ];
}