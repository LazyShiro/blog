<?php

namespace app\index\controller;

use think\admin\Controller;

class Misc extends Controller
{
	/**
	 * JS资源整合
	 */
	public function js()
	{
		//js参数
		$condition = param('js');

		//根目录
		$root = $_SERVER['DOCUMENT_ROOT'];
		//js数组
		$jssArray = explode(",", $condition);

		//初始化js内容
		$content = "";
		foreach ($jssArray as $value) {
			//获取对应的js内容
			$_content = file_get_contents($root . $value);
			if (!empty($_content)) {
				$content .= $_content . "\n";
			}
		}

		header('Content-Type:application/javascript;Accept-Ranges:bytes');
		exit($content);
	}

	/**
	 * css资源整合
	 */
	public function css()
	{
		//css参数
		$condition = param('css');

		//根目录
		$root = $_SERVER['DOCUMENT_ROOT'];
		//css数组
		$cssArray = explode(",", $condition);

		//初始化css内容
		$content = "";
		foreach ($cssArray as $value) {
			//获取对应的js内容
			$_content = file_get_contents($root . $value);
			if (!empty($_content)) {
				$content .= $_content . "\n";
			}
		}

		header('Content-Type:text/css;Accept-Ranges:bytes');
		exit($content);
	}
}