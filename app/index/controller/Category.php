<?php

namespace app\index\controller;

use app\index\service\CommonService;
use Exception;
use think\admin\Controller;
use think\App;

class Category extends Controller
{
	protected string $newsCategoryTable = 'DataNewsCategory';
	protected string $newsTable         = 'DataNewsItem';

	protected CommonService $commonService;

	public function __construct(App $app)
	{
		$this->commonService = new CommonService();
		parent::__construct($app);
	}

	public function index()
	{
		$this->commonService->getBaseInfo($this);

		try {
			$newsCategoryList = $this->app->db->name($this->newsCategoryTable)->where([['status', '=', 1], ['deleted', '=', 0]])->field('id,name')->order(['sort' => 'desc', 'id' => 'desc'])->select()->toArray();
		} catch (Exception $exception) {
			exit('在维护');
		}

		foreach ($newsCategoryList as $key => &$value) {
			$newsCount = $this->app->db->name($this->newsTable)->where([['status', '=', 1], ['deleted', '=', 0], ['category', 'like', ",{$value['id']},"]])->count();

			$value['news_count'] = $newsCount;
		}

		$this->assign('title', '全部分类 | ');
		$this->assign('news_category_list', $newsCategoryList);

		$this->fetch();
	}

	public function search()
	{
		$id = param('category');

		if (empty($id) || (int) $id === 0) {
			exit('在维护');
		}

		$condition = ",{$id},";
		try {
			$newsCategoryInfo = $this->app->db->name($this->newsCategoryTable)->where([['status', '=', 1], ['deleted', '=', 0], ['id', '=', $id]])->field('id,name')->find();
			$newsList         = $this->app->db->name($this->newsTable)->where([['status', '=', 1], ['deleted', '=', 0], ['category', 'like', "%{$condition}%"]])->field('id,name,create_at')->order(['sort' => 'desc', 'id' => 'desc'])->limit(10)->select()->toArray();
			$newsAllCount     = $this->app->db->name($this->newsTable)->where([['status', '=', 1], ['deleted', '=', 0], ['category', 'like', "%{$condition}%"]])->count();
		} catch (Exception $exception) {
			exit('在维护');
		}

		$this->commonService->getBaseInfo($this);

		foreach ($newsList as &$value) {
			$value['year']  = substr($value['create_at'], 0, 4);
			$value['month'] = substr($value['create_at'], 5, 2);
			$value['day']   = substr($value['create_at'], 8, 2);
		}

		$this->assign('title', "分类：{$newsCategoryInfo['name']} | ");
		$this->assign('news_category_info', $newsCategoryInfo);
		$this->assign('news_list', $newsList);
		$this->assign('news_all_count', $newsAllCount);

		$this->fetch();
	}
}