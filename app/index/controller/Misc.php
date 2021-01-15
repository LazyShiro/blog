<?php

namespace app\index\controller;

use GuzzleHttp\Client;
use GuzzleHttp\Exception\GuzzleException;
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

		//js数组
		$jssArray = explode(",", $condition);

		$client = new Client();

		//初始化js内容
		$content = "";
		foreach ($jssArray as $value) {
			//获取对应的js内容
			try {
				$response = $client->request('GET', $value, [
					'headers' => [
						'Referer' => $_SERVER['REQUEST_SCHEME'] . "://" . $_SERVER['SERVER_NAME'] . "/",
					],
				]);
			} catch (GuzzleException $e) {
				exit('请求错误');
			}
			$_content = $response->getBody()->getContents();
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

		$client = new Client();

		//css数组
		$cssArray = explode(",", $condition);

		//初始化css内容
		$content = "";
		foreach ($cssArray as $value) {
			//获取对应的js内容
			try {
				$response = $client->request('GET', $value, [
					'headers' => [
						'Referer' => $_SERVER['REQUEST_SCHEME'] . "://" . $_SERVER['SERVER_NAME'] . "/",
					],
				]);
			} catch (GuzzleException $e) {
				exit('请求错误');
			}
			$_content = $response->getBody()->getContents();
			if (!empty($_content)) {
				$content .= $_content . "\n";
			}
		}

		header('Content-Type:text/css;Accept-Ranges:bytes');
		exit($content);
	}
}