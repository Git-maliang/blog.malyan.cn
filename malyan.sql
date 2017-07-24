# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.18-log)
# Database: malyan
# Generation Time: 2017-07-24 10:08:12 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table ml_admin
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ml_admin`;

CREATE TABLE `ml_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) NOT NULL DEFAULT '' COMMENT '用户名',
  `auth_key` varchar(32) NOT NULL DEFAULT '' COMMENT '身份验证码',
  `password_hash` varchar(255) NOT NULL DEFAULT '' COMMENT '密码',
  `real_name` varchar(20) NOT NULL DEFAULT '' COMMENT '真实姓名',
  `mobile` bigint(11) unsigned NOT NULL DEFAULT '0' COMMENT '手机号',
  `email` varchar(50) NOT NULL DEFAULT '' COMMENT '邮箱',
  `create_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建人',
  `last_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上一次登录时间',
  `last_ip` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上一次登录IP',
  `status` tinyint(1) unsigned zerofill NOT NULL DEFAULT '1' COMMENT '状态 1正常 2禁用',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员表';

LOCK TABLES `ml_admin` WRITE;
/*!40000 ALTER TABLE `ml_admin` DISABLE KEYS */;

INSERT INTO `ml_admin` (`id`, `username`, `auth_key`, `password_hash`, `real_name`, `mobile`, `email`, `create_id`, `last_at`, `last_ip`, `status`, `created_at`)
VALUES
	(1,'admin','9u_mzCfygUHZUJN7eDWzVbEME_nc3dZf','$2y$13$ndFwFszlfmiB4/4zgTOZOeMMGmbcRieoGXlWaJOA6xhiZWsDT/UfK','超级管理员',13141234768,'13141234768@163.com',1,1498702260,2130706433,1,1498635989),
	(4,'test123456','P5E0FKvCUpo_5f4EHZgxnvVx28jeT9OB','$2y$13$KIDd/YB2/6rNWm0ABAYW7uz5nwaY.rMf.YdzgnA/SN3MyuJFuMyzq','测试账号',13123456789,'1234567890@qq.com',1,1498816266,2130706433,1,1498707912);

/*!40000 ALTER TABLE `ml_admin` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ml_article
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ml_article`;

CREATE TABLE `ml_article` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `author` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '作者',
  `category_id` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '类型',
  `browse_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `comment_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '评论次数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态（1-显示 2-不显示）',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文章表';

LOCK TABLES `ml_article` WRITE;
/*!40000 ALTER TABLE `ml_article` DISABLE KEYS */;

INSERT INTO `ml_article` (`id`, `author`, `category_id`, `browse_num`, `comment_num`, `status`, `created_at`)
VALUES
	(1,1,1,1,0,1,1500466815),
	(2,1,1,0,0,1,1500466815),
	(3,1,2,0,0,1,1500466815),
	(4,1,3,0,0,1,1500466815),
	(5,1,4,0,0,1,1500466815),
	(6,1,5,0,0,1,1500466815),
	(7,1,3,0,0,1,1500466815),
	(8,1,2,1,0,1,1500466815),
	(9,1,1,2,6,1,1500466815),
	(10,1,7,0,0,1,1500466815),
	(11,1,5,0,0,1,1500466815),
	(12,1,1,0,0,1,1500466815),
	(13,1,2,0,0,1,1500466815),
	(14,1,1,0,0,1,1500466815),
	(15,1,3,0,0,1,1500466815),
	(16,1,4,1,0,1,1500466815),
	(17,1,4,0,0,1,1500466815),
	(18,1,1,0,0,1,1500466815),
	(19,1,5,0,0,1,1500466815),
	(20,1,6,0,0,1,1500466815),
	(21,1,1,2,1,1,1500466815);

/*!40000 ALTER TABLE `ml_article` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ml_article_attach
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ml_article_attach`;

CREATE TABLE `ml_article_attach` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `article_id` int(1) NOT NULL DEFAULT '0' COMMENT '文章ID',
  `title` varchar(80) NOT NULL DEFAULT '' COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文章附加表';

LOCK TABLES `ml_article_attach` WRITE;
/*!40000 ALTER TABLE `ml_article_attach` DISABLE KEYS */;

