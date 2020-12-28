<?php

namespace app\data\controller;

use app\data\enum\NewsTagEnum;
use app\data\service\NewsService;
use Exception;
use think\admin\Controller;
use think\admin\extend\CodeExtend;
use think\db\exception\DbException;

/**
 * 文章内容管理
 * Class NewsItem
 *
 * @package app\data\controller
 */
class NewsItem extends Controller
{
	/**
	 * 绑定数据表
	 *
	 * @var string
	 */
	private string $table             = 'DataNewsItem';
	private string $newsRelationTable = 'dataNewsRelation';
	private string $newsItemTable     = 'dataNewsItem';

	/**
	 * 文章内容管理
	 *
	 * @auth true
	 * @menu true
	 * @throws \think\db\exception\DataNotFoundException
	 * @throws \think\db\exception\DbException
	 * @throws \think\db\exception\ModelNotFoundException
	 */
	public function index()
	{
		$this->title = '文章内容管理';
		$query       = $this->_query($this->table);
		$query->like('mark,name')->dateBetween('create_at');
		$query->where(['deleted' => 0])->order('sort desc,id desc')->page();
	}

	/**
	 * 文章内容选择器
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
		NewsService::instance()->buildListState($data);
	}

	/**
	 * 添加文章内容
	 *
	 * @auth true
	 * @throws \think\db\exception\DataNotFoundException
	 * @throws \think\db\exception\DbException
	 * @throws \think\db\exception\ModelNotFoundException
	 */
	public function add()
	{
		$this->title = '添加文章内容';
		$this->_form($this->table, 'form');
	}

	/**
	 * 编辑文章内容
	 *
	 * @auth true
	 * @throws \think\db\exception\DataNotFoundException
	 * @throws \think\db\exception\DbException
	 * @throws \think\db\exception\ModelNotFoundException
	 */
	public function edit()
	{
		$this->title = '编辑文章内容';
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
		if (empty($data['code'])) {
			$data['code'] = CodeExtend::uniqidNumber(14, 'A');
		}
		if ($this->request->isGet()) {
			$query        = $this->app->db->name('DataNewsMark')->where(['deleted' => 0, 'status' => 1]);
			$this->mark   = $query->order('sort desc,id desc')->select()->toArray();
			$data['mark'] = str2arr($data['mark'] ?? '');

			$query            = $this->app->db->name('DataNewsCategory')->where(['deleted' => 0, 'status' => 1]);
			$this->category   = $query->order('sort desc,id desc')->select()->toArray();
			$data['category'] = str2arr($data['category'] ?? '');
		} else {
			if (key_exists('mark', $data)) {
				$data['mark'] = arr2str($data['mark']);
			} else {
				$data['mark'] = arr2str([]);
			}
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
		$newsItemId = $data['id'] ?? $this->app->db->name($this->table)->getLastInsID();

		//关系表数据初始化
		$relationData = [];
		if (key_exists('mark', $data)) {
			foreach (str2arr($data['mark']) as $value) {
				array_push($relationData, ['news_id' => $newsItemId, 'type' => NewsTagEnum::MARK, 'object_id' => $value]);
			}
		}

		if (key_exists('category', $data)) {
			foreach (str2arr($data['category']) as $value) {
				array_push($relationData, ['news_id' => $newsItemId, 'type' => NewsTagEnum::CATEGORY, 'object_id' => $value]);
			}
		}

		try {
			//删除此文章之前所有的关系
			$this->app->db->name($this->newsRelationTable)->where(['news_id' => $data['id']])->delete();
		} catch (Exception $e) {
		}

		//新增文章关系
		$this->app->db->name($this->newsRelationTable)->insertAll($relationData);

		if ($state) {
			$this->success('文章内容保存成功！', 'javascript:history.back()');
		}
	}

	/**
	 * 修改文章状态
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
	 * 删除文章内容
	 *
	 * @auth true
	 * @throws \think\db\exception\DbException
	 */
	public function remove()
	{
		$this->_delete($this->table);
	}

}