<?php

namespace app\data\controller;

use think\admin\Controller;

/**
 * 文章分类管理
 * Class NewsCategory
 * @package app\data\controller
 */
class NewsCategory extends Controller
{
	/**
	 * 绑定数据表
	 * @var string
	 */
	private $table = 'DataNewsCategory';

	/**
	 * 文章分类管理
	 * @auth true
	 * @menu true
	 * @throws \think\db\exception\DataNotFoundException
	 * @throws \think\db\exception\DbException
	 * @throws \think\db\exception\ModelNotFoundException
	 */
	public function index()
	{
		$this->title = '文章分类管理';
		$query = $this->_query($this->table);
		$query->like('name')->equal('status')->dateBetween('create_at');
		$query->where(['deleted' => 0])->order('sort desc,id desc')->page();
	}

	/**
	 * 添加文章分类
	 * @auth true
	 * @throws \think\db\exception\DataNotFoundException
	 * @throws \think\db\exception\DbException
	 * @throws \think\db\exception\ModelNotFoundException
	 */
	public function add()
	{
		$this->_form($this->table, 'form');
	}

	/**
	 * 编辑文章分类
	 * @auth true
	 * @throws \think\db\exception\DataNotFoundException
	 * @throws \think\db\exception\DbException
	 * @throws \think\db\exception\ModelNotFoundException
	 */
	public function edit()
	{
		$this->_form($this->table, 'form');
	}

	/**
	 * 修改文章分类状态
	 * @auth true
	 * @throws \think\db\exception\DbException
	 */
	public function state()
	{
		$this->_save($this->table, $this->_vali([
			'status.in:0,1'  => '状态值范围异常！',
			'status.require' => '状态值不能为空！',
		]));
	}

	/**
	 * 删除文章分类
	 * @auth true
	 * @throws \think\db\exception\DbException
	 */
	public function remove()
	{
		$this->_delete($this->table);
	}

}