INSERT INTO `ml_article_attach` (`id`, `article_id`, `title`, `content`)
VALUES
	(1,1,'Yii2-响应（Response）状态码 ','构建响应时，最先应做的是标识请求是否成功处理的状态，可通过设置 yii\\web\\Response::statusCode 属性，该属性使用一个有效的 HTTP 状态码。例如，为标识处理已被处理成功， 可设置状态码为200，如下所示：\r\n```\r\nYii::$app->response->statusCode = 200;\r\n```\r\n\r\n尽管如此，大多数情况下不需要明确设置状态码， 因为 yii\\web\\Response::statusCode 状态码默认为200， 如果需要指定请求失败，可抛出对应的HTTP异常，如下所示：\r\n```\r\nthrow new \\yii\\web\\NotFoundHttpException;\r\n```\r\n\r\n当错误处理器 捕获到一个异常，会从异常中提取状态码并赋值到响应， 对于上述的 yii\\web\\NotFoundHttpException 对应HTTP 404状态码， 以下为Yii预定义的HTTP异常：\r\nyii\\web\\BadRequestHttpException：状态码 400。\r\nyii\\web\\ConflictHttpException：状态码 409。\r\nyii\\web\\ForbiddenHttpException：状态码 403。\r\nyii\\web\\GoneHttpException：状态码 410。\r\nyii\\web\\MethodNotAllowedHttpException：状态码 405。\r\nyii\\web\\NotAcceptableHttpException：状态码 406。\r\nyii\\web\\NotFoundHttpException：状态码 404。\r\nyii\\web\\ServerErrorHttpException：状态码 500。\r\nyii\\web\\TooManyRequestsHttpException：状态码 429。\r\nyii\\web\\UnauthorizedHttpException：状态码 401。\r\nyii\\web\\UnsupportedMediaTypeHttpException：状态码 415。\r\n\r\n如果想抛出的异常不在如上列表中，可创建一个yii\\web\\HttpException异常， 带上状态码抛出，如下：\r\n```\r\nthrow new \\yii\\web\\HttpException(402);\r\n```'),
	(2,2,'Yii2-响应（Response）状态码 ','构建响应时，最先应做的是标识请求是否成功处理的状态，可通过设置 yii\\web\\Response::statusCode 属性，该属性使用一个有效的 HTTP 状态码。例如，为标识处理已被处理成功， 可设置状态码为200，如下所示：\r\n```\r\nYii::$app->response->statusCode = 200;\r\n```\r\n\r\n尽管如此，大多数情况下不需要明确设置状态码， 因为 yii\\web\\Response::statusCode 状态码默认为200， 如果需要指定请求失败，可抛出对应的HTTP异常，如下所示：\r\n```\r\nthrow new \\yii\\web\\NotFoundHttpException;\r\n```\r\n\r\n当错误处理器 捕获到一个异常，会从异常中提取状态码并赋值到响应， 对于上述的 yii\\web\\NotFoundHttpException 对应HTTP 404状态码， 以下为Yii预定义的HTTP异常：\r\nyii\\web\\BadRequestHttpException：状态码 400。\r\nyii\\web\\ConflictHttpException：状态码 409。\r\nyii\\web\\ForbiddenHttpException：状态码 403。\r\nyii\\web\\GoneHttpException：状态码 410。\r\nyii\\web\\MethodNotAllowedHttpException：状态码 405。\r\nyii\\web\\NotAcceptableHttpException：状态码 406。\r\nyii\\web\\NotFoundHttpException：状态码 404。\r\nyii\\web\\ServerErrorHttpException：状态码 500。\r\nyii\\web\\TooManyRequestsHttpException：状态码 429。\r\nyii\\web\\UnauthorizedHttpException：状态码 401。\r\nyii\\web\\UnsupportedMediaTypeHttpException：状态码 415。\r\n\r\n如果想抛出的异常不在如上列表中，可创建一个yii\\web\\HttpException异常， 带上状态码抛出，如下：\r\n```\r\nthrow new \\yii\\web\\HttpException(402);\r\n```'),
	(3,3,'Yii2-响应（Response）状态码 ','构建响应时，最先应做的是标识请求是否成功处理的状态，可通过设置 yii\\web\\Response::statusCode 属性，该属性使用一个有效的 HTTP 状态码。例如，为标识处理已被处理成功， 可设置状态码为200，如下所示：\r\n```\r\nYii::$app->response->statusCode = 200;\r\n```\r\n\r\n尽管如此，大多数情况下不需要明确设置状态码， 因为 yii\\web\\Response::statusCode 状态码默认为200， 如果需要指定请求失败，可抛出对应的HTTP异常，如下所示：\r\n```\r\nthrow new \\yii\\web\\NotFoundHttpException;\r\n```\r\n\r\n当错误处理器 捕获到一个异常，会从异常中提取状态码并赋值到响应， 对于上述的 yii\\web\\NotFoundHttpException 对应HTTP 404状态码， 以下为Yii预定义的HTTP异常：\r\nyii\\web\\BadRequestHttpException：状态码 400。\r\nyii\\web\\ConflictHttpException：状态码 409。\r\nyii\\web\\ForbiddenHttpException：状态码 403。\r\nyii\\web\\GoneHttpException：状态码 410。\r\nyii\\web\\MethodNotAllowedHttpException：状态码 405。\r\nyii\\web\\NotAcceptableHttpException：状态码 406。\r\nyii\\web\\NotFoundHttpException：状态码 404。\r\nyii\\web\\ServerErrorHttpException：状态码 500。\r\nyii\\web\\TooManyRequestsHttpException：状态码 429。\r\nyii\\web\\UnauthorizedHttpException：状态码 401。\r\nyii\\web\\UnsupportedMediaTypeHttpException：状态码 415。\r\n\r\n如果想抛出的异常不在如上列表中，可创建一个yii\\web\\HttpException异常， 带上状态码抛出，如下：\r\n```\r\nthrow new \\yii\\web\\HttpException(402);\r\n```'),
	(4,4,'Yii2-响应（Response）状态码 ','构建响应时，最先应做的是标识请求是否成功处理的状态，可通过设置 yii\\web\\Response::statusCode 属性，该属性使用一个有效的 HTTP 状态码。例如，为标识处理已被处理成功， 可设置状态码为200，如下所示：\r\n```\r\nYii::$app->response->statusCode = 200;\r\n```\r\n\r\n尽管如此，大多数情况下不需要明确设置状态码， 因为 yii\\web\\Response::statusCode 状态码默认为200， 如果需要指定请求失败，可抛出对应的HTTP异常，如下所示：\r\n```\r\nthrow new \\yii\\web\\NotFoundHttpException;\r\n```\r\n\r\n当错误处理器 捕获到一个异常，会从异常中提取状态码并赋值到响应， 对于上述的 yii\\web\\NotFoundHttpException 对应HTTP 404状态码， 以下为Yii预定义的HTTP异常：\r\nyii\\web\\BadRequestHttpException：状态码 400。\r\nyii\\web\\ConflictHttpException：状态码 409。\r\nyii\\web\\ForbiddenHttpException：状态码 403。\r\nyii\\web\\GoneHttpException：状态码 410。\r\nyii\\web\\MethodNotAllowedHttpException：状态码 405。\r\nyii\\web\\NotAcceptableHttpException：状态码 406。\r\nyii\\web\\NotFoundHttpException：状态码 404。\r\nyii\\web\\ServerErrorHttpException：状态码 500。\r\nyii\\web\\TooManyRequestsHttpException：状态码 429。\r\nyii\\web\\UnauthorizedHttpException：状态码 401。\r\nyii\\web\\UnsupportedMediaTypeHttpException：状态码 415。\r\n\r\n如果想抛出的异常不在如上列表中，可创建一个yii\\web\\HttpException异常， 带上状态码抛出，如下：\r\n```\r\nthrow new \\yii\\web\\HttpException(402);\r\n```'),
	(5,5,'Yii2-响应（Response）状态码 ','构建响应时，最先应做的是标识请求是否成功处理的状态，可通过设置 yii\\web\\Response::statusCode 属性，该属性使用一个有效的 HTTP 状态码。例如，为标识处理已被处理成功， 可设置状态码为200，如下所示：\r\n```\r\nYii::$app->response->statusCode = 200;\r\n```\r\n\r\n尽管如此，大多数情况下不需要明确设置状态码， 因为 yii\\web\\Response::statusCode 状态码默认为200， 如果需要指定请求失败，可抛出对应的HTTP异常，如下所示：\r\n```\r\nthrow new \\yii\\web\\NotFoundHttpException;\r\n```\r\n\r\n当错误处理器 捕获到一个异常，会从异常中提取状态码并赋值到响应， 对于上述的 yii\\web\\NotFoundHttpException 对应HTTP 404状态码， 以下为Yii预定义的HTTP异常：\r\nyii\\web\\BadRequestHttpException：状态码 400。\r\nyii\\web\\ConflictHttpException：状态码 409。\r\nyii\\web\\ForbiddenHttpException：状态码 403。\r\nyii\\web\\GoneHttpException：状态码 410。\r\nyii\\web\\MethodNotAllowedHttpException：状态码 405。\r\nyii\\web\\NotAcceptableHttpException：状态码 406。\r\nyii\\web\\NotFoundHttpException：状态码 404。\r\nyii\\web\\ServerErrorHttpException：状态码 500。\r\nyii\\web\\TooManyRequestsHttpException：状态码 429。\r\nyii\\web\\UnauthorizedHttpException：状态码 401。\r\nyii\\web\\UnsupportedMediaTypeHttpException：状态码 415。\r\n\r\n如果想抛出的异常不在如上列表中，可创建一个yii\\web\\HttpException异常， 带上状态码抛出，如下：\r\n```\r\nthrow new \\yii\\web\\HttpException(402);\r\n```'),
	(6,6,'Yii2-响应（Response）状态码 ','构建响应时，最先应做的是标识请求是否成功处理的状态，可通过设置 yii\\web\\Response::statusCode 属性，该属性使用一个有效的 HTTP 状态码。例如，为标识处理已被处理成功， 可设置状态码为200，如下所示：\r\n```\r\nYii::$app->response->statusCode = 200;\r\n```\r\n\r\n尽管如此，大多数情况下不需要明确设置状态码， 因为 yii\\web\\Response::statusCode 状态码默认为200， 如果需要指定请求失败，可抛出对应的HTTP异常，如下所示：\r\n```\r\nthrow new \\yii\\web\\NotFoundHttpException;\r\n```\r\n\r\n当错误处理器 捕获到一个异常，会从异常中提取状态码并赋值到响应， 对于上述的 yii\\web\\NotFoundHttpException 对应HTTP 404状态码， 以下为Yii预定义的HTTP异常：\r\nyii\\web\\BadRequestHttpException：状态码 400。\r\nyii\\web\\ConflictHttpException：状态码 409。\r\nyii\\web\\ForbiddenHttpException：状态码 403。\r\nyii\\web\\GoneHttpException：状态码 410。\r\nyii\\web\\MethodNotAllowedHttpException：状态码 405。\r\nyii\\web\\NotAcceptableHttpException：状态码 406。\r\nyii\\web\\NotFoundHttpException：状态码 404。\r\nyii\\web\\ServerErrorHttpException：状态码 500。\r\nyii\\web\\TooManyRequestsHttpException：状态码 429。\r\nyii\\web\\UnauthorizedHttpException：状态码 401。\r\nyii\\web\\UnsupportedMediaTypeHttpException：状态码 415。\r\n\r\n如果想抛出的异常不在如上列表中，可创建一个yii\\web\\HttpException异常， 带上状态码抛出，如下：\r\n```\r\nthrow new \\yii\\web\\HttpException(402);\r\n```'),
	(7,7,'Yii2-响应（Response）状态码 ','构建响应时，最先应做的是标识请求是否成功处理的状态，可通过设置 yii\\web\\Response::statusCode 属性，该属性使用一个有效的 HTTP 状态码。例如，为标识处理已被处理成功， 可设置状态码为200，如下所示：\r\n```\r\nYii::$app->response->statusCode = 200;\r\n```\r\n\r\n尽管如此，大多数情况下不需要明确设置状态码， 因为 yii\\web\\Response::statusCode 状态码默认为200， 如果需要指定请求失败，可抛出对应的HTTP异常，如下所示：\r\n```\r\nthrow new \\yii\\web\\NotFoundHttpException;\r\n```\r\n\r\n当错误处理器 捕获到一个异常，会从异常中提取状态码并赋值到响应， 对于上述的 yii\\web\\NotFoundHttpException 对应HTTP 404状态码， 以下为Yii预定义的HTTP异常：\r\nyii\\web\\BadRequestHttpException：状态码 400。\r\nyii\\web\\ConflictHttpException：状态码 409。\r\nyii\\web\\ForbiddenHttpException：状态码 403。\r\nyii\\web\\GoneHttpException：状态码 410。\r\nyii\\web\\MethodNotAllowedHttpException：状态码 405。\r\nyii\\web\\NotAcceptableHttpException：状态码 406。\r\nyii\\web\\NotFoundHttpException：状态码 404。\r\nyii\\web\\ServerErrorHttpException：状态码 500。\r\nyii\\web\\TooManyRequestsHttpException：状态码 429。\r\nyii\\web\\UnauthorizedHttpException：状态码 401。\r\nyii\\web\\UnsupportedMediaTypeHttpException：状态码 415。\r\n\r\n如果想抛出的异常不在如上列表中，可创建一个yii\\web\\HttpException异常， 带上状态码抛出，如下：\r\n```\r\nthrow new \\yii\\web\\HttpException(402);\r\n```'),
	(8,8,'Yii2-响应（Response）状态码 ','构建响应时，最先应做的是标识请求是否成功处理的状态，可通过设置 yii\\web\\Response::statusCode 属性，该属性使用一个有效的 HTTP 状态码。例如，为标识处理已被处理成功， 可设置状态码为200，如下所示：\r\n```\r\nYii::$app->response->statusCode = 200;\r\n```\r\n\r\n尽管如此，大多数情况下不需要明确设置状态码， 因为 yii\\web\\Response::statusCode 状态码默认为200， 如果需要指定请求失败，可抛出对应的HTTP异常，如下所示：\r\n```\r\nthrow new \\yii\\web\\NotFoundHttpException;\r\n```\r\n\r\n当错误处理器 捕获到一个异常，会从异常中提取状态码并赋值到响应， 对于上述的 yii\\web\\NotFoundHttpException 对应HTTP 404状态码， 以下为Yii预定义的HTTP异常：\r\nyii\\web\\BadRequestHttpException：状态码 400。\r\nyii\\web\\ConflictHttpException：状态码 409。\r\nyii\\web\\ForbiddenHttpException：状态码 403。\r\nyii\\web\\GoneHttpException：状态码 410。\r\nyii\\web\\MethodNotAllowedHttpException：状态码 405。\r\nyii\\web\\NotAcceptableHttpException：状态码 406。\r\nyii\\web\\NotFoundHttpException：状态码 404。\r\nyii\\web\\ServerErrorHttpException：状态码 500。\r\nyii\\web\\TooManyRequestsHttpException：状态码 429。\r\nyii\\web\\UnauthorizedHttpException：状态码 401。\r\nyii\\web\\UnsupportedMediaTypeHttpException：状态码 415。\r\n\r\n如果想抛出的异常不在如上列表中，可创建一个yii\\web\\HttpException异常， 带上状态码抛出，如下：\r\n```\r\nthrow new \\yii\\web\\HttpException(402);\r\n```'),
	(9,9,'Yii2-响应（Response）状态码 ','构建响应时，最先应做的是标识请求是否成功处理的状态，可通过设置 yii\\web\\Response::statusCode 属性，该属性使用一个有效的 HTTP 状态码。例如，为标识处理已被处理成功， 可设置状态码为200，如下所示：\r\n```\r\nYii::$app->response->statusCode = 200;\r\n```\r\n\r\n尽管如此，大多数情况下不需要明确设置状态码， 因为 yii\\web\\Response::statusCode 状态码默认为200， 如果需要指定请求失败，可抛出对应的HTTP异常，如下所示：\r\n```\r\nthrow new \\yii\\web\\NotFoundHttpException;\r\n```\r\n\r\n当错误处理器 捕获到一个异常，会从异常中提取状态码并赋值到响应， 对于上述的 yii\\web\\NotFoundHttpException 对应HTTP 404状态码， 以下为Yii预定义的HTTP异常：\r\nyii\\web\\BadRequestHttpException：状态码 400。\r\nyii\\web\\ConflictHttpException：状态码 409。\r\nyii\\web\\ForbiddenHttpException：状态码 403。\r\nyii\\web\\GoneHttpException：状态码 410。\r\nyii\\web\\MethodNotAllowedHttpException：状态码 405。\r\nyii\\web\\NotAcceptableHttpException：状态码 406。\r\nyii\\web\\NotFoundHttpException：状态码 404。\r\nyii\\web\\ServerErrorHttpException：状态码 500。\r\nyii\\web\\TooManyRequestsHttpException：状态码 429。\r\nyii\\web\\UnauthorizedHttpException：状态码 401。\r\nyii\\web\\UnsupportedMediaTypeHttpException：状态码 415。\r\n\r\n如果想抛出的异常不在如上列表中，可创建一个yii\\web\\HttpException异常， 带上状态码抛出，如下：\r\n```\r\nthrow new \\yii\\web\\HttpException(402);\r\n```'),
	(10,10,'Yii2-响应（Response）状态码 ','构建响应时，最先应做的是标识请求是否成功处理的状态，可通过设置 yii\\web\\Response::statusCode 属性，该属性使用一个有效的 HTTP 状态码。例如，为标识处理已被处理成功， 可设置状态码为200，如下所示：\r\n```\r\nYii::$app->response->statusCode = 200;\r\n```\r\n\r\n尽管如此，大多数情况下不需要明确设置状态码， 因为 yii\\web\\Response::statusCode 状态码默认为200， 如果需要指定请求失败，可抛出对应的HTTP异常，如下所示：\r\n```\r\nthrow new \\yii\\web\\NotFoundHttpException;\r\n```\r\n\r\n当错误处理器 捕获到一个异常，会从异常中提取状态码并赋值到响应， 对于上述的 yii\\web\\NotFoundHttpException 对应HTTP 404状态码， 以下为Yii预定义的HTTP异常：\r\nyii\\web\\BadRequestHttpException：状态码 400。\r\nyii\\web\\ConflictHttpException：状态码 409。\r\nyii\\web\\ForbiddenHttpException：状态码 403。\r\nyii\\web\\GoneHttpException：状态码 410。\r\nyii\\web\\MethodNotAllowedHttpException：状态码 405。\r\nyii\\web\\NotAcceptableHttpException：状态码 406。\r\nyii\\web\\NotFoundHttpException：状态码 404。\r\nyii\\web\\ServerErrorHttpException：状态码 500。\r\nyii\\web\\TooManyRequestsHttpException：状态码 429。\r\nyii\\web\\UnauthorizedHttpException：状态码 401。\r\nyii\\web\\UnsupportedMediaTypeHttpException：状态码 415。\r\n\r\n如果想抛出的异常不在如上列表中，可创建一个yii\\web\\HttpException异常， 带上状态码抛出，如下：\r\n```\r\nthrow new \\yii\\web\\HttpException(402);\r\n```'),
	(11,11,'Yii2-响应（Response）状态码 ','构建响应时，最先应做的是标识请求是否成功处理的状态，可通过设置 yii\\web\\Response::statusCode 属性，该属性使用一个有效的 HTTP 状态码。例如，为标识处理已被处理成功， 可设置状态码为200，如下所示：\r\n```\r\nYii::$app->response->statusCode = 200;\r\n```\r\n\r\n尽管如此，大多数情况下不需要明确设置状态码， 因为 yii\\web\\Response::statusCode 状态码默认为200， 如果需要指定请求失败，可抛出对应的HTTP异常，如下所示：\r\n```\r\nthrow new \\yii\\web\\NotFoundHttpException;\r\n```\r\n\r\n当错误处理器 捕获到一个异常，会从异常中提取状态码并赋值到响应， 对于上述的 yii\\web\\NotFoundHttpException 对应HTTP 404状态码， 以下为Yii预定义的HTTP异常：\r\nyii\\web\\BadRequestHttpException：状态码 400。\r\nyii\\web\\ConflictHttpException：状态码 409。\r\nyii\\web\\ForbiddenHttpException：状态码 403。\r\nyii\\web\\GoneHttpException：状态码 410。\r\nyii\\web\\MethodNotAllowedHttpException：状态码 405。\r\nyii\\web\\NotAcceptableHttpException：状态码 406。\r\nyii\\web\\NotFoundHttpException：状态码 404。\r\nyii\\web\\ServerErrorHttpException：状态码 500。\r\nyii\\web\\TooManyRequestsHttpException：状态码 429。\r\nyii\\web\\UnauthorizedHttpException：状态码 401。\r\nyii\\web\\UnsupportedMediaTypeHttpException：状态码 415。\r\n\r\n如果想抛出的异常不在如上列表中，可创建一个yii\\web\\HttpException异常， 带上状态码抛出，如下：\r\n```\r\nthrow new \\yii\\web\\HttpException(402);\r\n```'),
	(12,12,'Yii2-响应（Response）状态码 ','构建响应时，最先应做的是标识请求是否成功处理的状态，可通过设置 yii\\web\\Response::statusCode 属性，该属性使用一个有效的 HTTP 状态码。例如，为标识处理已被处理成功， 可设置状态码为200，如下所示：\r\n```\r\nYii::$app->response->statusCode = 200;\r\n```\r\n\r\n尽管如此，大多数情况下不需要明确设置状态码， 因为 yii\\web\\Response::statusCode 状态码默认为200， 如果需要指定请求失败，可抛出对应的HTTP异常，如下所示：\r\n```\r\nthrow new \\yii\\web\\NotFoundHttpException;\r\n```\r\n\r\n当错误处理器 捕获到一个异常，会从异常中提取状态码并赋值到响应， 对于上述的 yii\\web\\NotFoundHttpException 对应HTTP 404状态码， 以下为Yii预定义的HTTP异常：\r\nyii\\web\\BadRequestHttpException：状态码 400。\r\nyii\\web\\ConflictHttpException：状态码 409。\r\nyii\\web\\ForbiddenHttpException：状态码 403。\r\nyii\\web\\GoneHttpException：状态码 410。\r\nyii\\web\\MethodNotAllowedHttpException：状态码 405。\r\nyii\\web\\NotAcceptableHttpException：状态码 406。\r\nyii\\web\\NotFoundHttpException：状态码 404。\r\nyii\\web\\ServerErrorHttpException：状态码 500。\r\nyii\\web\\TooManyRequestsHttpException：状态码 429。\r\nyii\\web\\UnauthorizedHttpException：状态码 401。\r\nyii\\web\\UnsupportedMediaTypeHttpException：状态码 415。\r\n\r\n如果想抛出的异常不在如上列表中，可创建一个yii\\web\\HttpException异常， 带上状态码抛出，如下：\r\n```\r\nthrow new \\yii\\web\\HttpException(402);\r\n```'),
	(13,13,'Yii2-响应（Response）状态码 ','构建响应时，最先应做的是标识请求是否成功处理的状态，可通过设置 yii\\web\\Response::statusCode 属性，该属性使用一个有效的 HTTP 状态码。例如，为标识处理已被处理成功， 可设置状态码为200，如下所示：\r\n```\r\nYii::$app->response->statusCode = 200;\r\n```\r\n\r\n尽管如此，大多数情况下不需要明确设置状态码， 因为 yii\\web\\Response::statusCode 状态码默认为200， 如果需要指定请求失败，可抛出对应的HTTP异常，如下所示：\r\n```\r\nthrow new \\yii\\web\\NotFoundHttpException;\r\n```\r\n\r\n当错误处理器 捕获到一个异常，会从异常中提取状态码并赋值到响应， 对于上述的 yii\\web\\NotFoundHttpException 对应HTTP 404状态码， 以下为Yii预定义的HTTP异常：\r\nyii\\web\\BadRequestHttpException：状态码 400。\r\nyii\\web\\ConflictHttpException：状态码 409。\r\nyii\\web\\ForbiddenHttpException：状态码 403。\r\nyii\\web\\GoneHttpException：状态码 410。\r\nyii\\web\\MethodNotAllowedHttpException：状态码 405。\r\nyii\\web\\NotAcceptableHttpException：状态码 406。\r\nyii\\web\\NotFoundHttpException：状态码 404。\r\nyii\\web\\ServerErrorHttpException：状态码 500。\r\nyii\\web\\TooManyRequestsHttpException：状态码 429。\r\nyii\\web\\UnauthorizedHttpException：状态码 401。\r\nyii\\web\\UnsupportedMediaTypeHttpException：状态码 415。\r\n\r\n如果想抛出的异常不在如上列表中，可创建一个yii\\web\\HttpException异常， 带上状态码抛出，如下：\r\n```\r\nthrow new \\yii\\web\\HttpException(402);\r\n```'),
	(14,14,'Yii2-响应（Response）状态码 ','构建响应时，最先应做的是标识请求是否成功处理的状态，可通过设置 yii\\web\\Response::statusCode 属性，该属性使用一个有效的 HTTP 状态码。例如，为标识处理已被处理成功， 可设置状态码为200，如下所示：\r\n```\r\nYii::$app->response->statusCode = 200;\r\n```\r\n\r\n尽管如此，大多数情况下不需要明确设置状态码， 因为 yii\\web\\Response::statusCode 状态码默认为200， 如果需要指定请求失败，可抛出对应的HTTP异常，如下所示：\r\n```\r\nthrow new \\yii\\web\\NotFoundHttpException;\r\n```\r\n\r\n当错误处理器 捕获到一个异常，会从异常中提取状态码并赋值到响应， 对于上述的 yii\\web\\NotFoundHttpException 对应HTTP 404状态码， 以下为Yii预定义的HTTP异常：\r\nyii\\web\\BadRequestHttpException：状态码 400。\r\nyii\\web\\ConflictHttpException：状态码 409。\r\nyii\\web\\ForbiddenHttpException：状态码 403。\r\nyii\\web\\GoneHttpException：状态码 410。\r\nyii\\web\\MethodNotAllowedHttpException：状态码 405。\r\nyii\\web\\NotAcceptableHttpException：状态码 406。\r\nyii\\web\\NotFoundHttpException：状态码 404。\r\nyii\\web\\ServerErrorHttpException：状态码 500。\r\nyii\\web\\TooManyRequestsHttpException：状态码 429。\r\nyii\\web\\UnauthorizedHttpException：状态码 401。\r\nyii\\web\\UnsupportedMediaTypeHttpException：状态码 415。\r\n\r\n如果想抛出的异常不在如上列表中，可创建一个yii\\web\\HttpException异常， 带上状态码抛出，如下：\r\n```\r\nthrow new \\yii\\web\\HttpException(402);\r\n```'),
	(15,15,'Yii2-响应（Response）状态码 ','构建响应时，最先应做的是标识请求是否成功处理的状态，可通过设置 yii\\web\\Response::statusCode 属性，该属性使用一个有效的 HTTP 状态码。例如，为标识处理已被处理成功， 可设置状态码为200，如下所示：\r\n```\r\nYii::$app->response->statusCode = 200;\r\n```\r\n\r\n尽管如此，大多数情况下不需要明确设置状态码， 因为 yii\\web\\Response::statusCode 状态码默认为200， 如果需要指定请求失败，可抛出对应的HTTP异常，如下所示：\r\n```\r\nthrow new \\yii\\web\\NotFoundHttpException;\r\n```\r\n\r\n当错误处理器 捕获到一个异常，会从异常中提取状态码并赋值到响应， 对于上述的 yii\\web\\NotFoundHttpException 对应HTTP 404状态码， 以下为Yii预定义的HTTP异常：\r\nyii\\web\\BadRequestHttpException：状态码 400。\r\nyii\\web\\ConflictHttpException：状态码 409。\r\nyii\\web\\ForbiddenHttpException：状态码 403。\r\nyii\\web\\GoneHttpException：状态码 410。\r\nyii\\web\\MethodNotAllowedHttpException：状态码 405。\r\nyii\\web\\NotAcceptableHttpException：状态码 406。\r\nyii\\web\\NotFoundHttpException：状态码 404。\r\nyii\\web\\ServerErrorHttpException：状态码 500。\r\nyii\\web\\TooManyRequestsHttpException：状态码 429。\r\nyii\\web\\UnauthorizedHttpException：状态码 401。\r\nyii\\web\\UnsupportedMediaTypeHttpException：状态码 415。\r\n\r\n如果想抛出的异常不在如上列表中，可创建一个yii\\web\\HttpException异常， 带上状态码抛出，如下：\r\n```\r\nthrow new \\yii\\web\\HttpException(402);\r\n```'),
	(16,16,'Yii2-响应（Response）状态码 ','构建响应时，最先应做的是标识请求是否成功处理的状态，可通过设置 yii\\web\\Response::statusCode 属性，该属性使用一个有效的 HTTP 状态码。例如，为标识处理已被处理成功， 可设置状态码为200，如下所示：\r\n```\r\nYii::$app->response->statusCode = 200;\r\n```\r\n\r\n尽管如此，大多数情况下不需要明确设置状态码， 因为 yii\\web\\Response::statusCode 状态码默认为200， 如果需要指定请求失败，可抛出对应的HTTP异常，如下所示：\r\n```\r\nthrow new \\yii\\web\\NotFoundHttpException;\r\n```\r\n\r\n当错误处理器 捕获到一个异常，会从异常中提取状态码并赋值到响应， 对于上述的 yii\\web\\NotFoundHttpException 对应HTTP 404状态码， 以下为Yii预定义的HTTP异常：\r\nyii\\web\\BadRequestHttpException：状态码 400。\r\nyii\\web\\ConflictHttpException：状态码 409。\r\nyii\\web\\ForbiddenHttpException：状态码 403。\r\nyii\\web\\GoneHttpException：状态码 410。\r\nyii\\web\\MethodNotAllowedHttpException：状态码 405。\r\nyii\\web\\NotAcceptableHttpException：状态码 406。\r\nyii\\web\\NotFoundHttpException：状态码 404。\r\nyii\\web\\ServerErrorHttpException：状态码 500。\r\nyii\\web\\TooManyRequestsHttpException：状态码 429。\r\nyii\\web\\UnauthorizedHttpException：状态码 401。\r\nyii\\web\\UnsupportedMediaTypeHttpException：状态码 415。\r\n\r\n如果想抛出的异常不在如上列表中，可创建一个yii\\web\\HttpException异常， 带上状态码抛出，如下：\r\n```\r\nthrow new \\yii\\web\\HttpException(402);\r\n```'),
	(17,17,'Yii2-响应（Response）状态码 ','构建响应时，最先应做的是标识请求是否成功处理的状态，可通过设置 yii\\web\\Response::statusCode 属性，该属性使用一个有效的 HTTP 状态码。例如，为标识处理已被处理成功， 可设置状态码为200，如下所示：\r\n```\r\nYii::$app->response->statusCode = 200;\r\n```\r\n\r\n尽管如此，大多数情况下不需要明确设置状态码， 因为 yii\\web\\Response::statusCode 状态码默认为200， 如果需要指定请求失败，可抛出对应的HTTP异常，如下所示：\r\n```\r\nthrow new \\yii\\web\\NotFoundHttpException;\r\n```\r\n\r\n当错误处理器 捕获到一个异常，会从异常中提取状态码并赋值到响应， 对于上述的 yii\\web\\NotFoundHttpException 对应HTTP 404状态码， 以下为Yii预定义的HTTP异常：\r\nyii\\web\\BadRequestHttpException：状态码 400。\r\nyii\\web\\ConflictHttpException：状态码 409。\r\nyii\\web\\ForbiddenHttpException：状态码 403。\r\nyii\\web\\GoneHttpException：状态码 410。\r\nyii\\web\\MethodNotAllowedHttpException：状态码 405。\r\nyii\\web\\NotAcceptableHttpException：状态码 406。\r\nyii\\web\\NotFoundHttpException：状态码 404。\r\nyii\\web\\ServerErrorHttpException：状态码 500。\r\nyii\\web\\TooManyRequestsHttpException：状态码 429。\r\nyii\\web\\UnauthorizedHttpException：状态码 401。\r\nyii\\web\\UnsupportedMediaTypeHttpException：状态码 415。\r\n\r\n如果想抛出的异常不在如上列表中，可创建一个yii\\web\\HttpException异常， 带上状态码抛出，如下：\r\n```\r\nthrow new \\yii\\web\\HttpException(402);\r\n```'),
	(18,18,'Yii2-响应（Response）状态码 ','构建响应时，最先应做的是标识请求是否成功处理的状态，可通过设置 yii\\web\\Response::statusCode 属性，该属性使用一个有效的 HTTP 状态码。例如，为标识处理已被处理成功， 可设置状态码为200，如下所示：\r\n```\r\nYii::$app->response->statusCode = 200;\r\n```\r\n\r\n尽管如此，大多数情况下不需要明确设置状态码， 因为 yii\\web\\Response::statusCode 状态码默认为200， 如果需要指定请求失败，可抛出对应的HTTP异常，如下所示：\r\n```\r\nthrow new \\yii\\web\\NotFoundHttpException;\r\n```\r\n\r\n当错误处理器 捕获到一个异常，会从异常中提取状态码并赋值到响应， 对于上述的 yii\\web\\NotFoundHttpException 对应HTTP 404状态码， 以下为Yii预定义的HTTP异常：\r\nyii\\web\\BadRequestHttpException：状态码 400。\r\nyii\\web\\ConflictHttpException：状态码 409。\r\nyii\\web\\ForbiddenHttpException：状态码 403。\r\nyii\\web\\GoneHttpException：状态码 410。\r\nyii\\web\\MethodNotAllowedHttpException：状态码 405。\r\nyii\\web\\NotAcceptableHttpException：状态码 406。\r\nyii\\web\\NotFoundHttpException：状态码 404。\r\nyii\\web\\ServerErrorHttpException：状态码 500。\r\nyii\\web\\TooManyRequestsHttpException：状态码 429。\r\nyii\\web\\UnauthorizedHttpException：状态码 401。\r\nyii\\web\\UnsupportedMediaTypeHttpException：状态码 415。\r\n\r\n如果想抛出的异常不在如上列表中，可创建一个yii\\web\\HttpException异常， 带上状态码抛出，如下：\r\n```\r\nthrow new \\yii\\web\\HttpException(402);\r\n```'),
	(19,19,'Yii2-响应（Response）状态码 ','构建响应时，最先应做的是标识请求是否成功处理的状态，可通过设置 yii\\web\\Response::statusCode 属性，该属性使用一个有效的 HTTP 状态码。例如，为标识处理已被处理成功， 可设置状态码为200，如下所示：\r\n```\r\nYii::$app->response->statusCode = 200;\r\n```\r\n\r\n尽管如此，大多数情况下不需要明确设置状态码， 因为 yii\\web\\Response::statusCode 状态码默认为200， 如果需要指定请求失败，可抛出对应的HTTP异常，如下所示：\r\n```\r\nthrow new \\yii\\web\\NotFoundHttpException;\r\n```\r\n\r\n当错误处理器 捕获到一个异常，会从异常中提取状态码并赋值到响应， 对于上述的 yii\\web\\NotFoundHttpException 对应HTTP 404状态码， 以下为Yii预定义的HTTP异常：\r\nyii\\web\\BadRequestHttpException：状态码 400。\r\nyii\\web\\ConflictHttpException：状态码 409。\r\nyii\\web\\ForbiddenHttpException：状态码 403。\r\nyii\\web\\GoneHttpException：状态码 410。\r\nyii\\web\\MethodNotAllowedHttpException：状态码 405。\r\nyii\\web\\NotAcceptableHttpException：状态码 406。\r\nyii\\web\\NotFoundHttpException：状态码 404。\r\nyii\\web\\ServerErrorHttpException：状态码 500。\r\nyii\\web\\TooManyRequestsHttpException：状态码 429。\r\nyii\\web\\UnauthorizedHttpException：状态码 401。\r\nyii\\web\\UnsupportedMediaTypeHttpException：状态码 415。\r\n\r\n如果想抛出的异常不在如上列表中，可创建一个yii\\web\\HttpException异常， 带上状态码抛出，如下：\r\n```\r\nthrow new \\yii\\web\\HttpException(402);\r\n```'),
	(20,20,'Yii2-响应（Response）状态码 ','构建响应时，最先应做的是标识请求是否成功处理的状态，可通过设置 yii\\web\\Response::statusCode 属性，该属性使用一个有效的 HTTP 状态码。例如，为标识处理已被处理成功， 可设置状态码为200，如下所示：\r\n```\r\nYii::$app->response->statusCode = 200;\r\n```\r\n\r\n尽管如此，大多数情况下不需要明确设置状态码， 因为 yii\\web\\Response::statusCode 状态码默认为200， 如果需要指定请求失败，可抛出对应的HTTP异常，如下所示：\r\n```\r\nthrow new \\yii\\web\\NotFoundHttpException;\r\n```\r\n\r\n当错误处理器 捕获到一个异常，会从异常中提取状态码并赋值到响应， 对于上述的 yii\\web\\NotFoundHttpException 对应HTTP 404状态码， 以下为Yii预定义的HTTP异常：\r\nyii\\web\\BadRequestHttpException：状态码 400。\r\nyii\\web\\ConflictHttpException：状态码 409。\r\nyii\\web\\ForbiddenHttpException：状态码 403。\r\nyii\\web\\GoneHttpException：状态码 410。\r\nyii\\web\\MethodNotAllowedHttpException：状态码 405。\r\nyii\\web\\NotAcceptableHttpException：状态码 406。\r\nyii\\web\\NotFoundHttpException：状态码 404。\r\nyii\\web\\ServerErrorHttpException：状态码 500。\r\nyii\\web\\TooManyRequestsHttpException：状态码 429。\r\nyii\\web\\UnauthorizedHttpException：状态码 401。\r\nyii\\web\\UnsupportedMediaTypeHttpException：状态码 415。\r\n\r\n如果想抛出的异常不在如上列表中，可创建一个yii\\web\\HttpException异常， 带上状态码抛出，如下：\r\n```\r\nthrow new \\yii\\web\\HttpException(402);\r\n```'),
	(21,21,'Yii2-响应（Response）状态码 ','构建响应时，最先应做的是标识请求是否成功处理的状态，可通过设置 yii\\web\\Response::statusCode 属性，该属性使用一个有效的 HTTP 状态码。例如，为标识处理已被处理成功， 可设置状态码为200，如下所示：\r\n```\r\nYii::$app->response->statusCode = 200;\r\n```\r\n\r\n尽管如此，大多数情况下不需要明确设置状态码， 因为 yii\\web\\Response::statusCode 状态码默认为200， 如果需要指定请求失败，可抛出对应的HTTP异常，如下所示：\r\n```\r\nthrow new \\yii\\web\\NotFoundHttpException;\r\n```\r\n\r\n当错误处理器 捕获到一个异常，会从异常中提取状态码并赋值到响应， 对于上述的 yii\\web\\NotFoundHttpException 对应HTTP 404状态码， 以下为Yii预定义的HTTP异常：\r\nyii\\web\\BadRequestHttpException：状态码 400。\r\nyii\\web\\ConflictHttpException：状态码 409。\r\nyii\\web\\ForbiddenHttpException：状态码 403。\r\nyii\\web\\GoneHttpException：状态码 410。\r\nyii\\web\\MethodNotAllowedHttpException：状态码 405。\r\nyii\\web\\NotAcceptableHttpException：状态码 406。\r\nyii\\web\\NotFoundHttpException：状态码 404。\r\nyii\\web\\ServerErrorHttpException：状态码 500。\r\nyii\\web\\TooManyRequestsHttpException：状态码 429。\r\nyii\\web\\UnauthorizedHttpException：状态码 401。\r\nyii\\web\\UnsupportedMediaTypeHttpException：状态码 415。\r\n\r\n如果想抛出的异常不在如上列表中，可创建一个yii\\web\\HttpException异常， 带上状态码抛出，如下：\r\n```\r\nthrow new \\yii\\web\\HttpException(402);\r\n```');

