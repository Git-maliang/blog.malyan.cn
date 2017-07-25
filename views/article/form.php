<?php
/**
 * Created by PhpStorm.
 * User: M
 * Date: 17/5/22
 * Time: 上午9:28
 */
/* @var $article \app\models\Article */
/* @var $articleAttach \app\models\ArticleAttach */
use yii\helpers\Html;
use yii\bootstrap\ActiveForm;
use app\models\Category;
?>
<div class="row">
    <div class="col-sm-12">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="page-header">
                    <?php $form = ActiveForm::begin(); ?>
                    <?= $form->field($articleAttach, 'title'); ?>
                    <?= $form->field($article, 'category_id')->dropDownList(Category::categoryArray(), ['prompt' => '请选择']); ?>
                    <?= $form->field($articleAttach, 'content')->widget('yidashi\markdown\Markdown', ['useUploadImage' => true]); ?>
                    <?= Html::submitButton('提交', ['class' => 'btn btn-default']); ?>
                    <?php ActiveForm::end(); ?>
                </div>
            </div>
        </div>
    </div>
</div>