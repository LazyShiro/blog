<?php

namespace app\index\controller;

use app\index\service\CommonService;
use Exception;
use think\admin\Controller;
use think\App;

class Article extends Controller
{
	protected string $newsItemTable     = 'DataNewsItem';
	protected string $newsMarkTable     = 'DataNewsMark';
	protected string $newsCategoryTable = 'DataNewsCategory';

	protected CommonService $commonService;

	public function __construct(App $app)
	{
		$this->commonService = new CommonService();
		parent::__construct($app);
	}

	public function index()
	{
		$id = param('id');

		if (empty($id) || (int) $id === 0) {
			exit('在维护，懒得写页面了2');
		}

		try {
			if (empty((request()->header('cache-control')))) {
				$this->app->db->name($this->newsItemTable)->where([['status', '=', 1], ['deleted', '=', 0], ['id', '=', $id]])->inc('num_read')->update();
			}

			$newsInfo = $this->app->db->name($this->newsItemTable)->where([['status', '=', 1], ['deleted', '=', 0], ['id', '=', $id]])->field('id,name,mark,category,cover,remark,content,num_like,num_read,num_collect,num_comment,praise,create_at,update_at')->find();

			$newsPrev = $this->app->db->name($this->newsItemTable)->where([['status', '=', 1], ['deleted', '=', 0], ['id', '<', $id]])->order(['id' => 'desc'])->field('id,name,category,cover')->find();
			$newsNext = $this->app->db->name($this->newsItemTable)->where([['status', '=', 1], ['deleted', '=', 0], ['id', '>', $id]])->order(['id' => 'asc'])->field('id,name,category,cover')->find();
		} catch (Exception $exception) {
			exit('在维护，懒得写页面了3');
		}

		$this->commonService->getBaseInfo($this);

		$newsInfo['mark']        = getMarkList($this, $this->newsMarkTable, $newsInfo['mark']);
		$newsInfo['category']    = getCategoryInfo($this, $this->newsCategoryTable, $newsInfo['category']);
		$newsInfo['create_date'] = getYearMonthDay($newsInfo['create_at']);
		$newsInfo['update_date'] = getYearMonthDay($newsInfo['update_at']);
		$newsInfo['word_number'] = getRealWordNumber($newsInfo['content']);
		$newsInfo['read_time']   = getReadTime($newsInfo['word_number']);
		$newsInfo['structure']   = $this->getArticleMenu($this->getStructure($newsInfo['content']));

		if (!empty($newsPrev)) {
			$categoryInfo = getCategoryInfo($this, $this->newsCategoryTable, $newsPrev['category']);

			$newsPrev['category_id']   = $categoryInfo['id'];
			$newsPrev['category_name'] = $categoryInfo['name'];
		}

		if (!empty($newsNext)) {
			$categoryInfo = getCategoryInfo($this, $this->newsCategoryTable, $newsNext['category']);

			$newsNext['category_id']   = $categoryInfo['id'];
			$newsNext['category_name'] = $categoryInfo['name'];
		}

		$this->assign('title', $newsInfo['name'] . ' | ');
		$this->assign('news_info', $newsInfo);
		$this->assign('news_prev', $newsPrev);
		$this->assign('news_next', $newsNext);

		$this->fetch();
	}

	public function list()
	{
		$page  = param('page');
		$limit = 10;

		try {
			$newsList = $this->app->db->name($this->newsItemTable)->where([['status', '=', 1], ['deleted', '=', 0]])->field('id,name,cover,content,create_at')->order(['sort' => 'desc', 'id' => 'desc'])->limit(getOffset($page, $limit), $limit)->select()->toArray();
			foreach ($newsList as &$value) {
				$value['year']        = getYear($value['create_at']);
				$value['month']       = getMonth($value['create_at']);
				$value['day']         = getDay($value['create_at']);
				$value['word_number'] = getRealWordNumber($value['content']);
				$value['read_time']   = getReadTime($value['word_number']);
			}
			returnData($newsList);
		} catch (Exception $exception) {
			returnData();
		}
	}

	/**
	 * 获取文章缩略结构
	 *
	 * @param $content
	 *
	 * @return array
	 */
	private function getStructure($content): array
	{
		$tags = getTagData($content, 'h', 'id');

		$tagList = [];

		foreach ($tags[count($tags) - 1] as $key => $value) {
			$tagListTem = [
				'id'    => $key + 1,
				'name'  => $tags[count($tags) - 2][$key],
				'index' => (int) $value,
				'pid'   => (((int) $value) === 1) ? 0 : false,
			];
			array_push($tagList, $tagListTem);
		}

		foreach ($tagList as $key => &$value) {
			if ($value['pid'] === false) {
				$value['pid'] = getPid($tagList, $key, $value['index']);
			}
		}

		return listToTree($tagList);
	}

	/**
	 * 获取
	 *
	 * @param     $tree
	 * @param int $level
	 *
	 * @return string
	 */
	private function getArticleMenu($tree, $level = 1): string
	{
		if (!empty($tree) && is_array($tree)) {

			$htmlBegin = $level === 1 ? '<ol class="toc">' : '<ol class="toc-child">';
			$html      = '';
			$htmlEnd   = '</ol>';

			foreach ($tree as $key => $value) {
				$toc_number = $key + 1;
				$htmlChild  = isset($value['_child']) ? $this->getArticleMenu($value['_child'], $level + 1) : '';

				$html .= "
					<li class='toc-item toc-level-{$level}'>
						<a class='toc-link' href='#{$value['name']}'>
							<span class='toc-number'>{$toc_number}.</span>
							<span class='toc-text'>{$value['name']}</span>
						</a>
						{$htmlChild}
					</li>
				";
			}

			return $htmlBegin . $html . $htmlEnd;
		}
		return '';
	}
}