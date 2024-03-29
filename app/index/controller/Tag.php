<?php

namespace app\index\controller;

use app\index\service\CommonService;
use Exception;
use think\admin\Controller;
use think\App;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class Tag extends Controller
{
	protected string $newsTable         = 'DataNewsItem';
	protected string $newsTagTable      = 'DataNewsMark';
	protected string $newsCategoryTable = 'DataNewsCategory';

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
			$newsTagList = $this->app->db->name($this->newsTagTable)->where([['status', '=', 1], ['deleted', '=', 0]])->field('id,name')->order(['sort' => 'desc', 'id' => 'desc'])->select()->toArray();
		} catch (Exception $exception) {
			exit('在维护，懒得写页面了12');
		}

		foreach ($newsTagList as $key => &$value) {
			$newsCount = $this->app->db->name($this->newsTable)->where([['status', '=', 1], ['deleted', '=', 0], ['mark', 'like', "%,{$value['id']},%"]])->count();

			$value['news_count'] = $newsCount;
			$value['font_size']  = rand(16, 22);
			$value['font_color'] = dechex(rand(0, 16777215));
		}

		$this->assign('title', '全部标签 | ');
		$this->assign('news_tag_list', $newsTagList);

		$this->fetch();
	}

	public function search()
	{
		$id    = param('tag');
		$page  = param('page', 1);
		$limit = param('limit', 10);

		if (empty($id) || (int) $id === 0) {
			exit('在维护，懒得写页面了13');
		}

		$condition = ",{$id},";
		try {
			$newsTagInfo  = $this->app->db->name($this->newsTagTable)->where([['status', '=', 1], ['deleted', '=', 0], ['id', '=', $id]])->field('id,name')->find();
			$newsList     = $this->app->db->name($this->newsTable)->where([['status', '=', 1], ['deleted', '=', 0], ['mark', 'like', "%{$condition}%"]])->field('id,name,category,create_at')->order(['sort' => 'desc', 'id' => 'desc'])->limit(getOffset($page, $limit), $limit)->select()->toArray();
			$newsAllCount = $this->app->db->name($this->newsTable)->where([['status', '=', 1], ['deleted', '=', 0], ['mark', 'like', "%{$condition}%"]])->count();
		} catch (Exception $exception) {
			exit('在维护，懒得写页面了14');
		}

		$this->commonService->getBaseInfo($this);

		foreach ($newsList as &$value) {
			$categoryInfo = getCategoryInfo($this, $this->newsCategoryTable, $value['category']);

			$value['category_id']   = $categoryInfo['id'];
			$value['category_name'] = $categoryInfo['name'];
			$value['year']          = getYear($value['create_at']);
			$value['month']         = getMonth($value['create_at']);
			$value['day']           = getDay($value['create_at']);
		}

		$totalPage = ceil($newsAllCount / $limit);

		$this->assign('title', "标签：{$newsTagInfo['name']} | ");
		$this->assign('news_mark_info', $newsTagInfo);
		$this->assign('news_list', $newsList);

		$this->assign('tag', $id);
		$this->assign('prev_page', ($page - 1));
		$this->assign('current_page', $page);
		$this->assign('next_page', ($page + 1));
		$this->assign('total_page', $totalPage);
		$this->assign('list_page', getPageList($page, $totalPage));

		$this->fetch();
	}
}