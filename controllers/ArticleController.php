<?php
/**
 * Created by PhpStorm.
 * User: M
 * Date: 17/5/12
 * Time: 下午2:30
 */

namespace app\controllers;

use app\components\helpers\RedisHelper;
use app\models\ArticleComment;
use app\models\Comment;
use yii\db\ActiveQuery;
use Yii;
use app\models\Article;
use yii\web\UploadedFile;
use app\models\UserDynamic;
use yii\data\ActiveDataProvider;
use yii\helpers\ArrayHelper;
use yii\web\NotFoundHttpException;
use yii\web\Response;

class ArticleController extends Controller
{
    /**
     * @return string
     */
    public function actionIndex()
    {
        $sort = Yii::$app->request->get('sort', 1);
        $query = Article::find()
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
            ->orderBy([Article::tableName() . '.' . ArrayHelper::getValue(Article::$sortFieldArray, $sort, Article::$sortFieldArray[1]) => SORT_DESC]);

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
            'pagination' => [
                'pageSize' => 20,
                'totalCount' => $query->count()
            ]
        ]);

        $article = $query
            ->offset($dataProvider->pagination->offset)
            ->limit($dataProvider->pagination->limit)
            ->all();

        return $this->render('index',[
            'sort' => $sort,
            'article' => $article,
            'dataProvider' => $dataProvider
        ]);
    }

    /**
     * 文章详情
     * @param $id
     * @return string
     * @throws \yii\web\NotFoundHttpException
     */
    public function actionDetail($id)
    {
        $id = intval($id);
        if($id < 1){
            $this->exception('非法请求');
        }

        // 文章
        $article = Article::find()
            ->innerJoinWith([
                'category' => function(ActiveQuery $query){
                    $query->select(['id', 'name']);
                },
                'attach' => function(ActiveQuery $query){
                    $query->select(['article_id', 'title', 'content']);
                },
                'user' => function(ActiveQuery $query){
                    $query->select(['id', 'nickname', 'avatar']);
                }
            ])
            ->where([Article::tableName() . '.id' => $id, Article::tableName() . '.status' => Article::STATUS_SHOW])
            ->one();

        if(!$article){
            $this->exception('非法请求');
        }

        // 评论和回复
        $comment = new ArticleComment();
        $request = Yii::$app->request;
        if($request->isPjax) {
            if(Yii::$app->user->isGuest){
                $this->exception();
            }
            $comment->article_id = $id;
            if ($comment->load($request->post()) && $comment->validate()) {
                $trans = Yii::$app->db->beginTransaction();
                try{
                    $article->comment_num ++;
                    $article->save();
                    $comment->save(false);
                    $trans->commit();
                    $comment = new ArticleComment();
                }catch (\Exception $e){
                    $trans->rollBack();
                }
            }
        }

        // 更新浏览量
        if($this->browseRenewal($id)){
            $article->browse_num ++;
            $article->save();
        }

        // 评论内容
        $comments = $comment->getComments($id);

        return $this->render('detail',[
            'article' => $article,
            'comment' => $comment,
            'comments' => $comments,
        ]);
    }
    
    /**
     * 点赞
     * @return array
     */
    public function actionPraise()
    {
        $data = ['code' => 0, 'msg' => '请先登录'];
        Yii::$app->response->format = Response::FORMAT_JSON;
        $request = Yii::$app->request;
        if(!Yii::$app->user->isGuest){
            $data['msg'] = '网络异常';
            if($request->isGet){
                $id = $request->get('id', 0);
                $type = $request->get('type', 0);
                if($id) {
                    $model = $type == 1 ? Article::findOne(['id' => $id]) : ArticleComment::findOne(['id' => $id]);
                    if ($model) {
                        $user_id = Yii::$app->user->id;
                        $key = $model->praiseKey . $model->id;
                        if(RedisHelper::setIsMember($key, $user_id)){
                            RedisHelper::setRem($key, $user_id);
                        }else{
                            RedisHelper::setAdd($key, $user_id);
                        }
                        $data['code'] = 1;
                    }
                }
            }
        }
        return $data;
    }

    /**
     * 添加文章
     * @return string
     * @throws NotFoundHttpException
     */
    public function actionAdd()
    {
        return $this->save();
    }

    /**
     * 编辑文章
     * @param $id
     * @return string
     * @throws NotFoundHttpException
     */
    public function actionEdit($id)
    {
        $id = intval($id);
        if($id < 1){
            throw new NotFoundHttpException('非法请求');
        }
        return $this->save($id);
    }

    /**
     * 文章保存
     * @param int $id
     * @return string
     * @throws NotFoundHttpException
     * @throws \yii\db\Exception
     */
    public function save($id = 0)
    {
        if($id){
            $article =  Article::findOne($id);
            $userDynamic = UserDynamic::findOne($id);
            if(!$userDynamic || !$article){
                throw new NotFoundHttpException('非法请求');
            }
        }else{
            $article = new Article();
            $userDynamic = new UserDynamic();
        }
        $request = Yii::$app->request;
        if($request->isPost){
            if($article->load($request->post()) && $article->validate()){
                $trans = Yii::$app->db->beginTransaction();
                try{
                    $userDynamic->category = UserDynamic::CATEGORY_ARTICLE;
                    $userDynamic->save();
                    $article->id = $userDynamic->id;
                    $article->save();
                    $trans->commit();
                    return '成功';
                }catch (\Exception $e){
                    $trans->rollBack();
                }
            }
            throw new NotFoundHttpException('操作失败');
        }
        return $this->render('form', [
            'article' => $article
        ]);
    }

    /**
     * 上传图片
     * @return array
     */
    public function actionUpload()
    {
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        $uploadedFile = UploadedFile::getInstanceByName('file');
        $fileName = rand(999,9999).time() . '.' . $uploadedFile->getExtension();
        if($uploadedFile->saveAs(Yii::getAlias('@static') . '/' . $fileName)){
            return [
                'state' => 'success',
                'type' => $uploadedFile->type,
                'size' => $uploadedFile->size,
                'original' => $uploadedFile->name,
                'url' => $fileName,
                'title' => $fileName
            ];
        }else{
            return ['state' => ''];
        }
    }

    /**
     * 更新浏览量
     * @param $id
     */
    public function browseRenewal($id)
    {
        $id = intval($id);
        if($id > 0){
            $browseArray = Yii::$app->request->cookies->getValue('browseArray', []);
            if(!in_array($id, $browseArray)){
                $browseArray[] = $id;
                Yii::$app->response->cookies->add(new \yii\web\Cookie([
                    'name' => 'browseArray',
                    'value' => $browseArray
                ]));
                return true;
            }
        }
        return false;
    }
}