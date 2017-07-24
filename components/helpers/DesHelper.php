<?php
/**
 * Created by PhpStorm.
 * User: M
 * Date: 17/7/24
 * Time: 上午11:07
 */

namespace app\components\helpers;

/**
 * 将用户信息加密/解密，用于cookie等 CBC模式 密钥为24位16进制 向量为8
 */
class DesHelper
{
    private static $desKey = 'yqpwXq1OuU0tc5PibrB61j9Rz5EoolSn';
    private static $desIv = 'vPlljOWLALHYbZ5d';
    
    /**
     * 加密
     * @param $data
     * @return mixed
     */
    public static function encode($data)
    {
        if(is_array($data)){
            return self::desEncode(json_encode($data), self::$desKey, self::$desIv);
        }
    }

    /**
     * 解密
     * @param $token
     * @return mixed
     */
    public static function decode($token)
    {
        if(is_string($token)){
            return json_decode(self::desDecode($token, self::$desKey, self::$desIv), true);
        }
    }

    /**
     * @param $data
     * @param $desKey
     * @param $desIv
     * @return mixed
     */
    public static function desEncode($data, $desKey, $desIv )
    {
        $desKey = self::hexToString($desKey);
        $desIv  = self::hexToString($desIv);
        $TokenValue  = self::desCbcEncode($data, $desKey, $desIv);
        $TokenValue = base64_encode($TokenValue);
        return $TokenValue;
    }

    /**
     * @param $token
     * @param $desKey
     * @param $desIv
     * @return bool
     */
    public static function desDecode($token, $desKey, $desIv)
    {
        $desKey = self::hexToString($desKey);
        $desIv  = self::hexToString($desIv);
        $responseToken = trim($token);
        $responseToken = base64_decode($responseToken);
        $responseValue = self::desCbcDecode($responseToken, $desKey, $desIv);
        return $responseValue;
    }

    /**
     * 加密
     * @param $data
     * @param $theKey
     * @param string $theIv
     * @param $encodeType
     * @param string $mod
     * @return bool
     */
    public static function desCbcEncode($data, $theKey, $theIv = "", $encodeType = MCRYPT_TRIPLEDES, $mod = MCRYPT_MODE_CBC)
    {
        $td = mcrypt_module_open($encodeType, '', $mod, '');
        if($td == false) {
            return false;
        }

        if($theIv == "") {
            $iv = mcrypt_create_iv(mcrypt_enc_get_iv_size($td), MCRYPT_RAND );
        } else {
            $iv = $theIv;
        }

        $ks = mcrypt_enc_get_key_size($td);
        $key = substr($theKey, 0, $ks);

        if(mcrypt_generic_init($td, $key, $iv) < 0) {
            mcrypt_module_close($td);
            return false;
        }

        $blockSize = mcrypt_module_get_algo_block_size ($encodeType);
        $tmpLen = $blockSize - strlen($data)% $blockSize;
        for($i = 0; $i < $tmpLen; $i++) {
            $data .= pack("h", $tmpLen);
        }

        $encodeStr = mcrypt_generic($td, $data);
        mcrypt_generic_deinit($td);
        mcrypt_module_close($td);

        return $encodeStr;
    }

    /**
     * 解密
     * @param $data
     * @param $theKey
     * @param string $theIv
     * @param $encodeType
     * @param string $mod
     * @return bool
     */
    public static function desCbcDecode($data, $theKey, $theIv = '', $encodeType= MCRYPT_TRIPLEDES, $mod = MCRYPT_MODE_CBC)
    {
        $td = mcrypt_module_open($encodeType, '', $mod, '');
        if($td == false) {
            return false;
        }

        if($theIv == "") {
            $iv = mcrypt_create_iv(mcrypt_enc_get_iv_size($td), MCRYPT_RAND);
        } else {
            $iv = $theIv;
        }

        $ks = mcrypt_enc_get_key_size($td);
        $key = substr($theKey, 0, $ks);

        if(mcrypt_generic_init($td, $key, $iv) < 0) {
            mcrypt_module_close($td);
            return false;
        }
        $decodeStr = mdecrypt_generic($td, $data);
        mcrypt_generic_deinit($td);
        mcrypt_module_close($td);

        $strLen = strlen($decodeStr);
        $theLastPosChar =  substr($decodeStr, -1);
        $theFill = hexdec(bin2hex($theLastPosChar));
        $decodeStr = substr($decodeStr, 0, $strLen - $theFill);

        return $decodeStr;
    }

    /**
     * 将Hex转化成字符串
     * @param $hex
     * @return string
     */
    public static function hexToString($hex)
    {
        $temp = "";
        for($i=2; $i<strlen($hex)+2; $i+=2) {
            $temp .= chr(hexdec(substr($hex, $i-2, 2)));
        }
        return $temp;
    }

    /**
     * 调用MD5加密
     * @param $val
     * @return mixed
     */
    public static function binMd5($val)
    {
        return pack("H32",md5($val));
    }
}
