<?php

namespace app\index\service;

use Exception;

class CommonService
{
	protected $userTable         = 'SystemUser';
	protected $newsTable         = 'DataNewsItem';
	protected $newsCategoryTable = 'DataNewsCategory';
	protected $newsMarkTable     = 'DataNewsMark';
	protected $pictureTable      = 'DataPictureItem';

	public function getBaseInfo($object)
	{
		try {
			$userInfo    = $object->app->db->name($this->userTable)->where([['id', '=', 10000]])->field('nickname,headimg,contact_qq,contact_mail,contact_phone,describe,extra')->find();
			$pictureList = $object->app->db->name($this->pictureTable)->where([['status', '=', 1], ['deleted', '=', 0]])->field('url')->orderRand()->limit(10)->select();
		} catch (Exception $exception) {
			exit('在维护，懒得写页面了');
		}

		$newsCount         = $object->app->db->name($this->newsTable)->where([['status', '=', 1], ['deleted', '=', 0]])->count();
		$newsCategoryCount = $object->app->db->name($this->newsCategoryTable)->where([['status', '=', 1], ['deleted', '=', 0]])->count();
		$newsMarkCount     = $object->app->db->name($this->newsMarkTable)->where([['status', '=', 1], ['deleted', '=', 0]])->count();

		$userInfoExtra     = json_decode($userInfo['extra'], true);
		$userInfo['extra'] = [];
		foreach ($userInfoExtra as $key => $value) {
			$userInfoExtraTem = [
				'sign'          => $key,
				'class'         => ($key === 'music' ? 'cloud-' : '') . $key,
				'address'       => $value,
				'addressBase64' => base64_encode($value),
			];
			array_push($userInfo['extra'], $userInfoExtraTem);
		}

		$object->assign('user_info', $userInfo);
		$object->assign('picture_list', $pictureList);
		$object->assign('news_count', $newsCount);
		$object->assign('news_category_count', $newsCategoryCount);
		$object->assign('news_mark_count', $newsMarkCount);
	}
}