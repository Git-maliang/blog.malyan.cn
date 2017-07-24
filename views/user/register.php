<?php
/**
 * Created by PhpStorm.
 * User: M
 * Date: 17/7/21
 * Time: 下午4:45
 */
/* @var $model \app\models\User */
use yii\helpers\Html;
use yii\bootstrap\ActiveForm;
use app\components\widgets\Alert;
$this->title = '账号注册';
?>
<div class="raw">
    <div class="col-sm-2"></div>
    <div class="col-sm-8">
        <?= Alert::widget(['fixedTop' => true]); ?>
        <?php $form = ActiveForm::begin(); ?>
        <?= $form->field($model, 'username', ['enableAjaxValidation' => true]); ?>
        <?= $form->field($model, 'nickname'); ?>
        <?= $form->field($model, 'avatar', [
            'template' => '{label}{input}' .
                Html::img(Yii::$app->params['userDefaultAvatar'],
                    [
                        'id' => 'avatar-image',
                        'width' => 80,
                        'height' => 80,
                        'title' => '选择头像',
                        'style' => 'cursor:pointer;display:block',
                        'onclick' => '$(this).prev().click()'
                    ]) . '{error}',
        ])->fileInput(['style' => 'display:none']); ?>
        <?= $form->field($model, 'password')->passwordInput(['autocomplete' => 'off']); ?>
        <?= $form->field($model, 'password_compare')->passwordInput(['autocomplete' => 'off']); ?>
        <?= Html::submitButton('注册', ['class' => 'btn btn-default']); ?>
        <?php ActiveForm::end(); ?>
    </div>
    <div class="col-sm-2"></div>
</div>
