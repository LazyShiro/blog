easyblog
===============

> 运行环境要求PHP7.1+。

## 说明

* 后端框架使用ThinkPHP 6.0.*
* 前端模板使用shoka

## 使用

* 导入数据库，sql文件在根目录，blog.sql
* cp .env.example .env
* 修改env文件里的数据库相关配置
* 如果没有CDN，把/public下static_local更名为static
* 如果有CDN，把/public下static_cdn所有文件里包含resource.an0nymou5.com的信息修改为自己的cdn信息，再把.env里的[COMMON]RESOURCE_BASE_URL按照格式改为自己的cdn信息
* 上述两种方案选定之后，修改对应方案里的如下位置。
* 到 [LeanCloud](https://www.leancloud.cn/) 获取appid、appkey后，修改 [方案]/index/js/app.js 里的leancloud appid 和 leancloud appkey
* 到 [algolia](https://www.algolia.com/) 获取appid、apikey、indexname后，修改 [方案]/index/js/app.js 里的algolia appid、algolia apikey和algolia indexname
* mkdir runtime
* chmod 777 runtime

## 注意

* 不要随意composer update，如有需要请单独update某个依赖
* 网站已经配置好之后不要频繁清空runtime
* 如果使用有问题那就是还未开发完毕，麻烦提个issue，求你了
* 禁止吐槽代码质量，毕竟我只是一个三十岁不到的孩子
* 熟悉hexo的同学肯定知道这真是一个脱裤子放屁的好项目

## 感谢(排名不分先后)

* [ThinkPHP](http://www.thinkphp.cn/) 6 项目全体人员
* [ThinkAdmin](https://thinkadmin.top/) 6 项目全体人员
* [shoka](https://shoka.lostyu.me/) 主题制作人 霜月琉璃
