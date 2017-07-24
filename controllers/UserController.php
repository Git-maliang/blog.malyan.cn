<?php
/**
 * Created by PhpStorm.
 * User: M
 * Date: 17/5/12
 * Time: 下午3:10
 */

namespace app\controllers;

use YII;
use yii\helpers\Url;
use app\models\User;
use yii\web\Response;
use yii\filters\VerbFilter;
use yii\web\UploadedFile;
use yii\filters\AccessControl;
use yii\bootstrap\ActiveForm;
use app\models\form\LoginForm;
use app\components\helpers\DesHelper;
use app\components\helpers\MailHelper;
use app\components\helpers\RedisHelper;

class UserController extends Controller
{
    /**
     * @inheritdoc
     */
    public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::className(),
                'only' => ['logout'],
                'rules' => [
                    [
                        'actions' => ['logout'],
                        'allow' => true,
                        'roles' => ['@'],
                    ],
                    [
                        'actions' => ['register', 'send-mail', 'activate'],
                        'allow' => true,
                        'roles' => ['?'],
                    ],
                ],
            ],
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'logout' => ['post'],
                ],
            ],
        ];
    }

    /**
     * 登录
     * @return array|int|string
     */
    public function actionLogin()
    {
        if(!Yii::$app->user->isGuest){
            return $this->goBack();
        }
        
        $this->layout = 'form';
        $model = new LoginForm();
        $request = Yii::$app->request;

        if($request->isAjax && $model->load($request->post())){
            Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
            return ActiveForm::validate($model);
        }

        if($request->isPost){
            if($model->load($request->post()) && $model->login()){
                return $this->goBack();
            }
        }
        return $this->render('login', [
            'model' => $model
        ]);
    }

    /**
     * 退出
     * @return \yii\web\Response
     */
    public function actionLogout()
    {
        Yii::$app->user->logout();

        return $this->goBack();
    }

    /**
     * 注册
     * @return string
     */
    public function actionRegister()
    {
        if(!Yii::$app->user->isGuest){
            return $this->goBack();
        }

        $model = new User();
        $request = Yii::$app->request;

        if($request->isAjax && $model->load($request->post())){
            Yii::$app->response->format = Response::FORMAT_JSON;
            return ActiveForm::validate($model);
        }

        if($request->isPost){
            if($model->load($request->post())){
                // 上传头像
                $model->avatar = UploadedFile::getInstance($model, 'avatar');
                if($model->avatar && $model->validate()){
                    $avatarName = '/' .time() . rand(100000,999999) . '.' . $model->avatar->extension;
                    if($model->avatar->saveAs(Yii::getAlias('@imageHostPath'). $avatarName)){
                        // 查询未激活账号
                        $user = User::findOne(['username' => $model->username]);
                        if($user){
                            $user->load($request->post());
                            $model = $user;
                        }
                        // 头像地址
                        $model->avatar = Yii::getAlias('@imageHost') . $avatarName;

                        // 保存
                        if($model->save()){
                            $this->activate($model->id, $model->username);
                            return $this->redirect(['user/send-mail', 'id' => $model->id]);
                        }else{
                            Yii::$app->session->setFlash('error', '注册失败，请联系管理员。');
                        }
                    }
                }
            }
        }

        return $this->render('register', [
            'model' => $model
        ]);
    }

    /**
     * 注册成功页
     * @return string
     * @throws \yii\web\NotFoundHttpException
     */
    public function actionSendMail()
    {
        if(!Yii::$app->user->isGuest){
            return $this->goBack();
        }

        $request = Yii::$app->request;
        $id = intval($request->get('id', 0));
        $model = User::findOne(['id' => $id]);
        if(!$model){
            $this->exception('非法操作！');
        }

        if($model->status != User::STATUS_ACTIVATE){
            $this->exception('账号已激活！');
        }

        // 重新发送邮件
        if($request->isPost){
            $this->activate($model->id, $model->username);
        }
        
        return $this->render('send-mail');
    }

    /**
     * 激活注册
     * @return Response
     * @throws \yii\web\NotFoundHttpException
     */
    public function actionActivate()
    {
        if(!Yii::$app->user->isGuest){
            return $this->goBack();
        }

        $token = Yii::$app->request->get('token');
        $data = DesHelper::decode($token);

        if($data){
            $model = User::findOne(['username' => $data['username'], 'id' => $data['id']]);
            if($model){
                // 账号未激活
                if($model->status === User::STATUS_ACTIVATE){
                    $key = User::USER_ACTIVATE_KEY . $model->id;
                    $activate = RedisHelper::get($key);
                    if($activate){
                        $model->status = User::STATUS_ACTIVE;
                        if($model->save(false)){
                            RedisHelper::del($key);
                            Yii::$app->user->login($model, Yii::$app->user->authTimeout);
                            return $this->goHome();
                        }
                    }
                }else{
                    return $this->goHome();
                }
            }
        }
        $this->exception();
    }


    /**
     * 发送激活邮件
     * @param $id
     * @param $username
     */
    private function activate($id, $username)
    {
        // 记录激活有效时间
        RedisHelper::set(User::USER_ACTIVATE_KEY . $id, 1, 1800);
        $token = DesHelper::encode([
            'id' => $id,
            'username' => $username
        ]);
        MailHelper::send($username, '账号激活', 'user/activate', ['url' => Url::toRoute(['user/activate', 'token' => $token], true)]);
    }

    /**
     * 查询是否登录
     * @return bool
     */
    public function actionIsLogin()
    {
        return !Yii::$app->user->isGuest;
    }
}