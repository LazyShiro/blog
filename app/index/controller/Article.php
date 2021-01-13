<?php

namespace app\index\controller;

use app\index\service\CommonService;
use Exception;
use think\admin\Controller;
use think\App;

class Article extends Controller
{
	protected string $newsItemTable     = 'DataNewsItem';
	protected string $newsMarkTable     = 'DataNewsMark';
	protected string $newsCategoryTable = 'DataNewsCategory';

	protected CommonService $commonService;

	public function __construct(App $app)
	{
		$this->commonService = new CommonService();
		parent::__construct($app);
	}

	public function index()
	{
		$id = param('id');

		if (empty($id) || (int) $id === 0) {
			exit('在维护，懒得写页面了2');
		}

		try {
			if (empty((request()->header('cache-control')))) {
				$this->app->db->name($this->newsItemTable)->where([['status', '=', 1], ['deleted', '=', 0], ['id', '=', $id]])->inc('num_read')->update();
			}

			$newsInfo = $this->app->db->name($this->newsItemTable)->where([['status', '=', 1], ['deleted', '=', 0], ['id', '=', $id]])->field('id,name,mark,cover,content,num_like,num_read,num_collect,num_comment,create_at,update_at')->find();

			$newsInfo['mark'] = $this->app->db->name($this->newsMarkTable)->where([['status', '=', 1], ['deleted', '=', 0], ['id', 'in', str2arr($newsInfo['mark'])]])->column('id,name');

			$newsPrev = $this->app->db->name($this->newsItemTable)->where([['status', '=', 1], ['deleted', '=', 0], ['id', '<', $id]])->order(['id' => 'desc'])->field('id,name,category,cover')->find();
			$newsNext = $this->app->db->name($this->newsItemTable)->where([['status', '=', 1], ['deleted', '=', 0], ['id', '>', $id]])->order(['id' => 'asc'])->field('id,name,category,cover')->find();
		} catch (Exception $exception) {
			exit('在维护，懒得写页面了3');
		}

		$this->commonService->getBaseInfo($this);

		$newsInfo['create_date'] = getYearMonthDay($newsInfo['create_at']);
		$newsInfo['update_date'] = getYearMonthDay($newsInfo['update_at']);
		$newsInfo['word_number'] = getRealWordNumber($newsInfo['content']);
		$newsInfo['read_time']   = getReadTime($newsInfo['word_number']);

		if (!empty($newsPrev)) {
			$categoryInfo = getCategoryInfo($this, $this->newsCategoryTable, $newsPrev['category']);

			$newsPrev['category_id']   = $categoryInfo['id'];
			$newsPrev['category_name'] = $categoryInfo['name'];
		}

		if (!empty($newsNext)) {
			$categoryInfo = getCategoryInfo($this, $this->newsCategoryTable, $newsNext['category']);

			$newsNext['category_id']   = $categoryInfo['id'];
			$newsNext['category_name'] = $categoryInfo['name'];
		}

		$this->assign('title', $newsInfo['name'] . ' | ');
		$this->assign('news_info', $newsInfo);
		$this->assign('news_prev', $newsPrev);
		$this->assign('news_next', $newsNext);

		$this->fetch();
	}

	public function list()
	{
		$page  = param('page');
		$limit = 10;

		try {
			$newsList = $this->app->db->name($this->newsItemTable)->where([['status', '=', 1], ['deleted', '=', 0]])->field('id,name,cover,content,create_at')->order(['sort' => 'desc', 'id' => 'desc'])->limit(getOffset($page, $limit), $limit)->select()->toArray();
			foreach ($newsList as &$value) {
				$value['year']        = getYear($value['create_at']);
				$value['month']       = getMonth($value['create_at']);
				$value['day']         = getDay($value['create_at']);
				$value['word_number'] = getRealWordNumber($value['content']);
				$value['read_time']   = getReadTime($value['word_number']);
			}
			returnData($newsList);
		} catch (Exception $exception) {
			returnData();
		}
	}
}