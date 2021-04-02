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
	protected string $newsTable         = 'DataNewsItem';
	protected string $newsCategoryTable = 'DataNewsCategory';

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
			$newsTopList = $this->app->db->name($this->newsTable)->where([['status', '=', 1], ['deleted', '=', 0], ['top', '=', 1]])->field('id,name,category,cover,remark,content,create_at')->order(['sort' => 'desc', 'id' => 'desc'])->limit(3)->select()->toArray();
			$newsList    = $this->app->db->name($this->newsTable)->where([['status', '=', 1], ['deleted', '=', 0], ['top', '=', 0]])->field('id,name,category,cover,remark,content,create_at')->order(['sort' => 'desc', 'id' => 'desc'])->limit(10)->select()->toArray();
		} catch (Exception $exception) {
			exit('在维护，懒得写页面了11');
		}

		foreach ($newsTopList as &$value) {
			$categoryInfo = getCategoryInfo($this, $this->newsCategoryTable, $value['category']);

			$value['category_id']   = $categoryInfo['id'];
			$value['category_name'] = $categoryInfo['name'];
			$value['year']          = getYear($value['create_at']);
			$value['month']         = getMonth($value['create_at']);
			$value['day']           = getDay($value['create_at']);
			$value['word_number']   = getRealWordNumber($value['content']);
			$value['read_time']     = getReadTime($value['word_number']);
		}
		unset($value);

		foreach ($newsList as &$value) {
			$categoryInfo = getCategoryInfo($this, $this->newsCategoryTable, $value['category']);

			$value['category_id']   = $categoryInfo['id'];
			$value['category_name'] = $categoryInfo['name'];
			$value['year']          = getYear($value['create_at']);
			$value['month']         = getMonth($value['create_at']);
			$value['day']           = getDay($value['create_at']);
			$value['word_number']   = getRealWordNumber($value['content']);
			$value['read_time']     = getReadTime($value['word_number']);
		}
		unset($value);

		$this->assign('title');
		$this->assign('news_top_list', $newsTopList);
		$this->assign('news_list', $newsList);

		$this->fetch();
	}

	public function font()
	{
		$this->fetch();
	}
}