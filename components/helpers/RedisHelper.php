<?php
/**
 * Created by PhpStorm.
 * User: M
 * Date: 17/7/21
 * Time: 上午8:41
 */

namespace app\components\helpers;

use Yii;

class RedisHelper
{
    /**
     * 获取redis对象
     * @return mixed
     */
    public static function redis()
    {
        return Yii::$app->redis;
    }

    /**
     * 判断一个key是否存在
     * @param $key
     * @return mixed
     */
    public static function exists($key)
    {
        return self::redis()->exists($key);
    }

    /**
     * 删除key
     * @param $key
     * @return mixed
     */
    public static function del($key)
    {
        return self::redis()->del($key);
    }

    /**
     * 设置-哈希
     * @param $key
     * @param $value
     * @param int $expire
     */
    public static function hashSet($key, $value, $expire = 0)
    {
        $redis = self::redis();
        $redis->hset($key, $value);
        if($expire){
            $redis->expire($key, $expire);
        }
    }

    /**
     * 获取-哈希
     * @param $key
     * @return mixed
     */
    public static function hashGet($key)
    {
        return self::redis()->hget($key);
    }

    /**
     * 设置-字符串类型
     * @param $key
     * @param $value
     * @param int $expire
     */
    public static function set($key, $value, $expire = 0)
    {
        $redis = self::redis();
        $redis->set($key, $value);
        if($expire){
            $redis->expire($key, $expire);
        }
    }

    /**
     * 获取-字符串类型
     * @param $key
     * @return mixed
     */
    public static function get($key)
    {
        return self::redis()->get($key);
    }

    /**
     * 设置-列表
     * @param $key
     * @param $value
     * @param bool $type
     * @param int $expire
     */
    public static function listSet($key, $value, $type = true, $expire = 0)
    {
        $redis = self::redis();
        $fun = $type ? 'lpush' : 'rpush';

        if(is_array($value)){
            foreach ($value as $val){
                $redis->$fun($key, $val);
            }
        }else{
            $redis->$fun($key, $value);
        }

        if($expire){
            $redis->expire($key, $expire);
        }
    }

    /**
     * 获取区间-列表
     * @param $key
     * @param int $start
     * @param int $stop
     * @return mixed
     */
    public static function listGet($key, $start = 0, $stop = -1)
    {
        return self::redis()->lrange($key, $start, $stop);
    }

    /**
     * 设置-集合
     * @param $key
     * @param $value
     * @param int $expire
     */
    public static function setAdd($key, $value, $expire = 0)
    {
        $redis = self::redis();

        if(is_array($value)){
            foreach ($value as $val){
                $redis->sadd($key, $val);
            }
        }else{
            $redis->sadd($key, $value);
        }

        if($expire){
            $redis->expire($key, $expire);
        }
    }

    /**
     * 获取-集合
     * @param $key
     * @return mixed
     */
    public static function setMembers($key)
    {
        return self::redis()->smembers($key);
    }

    /**
     * 判断是否存在-集合
     * @param $key
     * @param $value
     * @return mixed
     */
    public static function setIsMember($key, $value){
        return self::redis()->sismember($key, $value);
    }

    /**
     *  删除-集合
     * @param $key
     * @param $value
     * @return mixed
     */
    public static function setRem($key, $value)
    {
        return self::redis()->srem($key, $value);
    }

    /**
     * 获取数量-集合
     * @param $key
     * @return mixed
     */
    public static function setCard($key)
    {
        return self::redis()->scard($key);
    }

    /**
     * 获取交集-集合
     * @param $key
     * @return mixed
     */
    public static function setInter($key)
    {
        return self::redis()->sinter($key);
    }

    /**
     * 获取差集-集合
     * @param $key
     * @return mixed
     */
    public static function setDiff($key)
    {
        return self::redis()->sdiff($key);
    }
}