/*!40000 ALTER TABLE `ml_article_attach` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ml_article_category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ml_article_category`;

CREATE TABLE `ml_article_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '名称',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文章分类表';

LOCK TABLES `ml_article_category` WRITE;
/*!40000 ALTER TABLE `ml_article_category` DISABLE KEYS */;

INSERT INTO `ml_article_category` (`id`, `name`, `created_at`)
VALUES
	(1,'PHP',1498702260),
	(2,'Mysql',1498702260),
	(3,'Linux',1498702260),
	(4,'Html',1498702260),
	(5,'Jquery',1498702260),
	(6,'Nginx',1498702260),
	(7,'Web安全',1498702260);

/*!40000 ALTER TABLE `ml_article_category` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ml_article_comment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ml_article_comment`;

CREATE TABLE `ml_article_comment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `article_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '文章ID',
  `comment_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '回复评论ID',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `answer_user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '回复用户ID',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '评论内容',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论表';

LOCK TABLES `ml_article_comment` WRITE;
/*!40000 ALTER TABLE `ml_article_comment` DISABLE KEYS */;

INSERT INTO `ml_article_comment` (`id`, `article_id`, `comment_id`, `user_id`, `answer_user_id`, `content`, `created_at`)
VALUES
	(1,9,0,1,0,'nihao',0),
	(2,9,0,1,0,'好啊',1500544344),
	(3,9,2,1,0,'真好啊',1500544352),
	(4,9,2,1,0,'是啊啊',1500544401),
	(5,9,2,1,0,'？',1500616745),
	(6,9,2,1,0,'hao',1500618094),
	(7,9,0,1,0,'a',1500618546),
	(8,9,0,1,0,'gg',1500618559),
	(9,9,0,1,0,'呵呵',1500618698),
	(10,9,0,1,0,'真的吗？\r\n啊啊？\r\n',1500623514),
	(11,21,0,2,0,'好',1500885870);

