<?php

use think\facade\Route;

//文章详情
Route::get(':id', 'article/index')->pattern(['id' => '\d+']);

//归档
Route::get('archives', 'Archives/index');
Route::get('archives/:year', 'Archives/search')->pattern(['year' => '\d+']);
Route::get('archives/:year/:month', 'Archives/search')->pattern(['year' => '\d+', 'month' => '\d+']);

//分类
Route::get('category', 'Category/index');
Route::get('category/:category', 'Category/search')->pattern(['category' => '\d+']);
Route::get('category/:category/:page', 'Category/search')->pattern(['category' => '\d+', 'page' => '\d+']);

//标签
Route::get('tag/', 'Tag/index');
Route::get('tag/:tag', 'Tag/search')->pattern(['tag' => '\d+']);
Route::get('tag/:tag/:page', 'Tag/search')->pattern(['tag' => '\d+', 'page' => '\d+']);

//友链
Route::get('friend', 'Friend/index');
Route::get('friend/:xx', 'Friend/index');

//测试输出所有font-awesome
Route::get('font', 'Index/font');

