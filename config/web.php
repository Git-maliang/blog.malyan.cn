<?php
$env = require(__DIR__ . '/env.php');
$_ENV = array_merge($_ENV, $env);
$config = [
    'id' => 'basic',
    'name'       => '博客',
    'basePath' => dirname(__DIR__),
    'bootstrap' => ['log'],
    'defaultRoute' => 'index/index',
    'controllerNamespace' => 'app\controllers',
    'modules'    => [],
    'language'   => 'zh-CN',
    'components' => require(__DIR__ . '/components.php'),
    'params' => require(__DIR__ . '/params.php'),
    'aliases' => [
        '@static' => '../../image.malyan.cn/blog',
        '@staticroot' => '../../image.malyan.cn/blog',
        '@imageHost' => 'https://image.malyan.cn/blog',
        '@imageHostPath' => '../../image.malyan.cn/blog',
        '@staticHost' => 'https://static.malyan.cn/blog',
        '@fileHost' => 'https://file.malyan.cn/blog',
    ],
];

if (YII_ENV_DEV) {
    $config['bootstrap'][] = 'debug';
    $config['modules']['debug'] = [
        'class' => 'yii\debug\Module',
        'allowedIPs' => ['127.0.0.1', '::1'],
    ];

    $config['bootstrap'][] = 'gii';
    $config['modules']['gii'] = [
        'class' => 'yii\gii\Module',
        'allowedIPs' => ['127.0.0.1', '::1'],
    ];
}

return $config;