/*!40000 ALTER TABLE `ml_article_comment` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ml_auth_assignment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ml_auth_assignment`;

CREATE TABLE `ml_auth_assignment` (
  `item_name` varchar(64) NOT NULL DEFAULT '' COMMENT '角色',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`item_name`,`admin_id`),
  CONSTRAINT `md_auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `ml_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员用户表';

LOCK TABLES `ml_auth_assignment` WRITE;
/*!40000 ALTER TABLE `ml_auth_assignment` DISABLE KEYS */;

INSERT INTO `ml_auth_assignment` (`item_name`, `admin_id`, `created_at`)
VALUES
	('普通用户',4,1498792424),
	('超级管理员',1,1498784219);

/*!40000 ALTER TABLE `ml_auth_assignment` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ml_auth_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ml_auth_item`;

CREATE TABLE `ml_auth_item` (
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '权限,角色',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '类型 1-角色 2-权限',
  `describe` varchar(64) NOT NULL DEFAULT '' COMMENT '描述',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`name`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限角色表';

LOCK TABLES `ml_auth_item` WRITE;
/*!40000 ALTER TABLE `ml_auth_item` DISABLE KEYS */;

INSERT INTO `ml_auth_item` (`name`, `type`, `describe`, `created_at`)
VALUES
	('admin/create',2,'管理员创建',1498785080),
	('admin/delete',2,'管理员删除',1498813582),
	('admin/list',2,'管理员信息',1498784196),
	('admin/update',2,'管理员更新',1498813563),
	('admin/view',2,'管理员查看',1498785079),
	('article/list',2,'文章管理',1500530783),
	('blog',2,'博客管理',1500530755),
	('link/list',2,'友情链接',1500532054),
	('menu/create',2,'菜单创建',1498815600),
	('menu/delete',2,'菜单删除',1498815679),
	('menu/list',2,'菜单管理',1498784219),
	('menu/update',2,'菜单更新',1498815664),
	('menu/view',2,'菜单查看',1498815628),
	('operate/list',2,'操作日志管理',1498784223),
	('permission/create',2,'权限创建',1498815229),
	('permission/delete',2,'权限删除',1498815272),
	('permission/list',2,'权限管理',1498784211),
	('permission/update',2,'权限更新',1498815247),
	('role/auth',2,'分配权限',1498815199),
	('role/create',2,'角色创建',1498815046),
	('role/delete',2,'角色删除',1498815183),
	('role/list',2,'角色管理',1498784200),
	('role/update',2,'角色更新',1498815101),
	('system',2,'系统管理',1498784188),
	('普通用户',1,'只有查看部分菜单的权限',1498721936),
	('超级管理员',1,'具有所有的权限，拥有更改系统的权限',1498707912);

