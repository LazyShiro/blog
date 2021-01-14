<?php

/**
 * 数组根据键分组
 *
 * @param array $array
 * @param array $keyArray
 *
 * @return array
 */
function arrayGroupByKey(array $array, array $keyArray): array
{
	$newArray = [];
	foreach ($array as $value) {
		$key = '';
		if (count($keyArray) > 1) {
			foreach ($keyArray as $v) {
				$key .= $value[$v] . '-';
			}
			$key = rtrim($key, '-');
		} else {
			$key = $value[$keyArray[0]];
		}

		$newArray[$key][] = $value;
	}

	return $newArray;
}

/**
 *获取请求参数（json）
 *
 * @param string $field
 * @param string $default
 *
 * @return array|mixed|string
 */
function param(string $field = '', $default = '')
{
	$data  = '';
	$param = request()->param();

	if ($field === '') {
		return $param;
	}

	return $param[$field] ?? $default;
}

function data_to_xml($data, $item = 'item', $id = 'id'): string
{
	$xml = $attr = '';
	foreach ($data as $key => $val) {
		if (is_numeric($key)) {
			$id && $attr = " {$id}=\"{$key}\"";
			$key = $item;
		}
		$xml .= "<{$key}{$attr}>";
		$xml .= (is_array($val) || is_object($val)) ? data_to_xml($val, $item, $id) : $val;
		$xml .= "</{$key}>";
	}
	return $xml;
}

function xml_encode($data, $root = 'think', $item = 'item', $attr = '', $id = 'id', $encoding = 'utf-8'): string
{
	if (is_array($attr)) {
		$_attr = array();
		foreach ($attr as $key => $value) {
			$_attr [] = "{$key}=\"{$value}\"";
		}
		$attr = implode(' ', $_attr);
	}
	$attr = trim($attr);
	$attr = empty ($attr) ? '' : " {$attr}";
	$xml  = "<?xml version=\"1.0\" encoding=\"{$encoding}\"?>";
	$xml  .= "<{$root}{$attr}>";
	$xml  .= data_to_xml($data, $item, $id);
	$xml  .= "</{$root}>";
	return $xml;
}

function ajaxReturn($data, $type = 'JSON')
{
	if (empty ($type))
		$type = env('app.default_ajax_return');
	switch (strtoupper($type)) {
		case 'JSON' :
			// 返回JSON数据格式到客户端 包含状态信息
			header('Content-Type:application/json; charset=utf-8');
			exit (json_encode(unserialize(str_replace(['NAN;', 'INF;'], '0;', serialize($data)))));
		case 'XML' :
			// 返回xml格式数据
			header('Content-Type:text/xml; charset=utf-8');
			exit (xml_encode($data));
		case 'JSONP' :
			// 返回JSON数据格式到客户端 包含状态信息
			header('Content-Type:application/json; charset=utf-8');
			$handler = isset ($_GET [config('VAR_JSONP_HANDLER')]) ? $_GET [config('VAR_JSONP_HANDLER')] : config('DEFAULT_JSONP_HANDLER');
			exit ($handler . '(' . json_encode($data) . ');');
		case 'EVAL' :
			// 返回可执行的js脚本
			header('Content-Type:text/html; charset=utf-8');
			exit ($data);
		default :
			exit($data);
	}
}

function returnData($resource = [], $code = 10000)
{
	$errorCode = config('error_code');

	if (is_numeric($resource)) {
		$code       = $resource;
		$data       = [];
		$message    = $errorCode[$resource];
		$messageStr = !empty($message) ? $message : '错误码未找到，错误码为' . $resource;
	} else {
		$data       = !empty($resource) ? $resource : [];
		$message    = $errorCode[$code];
		$messageStr = !$message ? '错误码未找到，错误码为' . $code : $message;
	}

	if ($code == 10000) {
		$status = 1;
	} else {
		$status = 0;
	}

	$returnData['status']  = $status;
	$returnData['code']    = $code;
	$returnData['message'] = $messageStr;
	$returnData['data']    = $data;

	ajaxReturn($returnData);
}

function getOffset($page, $limit)
{
	return ($page - 1) * $limit;
}

function getPageList($page, $max): array
{
	if ($page <= 2) {//名列前茅
		$offset = 1;
	} elseif (($max - $page) > 1) {//正常
		$offset = $page - 2;
	} else {
		$offset = $page - (4 - ($max - $page));//倒数老末
	}

	if ($max >= 5) {
		$length = 5;
	} else {
		$length = $max;
	}

	$pageList = [];

	for ($i = 0; $i < $length; $i++) {
		$pageTem = $offset + $i;
		array_push($pageList, $pageTem);
	}

	return $pageList;
}

function deleteHtmlTags($tags, $string)
{
	$preg = [];
	foreach ($tags as $key => $value) {
		$preg[$key] = "/<(" . $value . ".*?)>(.*?)<(\/" . $value . ".*?)>/si";
	}
	return preg_replace($preg, "", $string);
}

/**
 * 获取标签列表
 *
 * @param $that
 * @param $table
 * @param $mark
 *
 * @return array
 */
function getMarkList($that, $table, $mark): array
{
	$mark = str2arr($mark);

	try {
		$markList = $that->app->db->name($table)->where([['status', '=', 1], ['deleted', '=', 0], ['id', 'in', $mark]])->column('id,name');
	} catch (Exception $exception) {
		$markList = [];
	}

	return $markList;
}

/**
 * 获取分类详情
 *
 * @param $that
 * @param $table
 * @param $category
 *
 * @return array
 */
function getCategoryInfo($that, $table, $category): array
{
	$categoryId = substr($category, 1, -1);
	try {
		$categoryInfo = $that->app->db->name($table)->where([['status', '=', 1], ['deleted', '=', 0], ['id', '=', $categoryId]])->field('id,name')->find();
	} catch (Exception $exception) {
		$categoryInfo['id']   = '';
		$categoryInfo['name'] = '';
	}

	return $categoryInfo;
}

function getYear($date)
{
	return substr($date, 0, 4);
}

function getMonth($date)
{
	return substr($date, 5, 2);
}

function getDay($date)
{
	return substr($date, 8, 2);
}

function getYearMonthDay($date)
{
	return substr($date, 0, 10);
}

/**
 * 获取真实文字字数
 *
 * @param $content
 *
 * @return int|string
 */
function getRealWordNumber($content)
{
	$wordNumber = mb_strlen(str_replace(array("\r\n", "\r", "\n"), '', strip_tags($content)));
	$wordNumber = $wordNumber > 1000 ? (round($wordNumber / 1000) . 'k') : $wordNumber;
	return $wordNumber;
}

/**
 * 获取阅读时间
 *
 * @param $wordNumber
 *
 * @return string
 */
function getReadTime($wordNumber): string
{
	if (strpos($wordNumber, 'k') !== false) {
		$wordNumber = substr($wordNumber, 0, -1) * 1000;
	}

	$readTime = $wordNumber / env('common.read_speed');
	$readTime = $readTime > 60 ? (ceil($readTime / 60) . '分钟') : (ceil($readTime) . '秒');

	return $readTime;
}