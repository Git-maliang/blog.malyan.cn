<?php
/**
 * Created by PhpStorm.
 * User: M
 * Date: 17/7/24
 * Time: 上午11:00
 */

namespace app\components\helpers;

/**
 * 非对称加密算法需要两个密钥：公开密钥（publickey）和私有密钥（privatekey）。
 * 公开密钥与私有密钥是一对，如果用公开密钥对数据进行加密，只有用对应的私有密钥才能解密；
 * 如果用私有密钥对数据进行加密，那么只有用对应的公开密钥才能解密。
 * 因为加密和解密使用的是两个不同的密钥，所以这种算法叫作非对称加密算法。
 * PHP 为客户端(Android，Ios)编写API，对数据进行解密。
 */
class RsaHelper
{
    /**
     * 生成原始 RSA私钥文件
     * openssl genrsa -out rsa_private_key.pem 1024
     * 将原始 RSA私钥转换为 pkcs8格式
     * openssl pkcs8 -topk8 -inform PEM -in rsa_private_key.pem -outform PEM -nocrypt -out private_key.pem
     * 生成RSA公钥
     * openssl rsa -in rsa_private_key.pem -pubout -out rsa_public_key.pem
     * 我们将私钥rsa_private_key.pem用在服务器端，公钥发放给android跟ios等前端。
     */
    private static $publicKey = '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC1eOxT2BeWjXQk1mGHlgR/HGm3
+myunaqN4++WHzVnTCb5lsnioQP6EkgUu5Hvj8/zLyYV+EYXPRYZ9RSb2527e4Su
TxwVjxPUj9k2XS2sKzRChMfbCb00x5nH+CQi9ur7UZPPU4W7+0sOK1wMA0iiyTyo
8VuBE/Baa7G2eN6g/QIDAQAB
-----END PUBLIC KEY-----';
    private static $privateKey = '-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQC1eOxT2BeWjXQk1mGHlgR/HGm3+myunaqN4++WHzVnTCb5lsni
oQP6EkgUu5Hvj8/zLyYV+EYXPRYZ9RSb2527e4SuTxwVjxPUj9k2XS2sKzRChMfb
Cb00x5nH+CQi9ur7UZPPU4W7+0sOK1wMA0iiyTyo8VuBE/Baa7G2eN6g/QIDAQAB
AoGARDTG3lyBwRw5Yv8QeR1xYzUSpwuAfcDUsa/SBOKF9+UvYO/DwWIzVHI6lVBK
cXfj+Mrnzaoa7fEPtYHf1RSeG48FKsVTjbcdAf1RysiMlrII464CQtdA+YUYuysB
2WDYjGqEOAAMc/v8vYYmyTqvZW6/xlAku41eGhqegaBBcAECQQDh+BIdZZiYHmf0
tPshiO6cGgWm8TY6sqyQvDYDo/xNvx0pyY3XiwPHpPGR+IvUqnzQ67WU/Yf1+AZM
70BXJJ+BAkEAzZb8CH2rVMzBY3qd5oK+Enlgy9FQUZ7aTCB/ips12SAW/nYBQLwR
/hjAXNCs0Kifi60axZh3znegmuMXxrw/fQJAIgOebnBhlNxW1536g2TCThsYqLV8
bT+B/FNoagngK6/N6wFc6YoSapXoiwl3uu5i1Wv1rFSxh5PrFt+YtsVbgQJBAIyv
aFKrJIZIA4J+kvT9vPHJa6qt1qez67AygPSpl6S4J+QDfoH88NcPuvsItWmoKl2b
nHlhB4MbK6UyB8Awa8UCQCVsOOsFci4BYmBQsVlfwlu8+I53KlETOT79TNuKERCn
qQwEFSy0XbHW5VoOX+xJ/UuLkvUQ/oaWEYQMDdaZVPo=
-----END RSA PRIVATE KEY-----';

    /**
     * 公钥加密
     * @param string $data
     * @return null
     */
    public static function publicEncrypt($data = ''){
        if(!is_string($data)) {
            return null;
        }
        return openssl_public_encrypt($data,$encrypted,self::getPublicKey()) ? base64_encode($encrypted) : null;
    }

    /**
     * 公钥解密
     * @param string $encrypted
     * @return null
     */
    public static function publicDecrypt($encrypted = '')
    {
        if(!is_string($encrypted)){
            return null;
        }
        return (openssl_public_decrypt(base64_decode($encrypted), $decrypted, self::getPublicKey())) ? $decrypted : null;
    }

    /**
     * 私钥加密
     * @param string $data
     * @return null
     */
    public static function privateEncrypt($data = ''){
        if(!is_string($data)) {
            return null;
        }
        return openssl_private_encrypt($data,$encrypted,self::getPrivateKey()) ? base64_encode($encrypted) : null;
    }

    /**
     * 私钥解密
     * @param string $encrypted
     * @return null
     */
    public static function privateDecrypt($encrypted = '')
    {
        if(!is_string($encrypted)) {
            return null;
        }
        return (openssl_private_decrypt(base64_decode($encrypted), $decrypted, self::getPrivateKey())) ? $decrypted : null;
    }

    /**
     * 获取公钥
     * @return string
     */
    private static function getPublicKey()
    {
        $publicKey = self::$publicKey;
        return openssl_pkey_get_public( $publicKey );
    }

    /**
     * 获取私钥
     * @return string
     */
    private static function getPrivateKey()
    {
        $privateKey = self::$privateKey;
        return openssl_pkey_get_private( $privateKey );
    }
}
