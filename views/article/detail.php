<?php
/**
 * Created by PhpStorm.
 * User: M
 * Date: 17/5/12
 * Time: 下午3:12
 */
/* @var $article \app\models\Article */
/* @var $comment \app\models\Comment */
/* @var $userDynamic \app\models\UserDynamic */
/* @var $login */
/* @var $comments */
use yii\helpers\Url;
use yii\helpers\Html;
use yii\bootstrap\Nav;
use yii\helpers\Markdown;
use yii\widgets\Pjax;

$this->title = $article->attach->title;
$this->params['breadcrumbs'] = [
    ['label' => '文章', 'url' => ['article/index']],
    $this->title
];
?>
<div class="row">
    <div class="col-sm-9">
        <div class="panel panel-default">
            <div class="panel-body">
                <!-- 标题 -->
                <div class="page-header">
                    <h1>
                        <?= Html::encode($article->attach->title); ?>
                        <small>[ <?= $article->category->name; ?> ]</small>
                    </h1>
                </div>
                <div class="action">
                    <!-- 作者 -->
                    <span>
                        <i class="fa fa-user"></i>
                        <?= Html::encode($article->user->nickname); ?>
                    </span>
                    <!-- 时间 -->
                    <span>
                        <i class="fa fa-clock-o"></i>
                        <?= date('Y-m-d H:i:s', $article->created_at); ?>
                    </span>
                    <!-- 浏览次数 -->
                    <span>
                        <i class="fa fa-eye"></i>
                        <?= $article->browse_num; ?>次浏览
                    </span>
                    <!-- 评论次数 -->
                    <span>
                        <i class="fa fa-comments-o"></i>
                        <num class="comment-num"><?= $article->comment_num; ?></num>条评论
                    </span>
                    <span class="pull-right">
                        <!-- 点赞次数 -->
                        <a href="javascript:void(0);" title="点赞" class="praise" data-id="<?= $article->id; ?>" data-type="1">
                            <i class="fa fa-thumbs-o-up <?= $article->is_praise ? 'praise-i' : ''; ?>"></i>
                            <num>
                                <?= $article->praise_num; ?>
                            </num>
                        </a>
                    </span>
                </div>
                <!-- 文章内容 -->
                <?= Markdown::process($article->attach->content, 'gfm-comment'); ?>
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-body">
                <div id="comments">
                    <?php Pjax::begin(['id' => 'countries']); ?>
                    <div class="page-header">
                        <?= Html::tag('h2','共 <em>' . count($comments) . '</em> 条评论'); ?>
                    </div>
                    <?php if($comments): ?>
                        <ul class="media-list">
                        <?php foreach ($comments as $val): ?>
                            <li class="media">
                                <div class="media-left">
                                    <a>
                                        <img class="media-object" src="<?= Html::encode($val['user']['avatar']); ?>" alt="wushshsha">
                                    </a>
                                </div>
                                <div class="media-body">
                                    <div class="media-heading">
                                        <a><?= Html::encode($val['user']['nickname']); ?></a>
                                        评论于 <?= date('Y-m-d H:i:s', $val['created_at']); ?>
                                    </div>
                                    <div class="media-content">
                                        <p><?= Html::encode($val['content']); ?></p>
                                        <?php if(isset($val['child'])): ?>
                                            <div class="hint">
                                                共
                                                <em><?= count($val['child']); ?></em>
                                                条回复
                                            </div>
                                            <?php foreach ($val['child'] as $v): ?>
                                                <div class="media">
                                                    <div class="media-left">
                                                        <a>
                                                            <img class="media-object" src="<?= Html::encode($v['user']['avatar']); ?>" alt="iceluo">
                                                        </a>
                                                    </div>
                                                    <div class="media-body">
                                                        <div class="media-heading">
                                                            <a><?= Html::encode($v['user']['nickname']); ?></a>
                                                            评论于 <?= date('Y-m-d H:i:s', $v['created_at']); ?>

                                                            <?php if(Yii::$app->user->id != $v['user_id']): ?>
                                                            <span class="pull-right">
                                                                <a class="reply" href="javascript:void(0);" data-uid="<?= $v['answer_user_id']; ?>" data-pid="<?= $val['id']; ?>" data-nickname="<?= Html::encode($v['user']['nickname']); ?>">
                                                                    <i class="fa fa-reply"></i>
                                                                    回复
                                                                </a>
                                                            </span>
                                                            <?php endif; ?>
                                                        </div>
                                                        <div class="media-content">
                                                            <p><?= $v['answer_user_id'] ? Html::a('@'. $val['user'][$v['answer_user_id']]['nickname'], 'javascript:void(0)') . ' ' : ''; ?><?= Html::encode($v['content']); ?></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            <?php endforeach; ?>
                                        <?php endif; ?>
                                    <div class="media-action">
                                        <a class="reply" href="javascript:void(0);" data-uid="0" data-pid="<?= $val['id']; ?>" data-nickname="<?= Html::encode($val['user']['nickname']); ?>">
                                            <i class="fa fa-reply"></i>
                                            回复
                                        </a>
                                        <span class="pull-right">
                                            <a href="javascript:void(0);" title="点赞" class="praise" data-id="<?= $val['id']; ?>" data-type="2">
                                                <i class="fa fa-thumbs-o-up <?= $val['is_praise'] ? 'praise-i' : ''; ?>"></i>
                                                <num>
                                                    <?= $val['praise_num']; ?>
                                                </num>
                                            </a>
                                        </span>
                                        <div class="reply-box" style="display: none">
                                            <div class="form-group field-comment-content required">
                                                <?= Html::textarea(null, null,['class' => 'form-control', 'maxlength' => 1000, 'rows' => 3]); ?>
                                            </div>
                                            <button type="button" class="btn btn-default reply-button">评论</button>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        <?php endforeach; ?>
                        </ul>
                    <?php else: ?>
                        暂无评论
                    <?php endif; ?>
                </div>
                <?php Pjax::end(); ?>
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-body">
                <!-- 评论区 -->
                <div id="comment">
                    <div class="page-header">
                        <h2>发表评论</h2>
                    </div>
                    <?php if(Yii::$app->user->isGuest): ?>
                    <div class="well danger">
                            您需要登录后才可以评论。
                            <?= Html::a('登录', 'javascript:void(0)', [
                                'data-title' => '登录',
                                'data-url' => '/user/login',
                                'data-toggle' => 'modal',
                                'data-target' => '#page-modal',
                                'class' => 'login-modal',
                            ]); ?>
                            |
                            <?= Html::a('注册', ['user/register'], ['target' => '_blank']); ?>
                    </div>
                     <?php else: ?>
                        <?= $this->render('comment', [
                            'comment' => $comment,
                        ]); ?>
                        <?= $this->render('reply', [
                            'comment' => $comment,
                        ]); ?>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>
    <?= $this->render('right-content'); ?>
