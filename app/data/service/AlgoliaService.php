<?php

namespace app\data\service;

use Algolia\AlgoliaSearch\Exceptions\MissingObjectId;
use Algolia\AlgoliaSearch\SearchClient;
use Algolia\AlgoliaSearch\SearchIndex;

class AlgoliaService
{
	const appId       = '91NJ1PWB1Z';
	const apiKey      = '1da8b2e5362a7a802ccfe06b8c60d812';
	const adminApiKey = '431660a58a99f1f9edfb2792f389753e';
	const usageKey    = '22ce65a031926c3d158d57ec6c0b1747';
	const indexName   = 'easyblog';

	public static function initIndex(): SearchIndex
	{
		$client = SearchClient::create(
			self::appId,
			self::adminApiKey
		);

		return $client->initIndex(self::indexName);
	}

	public static function uploadNews($objectId, $title, $path)
	{
		if (request()->header()['host'] === 'blog.an0nymou5.com') {
			$index = self::initIndex();

			try {
				$index->saveObjects(
					[
						[
							'objectID' => $objectId,
							'title'    => $title,
							'path'     => $path,
						],
					]
				);
			} catch (MissingObjectId $e) {
				dump($e->getMessage());
			}
		}
	}

	public static function deleteNews($objectId)
	{
		if (request()->header()['host'] === 'blog.an0nymou5.com') {
			$index = self::initIndex();

			$index->deleteObject($objectId);
		}
	}

}