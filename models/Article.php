<?php

namespace app\models;

use Yii;
use app\components\helpers\RedisHelper;

/**
 * This is the model class for table "{{%article}}".
 *
 * @property integer $id
 * @property integer $author
 * @property integer $category_id
 * @property integer $browse_num
 * @property integer $comment_num
 * @property integer $praise_num
 * @property integer $status
 * @property integer $created_at
 */
class Article extends \yii\db\ActiveRecord
{
    const STATUS_SHOW = 1;
    const STATUS_HIDDEN = 2;

    const SORT_NEW = 1; // 最新
    const SORT_BROWSE = 2; // 浏览
    const SORT_COMMENT= 3; // 评论


    public $praiseKey= 'article.praise.user.';
    public $praise_num = 0;
    public $is_praise = false;

    public static $sortArray = [
        self::SORT_NEW => '最新发布',
        self::SORT_BROWSE => '最多浏览',
        self::SORT_COMMENT => '最多评论'
    ];

    public static $sortFieldArray = [
        self::SORT_NEW => 'created_at',
        self::SORT_BROWSE => 'browse_num',
        self::SORT_COMMENT => 'comment_num'
    ];

    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%article}}';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['author', 'category_id', 'browse_num', 'comment_num', 'status', 'created_at'], 'integer'],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'author' => '作者',
            'category_id' => '类型',
            'browse_num' => '浏览次数',
            'comment_num' => '评论次数',
            'status' => '状态（1-显示 2-不显示）',
            'created_at' => '创建时间',
        ];
    }

    /**
     * @inheritdoc
     */
    public function afterFind()
    {
        $this->praise_num = RedisHelper::setCard($this->praiseKey . $this->id);
        if(!Yii::$app->user->isGuest){
            $this->is_praise = RedisHelper::setIsMember($this->praiseKey . $this->id, Yii::$app->user->id);
        }
        parent::afterFind();
    }
    
    /**
     * 分类关系
     * @return \yii\db\ActiveQuery
     */
    public function getCategory()
    {
        return $this->hasOne(ArticleCategory::className(), ['id' => 'category_id']);
    }

    /**
     * 附加关系
     * @return \yii\db\ActiveQuery
     */
    public function getAttach()
    {
        return $this->hasOne(ArticleAttach::className(), ['article_id' => 'id']);
    }

    /**
     * 用户关系
     * @return \yii\db\ActiveQuery
     */
    public function getUser()
    {
        return $this->hasOne(User::className(), ['id' => 'author']);
    }
}