/*!40000 ALTER TABLE `ml_auth_item` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ml_auth_item_child
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ml_auth_item_child`;

CREATE TABLE `ml_auth_item_child` (
  `parent` varchar(64) NOT NULL DEFAULT '' COMMENT '角色',
  `child` varchar(64) NOT NULL DEFAULT '' COMMENT '权限',
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`),
  CONSTRAINT `md_auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `ml_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `md_auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `ml_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色权限关系表';

LOCK TABLES `ml_auth_item_child` WRITE;
/*!40000 ALTER TABLE `ml_auth_item_child` DISABLE KEYS */;

INSERT INTO `ml_auth_item_child` (`parent`, `child`)
VALUES
	('admin/list','admin/create'),
	('超级管理员','admin/create'),
	('admin/list','admin/delete'),
	('超级管理员','admin/delete'),
	('普通用户','admin/list'),
	('超级管理员','admin/list'),
	('admin/list','admin/update'),
	('超级管理员','admin/update'),
	('admin/list','admin/view'),
	('普通用户','admin/view'),
	('超级管理员','admin/view'),
	('超级管理员','article/list'),
	('超级管理员','blog'),
	('menu/list','menu/create'),
	('超级管理员','menu/create'),
	('menu/list','menu/delete'),
	('超级管理员','menu/delete'),
	('普通用户','menu/list'),
	('超级管理员','menu/list'),
	('menu/list','menu/update'),
	('超级管理员','menu/update'),
	('menu/list','menu/view'),
	('普通用户','menu/view'),
	('超级管理员','menu/view'),
	('普通用户','operate/list'),
	('超级管理员','operate/list'),
	('permission/list','permission/create'),
	('超级管理员','permission/create'),
	('permission/list','permission/delete'),
	('超级管理员','permission/delete'),
	('普通用户','permission/list'),
	('超级管理员','permission/list'),
	('permission/list','permission/update'),
	('超级管理员','permission/update'),
	('role/list','role/auth'),
	('超级管理员','role/auth'),
	('role/list','role/create'),
	('超级管理员','role/create'),
	('role/list','role/delete'),
	('超级管理员','role/delete'),
	('普通用户','role/list'),
	('超级管理员','role/list'),
	('role/list','role/update'),
	('超级管理员','role/update'),
	('普通用户','system'),
	('超级管理员','system');

