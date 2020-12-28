<?php

namespace app\index\controller;

use app\index\service\CommonService;
use Exception;
use think\admin\Controller;
use think\App;

class Archives extends Controller
{
	protected string $newsTable = 'DataNewsItem';

	protected CommonService $commonService;

	public function __construct(App $app)
	{
		$this->commonService = new CommonService();
		parent::__construct($app);
	}

	public function index()
	{
		try {
			$newsList = $this->app->db->name($this->newsTable)->where([['status', '=', 1], ['deleted', '=', 0]])->field('create_at')->order(['id' => 'desc'])->select()->toArray();
		} catch (Exception $exception) {
			exit('在维护');
		}

		foreach ($newsList as $key => &$value) {
			$value['year']  = substr($value['create_at'], 0, 4);
			$value['month'] = substr($value['create_at'], 5, 2);
		}
		unset($value);

		$newsGroupList = arrayGroupByKey($newsList, ['year', 'month']);

		$archivesList = [];
		$index        = 0;
		foreach ($newsGroupList as $key => $value) {
			$archivesList[$index]['year']  = substr($key, 0, 4);
			$archivesList[$index]['month'] = substr($key, 5, 2);
			$archivesList[$index]['count'] = count($value);
			$index++;
		}

		$this->commonService->getBaseInfo($this);

		$this->assign('title', "归档 | ");
		$this->assign('news_count', count($newsList));
		$this->assign('archives_list', $archivesList);

		$this->fetch();
	}

	public function search()
	{
		$year  = param('year');
		$month = param('month');

		if (empty($year) || (int) $year === 0) {
			exit('在维护');
		}

		$condition = $year . ($month ? '-' . $month : '');
		try {
			$newsList = $this->app->db->name($this->newsTable)->where([['status', '=', 1], ['deleted', '=', 0], ['create_at', 'like', "{$condition}%"]])->field('id,name,create_at')->order(['id' => 'desc'])->limit(10)->select()->toArray();
		} catch (Exception $exception) {
			exit('在维护');
		}

		$this->commonService->getBaseInfo($this);

		foreach ($newsList as &$value) {
			$value['year']  = substr($value['create_at'], 0, 4);
			$value['month'] = substr($value['create_at'], 5, 2);
			$value['day']   = substr($value['create_at'], 8, 2);
		}

		$this->assign('title', $year . " 年" . (!empty($month) ? " / {$month} 月" : '') . " - 归档 | ");
		$this->assign('year', $year);
		$this->assign('month', $month);
		$this->assign('news_list', $newsList);

		$this->fetch();
	}
}