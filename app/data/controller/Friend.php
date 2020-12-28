<?php

namespace app\data\controller;

use app\data\enum\NewsTagEnum;
use app\data\service\NewsService;
use Exception;
use think\admin\Controller;
use think\admin\extend\CodeExtend;

/**
 * 友情链接管理
 * Class Friend
 *
 * @package app\data\controller
 */
class Friend extends Controller
{
	/**
	 * 绑定数据表
	 *
	 * @var string
	 */
	private string $table = 'DataFriend';

	/**
	 * 友情链接管理
	 *
	 * @auth true
	 * @menu true
	 * @throws \think\db\exception\DataNotFoundException
	 * @throws \think\db\exception\DbException
	 * @throws \think\db\exception\ModelNotFoundException
	 */
	public function index()
	{
		$this->title = '友情链接管理';

		$where = param('status') === '' ? '1 = 1' : [['status', '=', param('status')]];
		$query = $this->_query($this->table);
		$query->where($where)->page();
	}

	/**
	 * 修改友链状态
	 *
	 * @auth true
	 * @throws \think\db\exception\DbException
	 */
	public function state()
	{
		$this->_save($this->table, $this->_vali([
			'status.in:0,1,2' => '状态值范围异常！',
			'status.require'  => '状态值不能为空！',
		]));
	}
}