/*!40000 ALTER TABLE `ml_auth_item_child` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ml_link
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ml_link`;

CREATE TABLE `ml_link` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(80) NOT NULL DEFAULT '' COMMENT '标题',
  `link` varchar(80) NOT NULL DEFAULT '' COMMENT '链接',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态(1-显示，2-不显示)',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='友情链接表';

LOCK TABLES `ml_link` WRITE;
/*!40000 ALTER TABLE `ml_link` DISABLE KEYS */;

INSERT INTO `ml_link` (`id`, `title`, `link`, `sort`, `status`, `created_at`)
VALUES
	(1,'Yii Framework 中文社区','http://www.yiichina.com/',1,1,1494490235),
	(2,'Bootstrap','http://v3.bootcss.com/',2,1,1494490235),
	(3,'Layui 前端框架','https://www.layui.com/',3,1,1494490235),
	(4,'FontAwesome 图标样式CSS','http://www.yeahzan.com/fa/facss.html',4,1,1494490235),
	(5,'百度','http://www.baidu.com',5,1,1494490235),
	(6,'FontAwesome 图标样式CSS','http://www.yeahzan.com/fa/facss.html',6,1,1494490235);

/*!40000 ALTER TABLE `ml_link` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ml_menu
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ml_menu`;

CREATE TABLE `ml_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '菜单名称',
  `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父级ID',
  `icon` varchar(32) NOT NULL DEFAULT '' COMMENT '图标',
  `route` varchar(64) NOT NULL DEFAULT '' COMMENT '路由规则',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `ml_menu` WRITE;
/*!40000 ALTER TABLE `ml_menu` DISABLE KEYS */;

