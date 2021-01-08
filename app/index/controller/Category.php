<?php

namespace app\index\controller;

use app\index\service\CommonService;
use Exception;
use think\admin\Controller;
use think\App;

class Category extends Controller
{
	protected $newsCategoryTable = 'DataNewsCategory';
	protected $newsTable         = 'DataNewsItem';

	protected $commonService;

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
			exit('在维护，懒得写页面了7');
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
		$id    = param('category');
		$page  = param('page', 1);
		$limit = param('limit', 10);

		if (empty($id) || (int) $id === 0) {
			exit('在维护，懒得写页面了8');
		}

		$condition = ",{$id},";
		try {
			$newsCategoryInfo = $this->app->db->name($this->newsCategoryTable)->where([['status', '=', 1], ['deleted', '=', 0], ['id', '=', $id]])->field('id,name')->find();
			$newsList         = $this->app->db->name($this->newsTable)->where([['status', '=', 1], ['deleted', '=', 0], ['category', 'like', "%{$condition}%"]])->field('id,name,create_at')->order(['sort' => 'desc', 'id' => 'desc'])->limit(getOffset($page, $limit), $limit)->select()->toArray();
			$newsAllCount     = $this->app->db->name($this->newsTable)->where([['status', '=', 1], ['deleted', '=', 0], ['category', 'like', "%{$condition}%"]])->count();
		} catch (Exception $exception) {
			exit('在维护，懒得写页面了9');
		}

		$this->commonService->getBaseInfo($this);

		foreach ($newsList as &$value) {
			$value['year']  = getYear($value['create_at']);
			$value['month'] = getMonth($value['create_at']);
			$value['day']   = getDay($value['create_at']);
		}

		$totalPage = ceil($newsAllCount / $limit);

		$this->assign('title', "分类：" . deleteHtmlTags(['del'], $newsCategoryInfo['name']) . " | ");
		$this->assign('news_category_info', $newsCategoryInfo);
		$this->assign('news_list', $newsList);
		$this->assign('news_all_count', $newsAllCount);

		$this->assign('category', $id);
		$this->assign('prev_page', ($page - 1));
		$this->assign('current_page', $page);
		$this->assign('next_page', ($page + 1));
		$this->assign('total_page', $totalPage);
		$this->assign('list_page', getPageList($page, $totalPage));
		$this->fetch();
	}
}