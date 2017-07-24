<?php
/**
 * Created by PhpStorm.
 * User: M
 * Date: 17/7/21
 * Time: 下午4:14
 */

namespace app\components\helpers;

use Yii;
class MailHelper
{
    /**
     *  发送邮件
     * @param $email
     * @param $title
     * @param null $view
     * @param array $params
     * @return bool
     */
    public static function send($email, $title, $view = null, array $params = [])
    {
        $mail= Yii::$app->mailer->compose($view, $params);
        // 接收方邮箱
        $mail->setTo($email);
        // 邮件标题
        $mail->setSubject($title);
        // 发送图片
        //$mail->attach('图片可访问地址');
        // 发送附件
        //$mail->attachContent('Attachment content', ['fileName' => 'attach.txt', 'contentType' => 'text/plain']);
        // html文本内容
        //$mail->setHtmlBody($email->content);
        // 纯文本内容
        //$mail->setTextBody($email->content);
        // 邮件标题
        // $mail->setSubject('找回密码');
        // 发送图片
        //$mail->attach(Yii::getAlias('@static') . '/image/3dfea9737dd042f38959135624efb0d0_th.jpeg');
        // 发送附件
        //$mail->attach(Yii::getAlias('@static') . '/file/20170424-20170430订单流水明细.xlsx');

        return $mail->send();
    }
}