<?php
/**
 * Created by PhpStorm.
 * User: M
 * Date: 17/5/12
 * Time: 下午2:58
 */
/* @var $link \app\models\Link */
/* @var $article \app\models\Article */
use yii\helpers\Url;
use yii\helpers\Html;
use yii\widgets\ListView;
use yii\bootstrap\Carousel;
use app\assets\AppAsset;

$this->title = '青春也迷茫';
$this->registerCssFile('@staticHost/css/nanoscroller.css');
$this->registerJsFile('@staticHost/js/jquery.nanoscroller.min.js', ['depends' => \app\assets\AppAsset::className()]);
?>
<!-- 轮播start -->
<div class="row flash-view">
    <div class="col-xs-12">
        <?= Carousel::widget([
            'controls' => false,
            'items' => [
                [
                    'content' => '<img src="http://image.malyan.cn/blog/banner_1.jpg" style="height: 324px;width: 100%">',
                    'caption' => '<h4>小马哥</h4><p>This is the caption text</p>',
                ],[
                    'content' => '<img src="http://image.malyan.cn/blog/banner_2.jpg" style="height: 324px;width: 100%">',
                    'caption' => '<h4>This is title</h4><p>你说今天天气怎么样？</p>',
                ],
                [
                    'content' => '<img src="http://image.malyan.cn/blog/banner_3.jpg" style="height: 324px;width: 100%">',
                    'caption' => '<h4>This is title</h4><p>This is the caption text</p>',
                ],
            ]
        ]);?>
    </div>
</div>
<!-- 轮播end -->
<div class="row">
    <div class="col-sm-3  hidden-xs">
        <div class="panel panel-default" style="background: url(http://image.malyan.cn/blog/user-bg.jpg) #fff; background-size:100% 120px; background-repeat:no-repeat;">
            <div class="panel-body">
                <div class="user">
                    <img class="avatar" src="http://image.malyan.cn/blog/user.jpg" alt="wkf928592">
                    <h1>Malyan</h1>
                </div>
            </div>
        </div>
        <!-- 友情链接start -->
        <div class="panel panel-default">
            <div class="panel-heading">
                <h2 class="panel-title">
                    <i class="fa fa-link"></i>
                    友情链接
                </h2>
            </div>
            <div class="panel-body">
                <ul class="post-list">
                    <?php foreach ($link as $val): ?>
                        <li>
                            <i class="fa fa-angle-double-right"></i>
                            <a href="<?= Html::encode($val->link); ?>" target="_blank"><?= Html::encode($val->title); ?></a>
                        </li>
                    <?php endforeach; ?>
                </ul>
            </div>
        </div>
        <!-- 友情链接end -->
        <!-- 友情资助start -->
        <div class="panel panel-default">
            <div class="panel-heading">
                <h2 class="panel-title">
                    <i class="fa fa-retweet"></i>
                    友情资助
                </h2>
            </div>
            <div class="panel-body">
                <a href="javascript:;" title="友情资助">
                    <img class="fund" src="<?= Html::encode(Yii::$app->params['wechatPayCode']); ?>" alt="友情资助" >
                </a>
            </div>
        </div>
        <!-- 友情资助end -->
    </div>
    <!--  动态start -->
    <div class="col-sm-9">
        <div class="panel panel-default  main-content">
            <div class="panel-body">
                <ul class="media-list">
                    <?php foreach ($article as $val){ ?>
                    <li class="media">
                        <div class="media-left">
                            <a>
                                <img class="media-object" src="<?= Html::encode($val->user->avatar); ?>" alt="akingsky">
                            </a>
                        </div>
                        <div class="media-body">
                            <div class="media-heading">
                                <a><?= Html::encode($val->user->nickname); ?></a>
                                发布了<?= Html::encode($val->category->name);?>文章
                            </div>
                            <div class="media-content">
                                <a href="<?= Url::toRoute(['article/detail', 'id' => $val->id]); ?>" target="_blank"><?= Html::encode($val->attach->title); ?></a>
                            </div>
                            <div class="media-action">
                                <span><?= date('Y-m-d H:i:s', $val->created_at); ?></span>
                            <span class="pull-right">
                            浏览(<?= $val->browse_num; ?>) |
                            评论(<?= $val->comment_num; ?>)
                            </span>
                            </div>
                        </div>
                    </li>
                    <?php } ?>
                </ul>
            </div>
        </div>
    </div>
    <!--  动态end-->
</div>
<?php
$js = <<<EOD
if($(window).width() >= 768){
    if($(window).height() + 480 < $('.main-content .panel-body').height()) {
        $('.main-content ul').addClass('nano-content').wrap('<div class="nano"></div>');
        $('.main-content .nano').height($(window).height() + 480).nanoScroller();
    } 
}else{
    $('.carousel img').css('height', '160px');
}
EOD;
$this->registerJs($js);
?>
