<?php
/**
 * Created by PhpStorm.
 * User: M
 * Date: 17/5/12
 * Time: 下午3:12
 */
/* @var  $sort */
/* @var  $article \app\models\UserDynamic */
/* @var  $dataProvider \yii\data\ActiveDataProvider */
use yii\helpers\Url;
use yii\helpers\Html;
use app\models\Article;
use yii\widgets\LinkPager;
use yii\widgets\ListView;

$this->title = '青春也迷茫';
$this->params['breadcrumbs'] = ['文章'];
?>
<div class="row">
    <div class="col-sm-9">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="page-header" style="padding-bottom:7px ">
                    <h1>文章</h1>
                    <ul id="w0" class="nav nav-tabs nav-main">
                        <?php foreach (Article::$sortArray as $key => $val): ?>
                        <li <?= $sort == $key ? 'class="active"' : ''; ?>>
                            <a href="<?= Url::toRoute(['article/index', 'sort' => $key]); ?>"><?= $val; ?></a>
                        </li>
                        <?php endforeach; ?>
                    </ul>
                </div>
                <?= ListView::widget([
                    'dataProvider' => $dataProvider,
                    'layout' => '<ul id="w1" class="media-list">{items}</ul>{pager}',
                    'itemView' => function($article){
                        $html = '<li class="media" data-key="' . $article->id .'">
                            <div class="media-left">
                                <a rel="author">
                                    <img class="media-object" src="' . Html::encode($article->user->avatar) . '">
                                </a>
                            </div>
                            <div class="media-body">
                                <h2 class="media-heading">
                                    <i class="fa fa-file-text-o fa-fw"></i>
                                    <a href="' . Url::toRoute(['article/detail', 'id' => $article->id]) . '" target="_blank">' . Html::encode($article->attach->title) .'</a>
                                    <small>
                                        <i class="fa fa-thumbs-o-up"></i>
                                        ' . $article->praise_num . '
                                    </small>
                                </h2>
                                <div class="media-action">
                                    <a rel="author">' . Html::encode($article->user->nickname) . '</a>
                                    发布于 ' . date('Y-m-d', $article->created_at) . '
                                    <span class="dot">•</span>
                                    ' . $article->category->name . '
                                </div>
                            </div>
                            <div class="media-right">
                                <a class="btn btn-default">
                                    <h4>浏览</h4>
                                    ' . $article->browse_num . '
                                </a>
                            </div>
                            <div class="media-right">
                                <a class="btn btn-default">
                                    <h4>评论</h4>
                                     ' . $article->comment_num . '
                                </a>
                            </div>
                        </li>';
                        return $html;
                    }
                ]);?>
            </div>
        </div>
    </div>
    <?= $this->render('right-content'); ?>
</div>