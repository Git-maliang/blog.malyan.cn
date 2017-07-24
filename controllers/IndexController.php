<?php
/**
 * Created by PhpStorm.
 * User: M
 * Date: 17/5/12
 * Time: 下午2:56
 */

namespace app\controllers;

use Yii;
use app\models\Link;
use app\models\Article;
use yii\db\ActiveQuery;

class IndexController extends Controller
{
    /**
     * 首页
     * @return string
     */
    public function actionIndex()
    {
        // 友情链接
        $link = Link::find()
            ->select(['title', 'link'])
            ->where(['status' => Link::STATUS_SHOW])
            ->orderBy(['sort' => SORT_ASC])
            ->limit(5)
            ->all();

        // 文章
        $article = Article::find()
            ->innerJoinWith([
                'category' => function(ActiveQuery $query){
                    $query->select(['id', 'name']);
                },
                'attach' => function(ActiveQuery $query){
                    $query->select(['article_id', 'title']);
                },
                'user' => function(ActiveQuery $query){
                    $query->select(['id', 'nickname', 'avatar']);
                }
            ])
            ->where([Article::tableName() . '.status' => Article::STATUS_SHOW])
            ->orderBy([Article::tableName() . '.created_at' => SORT_DESC])
            ->limit(20)
            ->all();

        return $this->render('index',[
            'link' => $link,
            'article' => $article
        ]);
    }
}