INSERT INTO `ml_menu` (`id`, `name`, `pid`, `icon`, `route`, `sort`, `created_at`)
VALUES
	(1,'系统管理',0,'fa-cog','system',1,0),
	(2,'管理员信息',1,'','admin/list',1,0),
	(3,'角色管理',1,'','role/list',2,0),
	(4,'权限管理',1,'','permission/list',3,0),
	(5,'菜单管理',1,'','menu/list',4,0),
	(6,'操作日志管理',1,'','operate/list',5,0),
	(10,'博客管理',0,'fa-bold','blog',1000,1500530755),
	(11,'文章管理',10,'','article/list',1000,1500530783),
	(12,'友情链接',10,'','link/list',1000,1500532054);

/*!40000 ALTER TABLE `ml_menu` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ml_operate_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ml_operate_log`;

CREATE TABLE `ml_operate_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `operate_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '操作ID',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '操作类型',
  `module` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '操作模块',
  `describe` varchar(40) CHARACTER SET utf8 NOT NULL DEFAULT 'NUll' COMMENT '操作描述',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '操作人',
  `ip` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'IP',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `INDEX_OPERATE` (`type`,`module`,`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='操作日志表';

LOCK TABLES `ml_operate_log` WRITE;
/*!40000 ALTER TABLE `ml_operate_log` DISABLE KEYS */;

