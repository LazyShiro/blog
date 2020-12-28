<?php

namespace app\index\controller;

use app\index\service\CommonService;
use Exception;
use think\admin\Controller;
use think\App;

class Friend extends Controller
{
	protected $friendTable = 'DataFriend';

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
			$friendList = $this->app->db->name($this->friendTable)->where([['status', '=', 1]])->orderRand()->select()->toArray();
		} catch (Exception $exception) {
			exit('在维护');
		}

		$this->assign('title', '友情链接 | ');
		$this->assign('friend_list', $friendList);

		$this->fetch();
	}

	public function apply()
	{
		$site  = param('site');
		$owner = param('owner');
		$url   = param('url');
		$desc  = param('desc');
		$image = param('image');
		$color = param('color');

		if (empty($site) || empty($owner) || empty($url) || empty($desc) || empty($image) || empty($color)) {
			returnData(10001);
		}

		$data = [
			'site'       => $site,
			'owner'      => $owner,
			'url'        => $url,
			'desc'       => $desc,
			'image'      => $image,
			'color'      => $color,
			'createtime' => time(),
		];

		$insertId = $this->app->db->name($this->friendTable)->insertGetId($data);
		if ($insertId > 0) {
			returnData();
		}
	}

}