<?php

namespace app\index\controller;

use app\index\service\CommonService;
use Exception;
use think\admin\Controller;
use think\App;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

/**
 * Class Index
 *
 * @package app\index\controller
 */
class Index extends Controller
{
	protected string $newsTable = 'DataNewsItem';

	protected CommonService $userService;

	public function __construct(App $app)
	{
		$this->userService = new CommonService();
		parent::__construct($app);
	}

	public function index()
	{
		$this->userService->getBaseInfo($this);

		try {
			$newsList = $this->app->db->name($this->newsTable)->where([['status', '=', 1], ['deleted', '=', 0]])->field('id,name,cover,content,create_at')->order(['sort' => 'desc', 'id' => 'desc'])->limit(10)->select()->toArray();
		} catch (Exception $exception) {
			exit('在维护');
		}

		foreach ($newsList as &$value) {
			$value['year']        = substr($value['create_at'], 0, 4);
			$value['month']       = substr($value['create_at'], 5, 2);
			$value['day']         = substr($value['create_at'], 8, 2);
			$value['word_number'] = mb_strlen(str_replace(array("\r\n", "\r", "\n"), '', strip_tags($value['content'])));

			$readTime = $value['word_number'] * 1.4362842397776895593489479952362;
			$readTime = $readTime > 60 ? (ceil($readTime / 60) . '分钟') : (ceil($readTime) . '秒');

			$value['read_time'] = $readTime;
		}

		$this->assign('title', '');
		$this->assign('news_list', $newsList);

		$this->fetch();
	}

	public function font()
	{
		$this->fetch();
	}
}