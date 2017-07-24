<?php

/* @var $this \yii\web\View */
/* @var $content string */

use yii\helpers\Url;
use yii\helpers\Html;
use yii\bootstrap\Nav;
use yii\bootstrap\NavBar;
use yii\widgets\Breadcrumbs;
use app\assets\AppAsset;
use yii\bootstrap\Modal;

AppAsset::register($this);
$user = Yii::$app->user->identity;
?>
<?php $this->beginPage() ?>
<!DOCTYPE html>
<html lang="<?= Yii::$app->language ?>">
<head>
    <meta charset="<?= Yii::$app->charset ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <?= Html::csrfMetaTags() ?>
    <title><?= Html::encode($this->title) ?></title>
    <?php $this->head() ?>
</head>
<body>
<?php $this->beginBody() ?>

<div class="wrap">
    <!-- 头部 -->
    <?php
    NavBar::begin([
        'brandLabel' => 'My Blog',
        'brandUrl' => Yii::$app->homeUrl,
        'options' => [
            'class' => 'navbar-default navbar-fixed-top',
        ],
    ]);
    echo Nav::widget([
        'options' => ['class' => 'navbar-nav'],
        'items' => [
            ['label' => '首页', 'url' => '/', 'active' => Yii::$app->defaultRoute ==  Yii::$app->controller->id . '/' . Yii::$app->controller->action->id],
            ['label' => '文章', 'url' => ['article/index']],
            ['label' => '相册', 'url' => ['photo-album/index']],
            ['label' => '音乐', 'url' => ['music/index']],
            ['label' => '视频', 'url' => ['video/index']],
        ]
    ]);
    echo Nav::widget([
        'options' => ['class' => 'navbar-nav navbar-right'],
        'items' => [
            [
                'label' => '注册',
                'url' => ['user/register'],
                'linkOptions' => [
                    'target' => '_blank'
                ],
                'visible' => Yii::$app->user->isGuest
            ],
            [
                'label' => '登录',
                'url' => 'javascript:;',
                'linkOptions' => [
                    'data-title' => '登录',
                    'data-url' => '/user/login',
                    'data-toggle' => 'modal',
                    'data-target' => '#page-modal',
                    'class' => 'login-modal',
                ],
                'visible' => Yii::$app->user->isGuest
            ],
            [
                'label' => $user ? Html::img($user->avatar, ['width' => 20, 'height' => 20]) . ' '.Html::encode($user->nickname) : '',
                'items' => [
                    ['label' => '个人中心', 'url' => ['user/change-password']],
                    '<li class="divider"></li>',
                    ['label' => '退出', 'url' => ['user/logout'], 'linkOptions' => ['data-method' => 'post']],
                ],
                'encode' => false,
                'visible' => !Yii::$app->user->isGuest
            ]
        ]
    ]);

    echo Html::beginForm(['index/search'], 'post', ['class' => 'navbar-form navbar-right'])
        . '<div class="input-group">'
        . Html::textInput('search', null, ['class' => 'form-control', 'placeholder' => '搜索'])
        . '<span class="input-group-btn">'
        . Html::submitButton('<span class="glyphicon glyphicon-search"></span>', ['class' => 'btn btn-default'])
        . '</span></div>'
        . Html::endForm();
    NavBar::end();
    ?>

    <!-- 内容 -->
    <div class="container">
        <?= Breadcrumbs::widget([
            'options' => ['class' => 'breadcrumb', 'style' => 'background-color:#fff'],
            'links' => isset($this->params['breadcrumbs']) ? $this->params['breadcrumbs'] : [],
        ]) ?>
        <?= $content ?>
    </div>
</div>

<!--  尾部 -->
<footer class="footer">
    <div class="container">
        <p class="pull-left">&copy; My Company <?= date('Y') ?></p>
        <p class="pull-right">
            技术支持
            <a href="/" rel="external">Malyan</a>
        </p>
    </div>
</footer>
<!--  模态框 -->
<?php
Modal::begin([
    'id' => 'page-modal',
]);
$js = <<<JS
$(".page-modal").click(function(){ 
    var url = $(this).attr('data-url');
    var title = $(this).attr('data-title');
    $($(this).attr('data-target')+" .modal-title").text(title);
    $($(this).attr('data-target')).modal("show")
         .find(".modal-content")
         .load(url); 
    return false;
}); 

JS;
$this->registerJs($js);

Modal::end();
?>
<?php
if(Yii::$app->user->isGuest){
    $loginUrl = Url::toRoute(['user/is-login']);
    $js = <<<EOD
        $(".login-modal").click(function(){
            let t = $(this);
            $.ajax({
                type: "GET",
                url: "{$loginUrl}",
                success: function(data){
                    if(data){
                         layer.msg('您已登录', function(){
                            location.reload();
                        });
                    }else{
                       let url = t.attr('data-url');
                        let title = t.attr('data-title');
                        $(t.attr('data-target')+" .modal-title").text(title);
                        $(t.attr('data-target')).modal("show")
                             .find(".modal-content")
                             .load(url); 
                    }
                },
                error: function(){
                    layer.msg('网络错误');
                }
            });
            return false;
        }); 
EOD;
    $this->registerJs($js);
}
?>
<!-- 返回顶部 -->
<?= \bluezed\scrollTop\ScrollTop::widget() ?>
<?php $this->endBody() ?>
</body>
</html>
<?php $this->endPage() ?>