INSERT INTO `ml_operate_log` (`id`, `operate_id`, `type`, `module`, `describe`, `admin_id`, `ip`, `created_at`)
VALUES
	(1,10,2,4,'',1,2130706433,1498470063),
	(2,10,2,4,'',1,2130706433,1498471379),
	(3,12,1,4,'',1,2130706433,1498471400),
	(4,12,3,4,'',1,2130706433,1498471478),
	(5,8,3,4,'',1,2130706433,1498471533),
	(6,1,7,4,'',1,2130706433,1498471558),
	(7,13,1,4,'',1,2130706433,1498471916),
	(8,13,3,4,'',1,2130706433,1498471923),
	(9,1,7,4,'',1,2130706433,1498521496),
	(10,12,1,4,'',1,2130706433,1498635916),
	(11,12,3,4,'',1,2130706433,1498635989),
	(12,0,1,2,'',1,2130706433,1498721179),
	(13,0,1,2,'创建角色',1,2130706433,1498721936),
	(14,0,2,2,'更新角色',1,2130706433,1498721978),
	(15,0,2,2,'更新角色',1,2130706433,1498722010),
	(16,0,2,2,'更新角色( 普通用户 )',1,2130706433,1498722277),
	(17,0,2,2,'( 普通用户 )',1,2130706433,1498722356),
	(18,1,2,4,'',1,2130706433,1498784061),
	(19,1,2,4,'',1,2130706433,1498784188),
	(20,2,2,4,'',1,2130706433,1498784196),
	(21,3,2,4,'',1,2130706433,1498784201),
	(22,4,2,4,'',1,2130706433,1498784211),
	(23,5,2,4,'',1,2130706433,1498784219),
	(24,6,2,4,'',1,2130706433,1498784223),
	(25,11,3,4,'',1,2130706433,1498784630),
	(26,10,3,4,'',1,2130706433,1498784633),
	(27,9,3,4,'',1,2130706433,1498784636),
	(28,7,3,4,'',1,2130706433,1498784638),
	(29,0,1,3,'( admin/create )',1,2130706433,1498785080),
	(30,4,2,1,'',1,2130706433,1498791576),
	(31,4,2,1,'',1,2130706433,1498792424),
	(32,0,4,2,'( 超级管理员 )',1,2130706433,1498807891),
	(33,0,4,2,'( 超级管理员 )',1,2130706433,1498807979),
	(34,0,4,2,'( 超级管理员 )',1,2130706433,1498807983),
	(35,7,1,4,'',1,2130706433,1498811883),
	(36,8,1,4,'',1,2130706433,1498811926),
	(37,9,1,4,'',1,2130706433,1498811953),
	(38,0,4,2,'( 普通用户 )',1,2130706433,1498812026),
	(39,4,2,1,'',4,2130706433,1498812100),
	(40,0,1,3,'( admin/update )',1,2130706433,1498813563),
	(41,0,1,3,'( admin/delete )',1,2130706433,1498813582),
	(42,0,1,3,'( admin/view )',1,2130706433,1498813622),
	(43,0,4,2,'( 普通用户 )',1,2130706433,1498813632),
	(44,8,3,4,'',1,2130706433,1498814968),
	(45,9,3,4,'',1,2130706433,1498814976),
	(46,7,3,4,'',1,2130706433,1498814978),
	(47,0,1,3,'( role/create )',1,2130706433,1498815046),
	(48,0,1,3,'( role/update )',1,2130706433,1498815101),
	(49,0,1,3,'( role/delete )',1,2130706433,1498815183),
	(50,0,1,3,'( role/auth )',1,2130706433,1498815199),
	(51,0,1,3,'( permission/create )',1,2130706433,1498815229),
	(52,0,1,3,'( permission/update )',1,2130706433,1498815247),
	(53,0,1,3,'( permission/delete )',1,2130706433,1498815272),
	(54,0,1,3,'( menu/view )',1,2130706433,1498815628),
	(55,0,1,3,'( menu/create )',1,2130706433,1498815645),
	(56,0,1,3,'( menu/update )',1,2130706433,1498815664),
	(57,0,1,3,'( menu/delete )',1,2130706433,1498815679),
	(58,0,4,2,'( 普通用户 )',1,2130706433,1498815718),
	(59,4,2,1,'',1,2130706433,1498815809),
	(60,0,4,2,'( 普通用户 )',1,2130706433,1498816247),
	(61,10,1,4,'',1,2130706433,1500530755),
	(62,11,1,4,'',1,2130706433,1500530784),
	(63,0,4,2,'( 超级管理员 )',1,2130706433,1500530816),
	(64,12,1,4,'',1,2130706433,1500532054);

/*!40000 ALTER TABLE `ml_operate_log` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ml_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ml_user`;

CREATE TABLE `ml_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) NOT NULL DEFAULT '' COMMENT '用户名',
  `auth_key` varchar(32) NOT NULL DEFAULT '' COMMENT '身份验证码',
  `password_hash` varchar(255) NOT NULL DEFAULT '' COMMENT '密码',
  `nickname` varchar(20) NOT NULL DEFAULT '' COMMENT '昵称',
  `avatar` varchar(100) NOT NULL DEFAULT '' COMMENT '头像',
  `status` tinyint(1) unsigned zerofill NOT NULL DEFAULT '0' COMMENT '状态 1正常 2禁用',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员表';

LOCK TABLES `ml_user` WRITE;
/*!40000 ALTER TABLE `ml_user` DISABLE KEYS */;

INSERT INTO `ml_user` (`id`, `username`, `auth_key`, `password_hash`, `nickname`, `avatar`, `status`, `created_at`)
VALUES
	(1,'master@malyan.cn','9u_mzCfygUHZUJN7eDWzVbEME_nc3dZf','$2y$13$ndFwFszlfmiB4/4zgTOZOeMMGmbcRieoGXlWaJOA6xhiZWsDT/UfK','小马哥','http://image.malyan.cn/blog/user_1.jpg',1,1498702260),
	(2,'13141234768@163.com','4_cdO1BybLF0zxV_Mj3_fA23sV8P6Oys','$2y$13$pdVryvPk3OFqrli6yhoGg.84d24/wAImkoICl8p733vxT3DwWo3ii','小马哥','http://image.malyan.cn/blog/1500884546889046.jpg',1,1500884547);

/*!40000 ALTER TABLE `ml_user` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
