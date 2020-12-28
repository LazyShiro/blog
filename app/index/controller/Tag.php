<?php

namespace app\index\controller;

use app\index\service\CommonService;
use Exception;
use think\admin\Controller;
use think\App;

class Tag extends Controller
{
	protected $newsTagTable = 'DataNewsMark';
	protected $newsTable    = 'DataNewsItem';

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
			$newsTagList = $this->app->db->name($this->newsTagTable)->where([['status', '=', 1], ['deleted', '=', 0]])->field('id,name')->order(['sort' => 'desc', 'id' => 'desc'])->select()->toArray();
		} catch (Exception $exception) {
			exit('在维护');
		}

		foreach ($newsTagList as $key => &$value) {
			$newsCount = $this->app->db->name($this->newsTable)->where([['status', '=', 1], ['deleted', '=', 0], ['mark', 'like', ",{$value['id']},"]])->count();

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
		$id = param('tag');

		if (empty($id) || (int) $id === 0) {
			exit('在维护');
		}

		$condition = ",{$id},";
		try {
			$newsTagInfo  = $this->app->db->name($this->newsTagTable)->where([['status', '=', 1], ['deleted', '=', 0], ['id', '=', $id]])->field('id,name')->find();
			$newsList     = $this->app->db->name($this->newsTable)->where([['status', '=', 1], ['deleted', '=', 0], ['mark', 'like', "%{$condition}%"]])->field('id,name,create_at')->order(['sort' => 'desc', 'id' => 'desc'])->limit(10)->select()->toArray();
			$newsAllCount = $this->app->db->name($this->newsTable)->where([['status', '=', 1], ['deleted', '=', 0], ['mark', 'like', "%{$condition}%"]])->count();
		} catch (Exception $exception) {
			exit('在维护');
		}

		$this->commonService->getBaseInfo($this);

		foreach ($newsList as &$value) {
			$value['year']  = substr($value['create_at'], 0, 4);
			$value['month'] = substr($value['create_at'], 5, 2);
			$value['day']   = substr($value['create_at'], 8, 2);
		}

		$this->assign('title', "标签：{$newsTagInfo['name']} | ");
		$this->assign('news_mark_info', $newsTagInfo);
		$this->assign('news_list', $newsList);
		$this->assign('news_all_count', $newsAllCount);

		$this->fetch();
	}
}