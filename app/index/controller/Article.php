<?php

namespace app\index\controller;

use app\index\service\CommonService;
use Exception;
use think\admin\Controller;
use think\App;

class Article extends Controller
{
	protected $newsItemTable = 'DataNewsItem';

	protected $commonService;

	public function __construct(App $app)
	{
		$this->commonService = new CommonService();
		parent::__construct($app);
	}

	public function index()
	{
		$id = param('id');

		if (empty($id) || (int) $id === 0) {
			exit('在维护');
		}

		try {
			if (empty((request()->header('cache-control')))) {
				$this->app->db->name($this->newsItemTable)->where([['status', '=', 1], ['deleted', '=', 0], ['id', '=', $id]])->inc('num_read')->update();
			}

			$newsInfo = $this->app->db->name($this->newsItemTable)->where([['status', '=', 1], ['deleted', '=', 0], ['id', '=', $id]])->field('id,name,cover,content,num_like,num_read,num_collect,num_comment,create_at,update_at')->find();

			$newsPrev = $this->app->db->name($this->newsItemTable)->where([['status', '=', 1], ['deleted', '=', 0], ['id', '<', $id - 1]])->order(['id' => 'desc'])->field('id,name,cover,remark')->find();
			$newsNext = $this->app->db->name($this->newsItemTable)->where([['status', '=', 1], ['deleted', '=', 0], ['id', '>', $id + 1]])->order(['id' => 'asc'])->field('id,name,cover,remark')->find();
		} catch (Exception $exception) {
			exit('在维护');
		}

		$this->commonService->getBaseInfo($this);

		$newsInfo['create_date'] = substr($newsInfo['create_at'], 0, 10);
		$newsInfo['update_date'] = substr($newsInfo['update_at'], 0, 10);
		$newsInfo['word_number'] = mb_strlen(str_replace(array("\r\n", "\r", "\n"), '', strip_tags($newsInfo['content'])));

		$readTime = $newsInfo['word_number'] * 1.4362842397776895593489479952362;
		$readTime = $readTime > 60 ? (ceil($readTime / 60) . '分钟') : (ceil($readTime) . '秒');

		$newsInfo['read_time'] = $readTime;

		$this->assign('title', $newsInfo['name'] . ' | ');
		$this->assign('news_info', $newsInfo);
		$this->assign('news_prev', $newsPrev);
		$this->assign('news_next', $newsNext);

		$this->fetch();
	}

}