<?php

namespace app\data\service;

use think\admin\Service;

/**
 * 文章数据服务
 * Class NewsService
 *
 * @package app\data\service
 */
class NewsService extends Service
{
	private $newsMarkTable     = 'dataNewsMark';
	private $newsCategoryTable = 'dataNewsCategory';

	/**
	 * 同步文章数据统计
	 *
	 * @param string $code 文章编号
	 *
	 * @throws \think\db\exception\DbException
	 */
	public function syncNewsTotal(string $code): void
	{
		[$map, $total] = [['code' => $code], []];
		$query = $this->app->db->name('DataNewsXCollect')->field('count(1) count,type');
		$query->where($map)->group('type')->select()->map(function($item) use (&$total) {
			$total[$item['type']] = $item['count'];
		});
		$this->app->db->name('DataNewsItem')->where(['code' => $code])->update([
			'num_collect' => $total[2] ?? 0, 'num_like' => $total[1] ?? 0,
			'num_comment' => $this->app->db->name('DataNewsXComment')->where($map)->count(),
		]);
	}

	/**
	 * 根据code绑定列表数据
	 *
	 * @param array $list 数据列表
	 *
	 * @return array
	 */
	public function buildListByUidAndCode(array &$list = []): array
	{
		if (count($list) > 0) {
			/*! 绑定文章内容 */
			$codes = array_unique(array_column($list, 'code'));
			$colls = 'id,code,name,cover,mark,status,deleted,create_at,num_like,num_read,num_comment,num_collect';
			$items = $this->app->db->name('DataNewsItem')->whereIn('code', $codes)->column($colls, 'code');
			$marks = $this->app->db->name('DataNewsMark')->where(['status' => 1])->column('name');
			foreach ($items as &$vo) $vo['mark'] = str2arr($vo['mark'] ?: '', ',', $marks);
			foreach ($list as &$vo) $vo['record'] = $items[$vo['code']] ?? [];
			/*! 绑定用户数据 */
			$colls = 'id,phone,nickname,username,headimg,status';
			UserService::instance()->buildByUid($list, 'uid', 'member', $colls);
		}
		return $list;
	}

	/**
	 * 获取列表状态
	 *
	 * @param array   $list 数据列表
	 * @param integer $mid  用户UID
	 *
	 * @return array
	 */
	public function buildListState(array &$list, int $mid = 0): array
	{
		if (count($list) > 0) {
			foreach ($list as &$vo) {
				$mark     = str2arr($vo['mark']);
				$category = str2arr($vo['category']);

				$vo['mark']     = $this->app->db->name($this->newsMarkTable)->where([['status', '=', 1], ['deleted', '=', 0], ['id', 'in', $mark]])->column('name,remark');
				$vo['category'] = $this->app->db->name($this->newsCategoryTable)->where([['status', '=', 1], ['deleted', '=', 0], ['id', 'in', $category]])->column('name,remark');
			}
		}
		return $list;
	}

}