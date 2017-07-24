<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "{{%link}}".
 *
 * @property integer $id
 * @property string $title
 * @property string $link
 * @property integer $sort
 * @property integer $status
 * @property integer $created_at
 */
class Link extends \yii\db\ActiveRecord
{
    const STATUS_SHOW = 1;
    const STATUS_HIDDEN = 2;
    
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%link}}';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['sort', 'status', 'created_at'], 'integer'],
            [['title', 'link'], 'string', 'max' => 80],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'title' => '标题',
            'link' => '链接',
            'sort' => '排序',
            'status' => '状态(1-显示，2-不显示)',
            'created_at' => '创建时间',
        ];
    }
}
