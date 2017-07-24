<?php
/**
 * Created by PhpStorm.
 * User: M
 * Date: 17/5/12
 * Time: 下午1:53
 */

namespace app\controllers;

use Yii;
use yii\web\NotFoundHttpException;

class Controller extends \yii\web\Controller
{
    /**
     * 异常提示
     * @param string $message
     * @throws NotFoundHttpException
     */
    public function exception($message = '')
    {
        throw new NotFoundHttpException($message);
    }
}