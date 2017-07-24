<?php
/**
 * Created by PhpStorm.
 * User: M
 * Date: 17/7/24
 * Time: 下午2:43
 */
/* @var $isPost */
use yii\helpers\Html;
use yii\bootstrap\ActiveForm;
use yii\helpers\ArrayHelper;
use app\components\widgets\Alert;
Yii::$app->session->setFlash('success', '注册成功，邮件已发送至邮箱，请先激活账号。');
$this->title = '邮件发送成功';
?>
<div class="raw">
    <div class="col-sm-2"></div>
    <div class="col-sm-8">
        <?= Alert::widget(['fixedTop' => true, 'closeButton' => false]); ?>
        <?php $form = ActiveForm::begin(); ?>
        <?= Html::submitButton('重新发送(60s)', ['class' => 'btn btn-success', 'id' => 'send-mail', 'disabled' => true]); ?>
        <?php ActiveForm::end(); ?>
    </div>
    <div class="col-sm-2"></div>
</div>
<?php
$js = <<<EOD
    var i = 60;
    cardTimer = setInterval(function(){
        sendCard = true
        $('#send-mail').html('重新发送(' + i + 's)');
        i--;
        if(i == 0){
            clearInterval(cardTimer);
            $('#send-mail').removeAttr('disabled');
            $('#send-mail').html('重新发送');
        }
    }, 1000);
EOD;
$this->registerJs($js);
?>
