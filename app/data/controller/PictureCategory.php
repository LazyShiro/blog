<?php

namespace app\data\controller;

use think\admin\Controller;

/**
 * 图片分类管理
 * Class PictureCategory
 *
 * @package app\data\controller
 */
class PictureCategory extends Controller
{
	/**
	 * 绑定数据表
	 *
	 * @var string
	 */
	private $table = 'DataPictureCategory';

	/**
	 * 图片分类管理
	 *
	 * @auth true
	 * @menu true
	 * @throws \think\db\exception\DataNotFoundException
	 * @throws \think\db\exception\DbException
	 * @throws \think\db\exception\ModelNotFoundException
	 */
	public function index()
	{
		$this->title = '图片分类管理';
		$query       = $this->_query($this->table);
		$query->like('name')->equal('status')->where(['deleted' => 0])->order('sort desc,id desc')->page();
	}

	/**
	 * 添加图片分类
	 *
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
	 * 编辑图片分类
	 *
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
	 * 修改图片分类状态
	 *
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
	 * 删除图片分类
	 *
	 * @auth true
	 * @throws \think\db\exception\DbException
	 */
	public function remove()
	{
		$this->_delete($this->table);
	}

}