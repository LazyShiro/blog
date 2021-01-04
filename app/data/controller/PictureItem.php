<?php

namespace app\data\controller;

use app\data\service\PictureService;
use Exception;
use think\admin\Controller;

/**
 * 图片管理
 * Class PictureItem
 *
 * @package app\data\controller
 */
class PictureItem extends Controller
{
	/**
	 * 绑定数据表
	 *
	 * @var string
	 */
	private $table                = 'DataPictureItem';
	private $pictureCategoryTable = 'dataPictureCategory';
	private $pictureRelationTable = 'dataPictureRelation';

	/**
	 * 图片管理
	 *
	 * @auth true
	 * @menu true
	 * @throws \think\db\exception\DataNotFoundException
	 * @throws \think\db\exception\DbException
	 * @throws \think\db\exception\ModelNotFoundException
	 */
	public function index()
	{
		$this->title = '图片管理';
		$query       = $this->_query($this->table);
		$query->like('name')->dateBetween('create_at');
		$query->where(['deleted' => 0])->order('sort desc,id desc')->page();
	}

	/**
	 * 图片选择器
	 *
	 * @login true
	 * @throws \think\db\exception\DataNotFoundException
	 * @throws \think\db\exception\DbException
	 * @throws \think\db\exception\ModelNotFoundException
	 */
	public function select()
	{
		$query = $this->_query($this->table);
		$query->equal('status')->like('name')->dateBetween('create_at');
		$query->where(['deleted' => 0])->order('sort desc,id desc')->page();
	}

	/**
	 * 列表数据处理
	 *
	 * @param array $data
	 */
	protected function _page_filter(array &$data)
	{
		PictureService::instance()->buildListState($data);
	}

	/**
	 * 添加图片
	 *
	 * @auth true
	 * @throws \think\db\exception\DataNotFoundException
	 * @throws \think\db\exception\DbException
	 * @throws \think\db\exception\ModelNotFoundException
	 */
	public function add()
	{
		$this->title = '添加图片';
		$this->_form($this->table, 'form');
	}

	/**
	 * 编辑图片
	 *
	 * @auth true
	 * @throws \think\db\exception\DataNotFoundException
	 * @throws \think\db\exception\DbException
	 * @throws \think\db\exception\ModelNotFoundException
	 */
	public function edit()
	{
		$this->title = '编辑图片';
		$this->_form($this->table, 'form');
	}

	/**
	 * 表单数据处理
	 *
	 * @param array $data
	 *
	 * @throws \think\db\exception\DataNotFoundException
	 * @throws \think\db\exception\DbException
	 * @throws \think\db\exception\ModelNotFoundException
	 */
	protected function _form_filter(array &$data)
	{
		if ($this->request->isGet()) {
			$query            = $this->app->db->name($this->pictureCategoryTable)->where(['deleted' => 0, 'status' => 1]);
			$this->category   = $query->order('sort desc,id desc')->select()->toArray();
			$data['category'] = str2arr($data['category'] ?? '');
		} else {
			if (key_exists('category', $data)) {
				$data['category'] = arr2str($data['category']);
			} else {
				$data['category'] = arr2str([]);
			}
			$data['update_at'] = date('Y-m-d H:i:s');
		}
	}

	/**
	 * 表单结果处理
	 *
	 * @param bool  $state
	 * @param array $data
	 */
	protected function _form_result(bool $state, array $data)
	{
		//获取新增文章id
		$pictureItemId = $data['id'] ?? $this->app->db->name($this->table)->getLastInsID();

		//关系表数据初始化
		$relationData = [];
		if (key_exists('category', $data)) {
			foreach (str2arr($data['category']) as $value) {
				array_push($relationData, ['picture_id' => $pictureItemId, 'category_id' => $value]);
			}
		}

		try {
			//删除此文章之前所有的关系
			$this->app->db->name($this->pictureRelationTable)->where(['picture_id' => $data['id']])->delete();
		} catch (Exception $e) {
		}

		//新增文章关系
		$this->app->db->name($this->pictureRelationTable)->insertAll($relationData);

		if ($state) {
			$this->success('图片保存成功！', 'javascript:history.back()');
		}
	}

	/**
	 * 修改图片状态
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
	 * 删除图片
	 *
	 * @auth true
	 * @throws \think\db\exception\DbException
	 */
	public function remove()
	{
		$this->_delete($this->table);
	}

}