</div>
<?php
$loginUrl = Url::toRoute(['user/is-login']);
$praiseUrl = Url::toRoute(['article/praise']);
$answerId = Html::getInputId($comment, 'answer_user_id');
$commentId = Html::getInputId($comment, 'comment_id');
$contentId = Html::getInputId($comment, 'content');
$js = <<<EOD
    // 回复
    $(document).on("click", ".reply",  function() {
        let replyBox = $(this).parents(".media-content").find(".reply-box");
        let form = $("#reply-form");
        let uid = $(this).data("uid");
        let pid = $(this).data("pid");
        let nickname = "@" + $(this).data("nickname");
        $.ajax({
            type: "GET",
            url: "{$loginUrl}",
            success: function(data){
                if(data){
                    form.find("#{$answerId}").val(uid);
                    form.find("#{$commentId}").val(pid);
                    replyBox.find("textarea").attr("placeholder", nickname).val("");
                    $(".reply-box").hide();
                    replyBox.show();
                }else{
                    layer.msg('请先登录');
                }
            },
            error: function(){
                layer.msg('网络错误');
            }
        });
    });
    
    $(document).on("blur", ".reply-box textarea", function() {
        let content = $(this).val();
        let len = content.length;
        if(len > 1000){
            $(this).parent().addClass("has-error");
        }else{
            $(this).parent().removeClass("has-error");
        }
    });
    
    $(document).on("click", ".reply-button", function(){
        let textarea = $(this).siblings('div').find('textarea');
        let content = $(this).val();
        let len = content.length;
        if(len < 1 || len > 1000){
            textarea.parent().addClass("has-error");
            return false;
        }else{
            textarea.parent().removeClass("has-error");
        }
        
        form = $("#reply-form").find("#{$contentId}").val(content);
        form.submit();
    });
    
    // 评论点赞
    $(document).on("click", ".praise", function(){
        let i = $(this).find('i');
        let num = $(this).find('num');
        $.ajax({
            type: "GET",
            url: "{$praiseUrl}",
            data: {id: $(this).data('id'), type: $(this).data('type')},
            success: function(data){
                if(data.code){
                    if(i.hasClass('praise-i')){
                        i.removeClass('praise-i');
                        num.html(parseInt(num.html()) - 1);
                    }else{
                        i.addClass('praise-i');
                        num.html(parseInt(num.html()) + 1);
                    }
                }else{
                    layer.msg(data.msg);
                }
            },
            error: function(){
                layer.msg('网络错误');
            }
        });
    });
EOD;
$this->registerJs($js);
?>
