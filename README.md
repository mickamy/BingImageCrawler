# BingImageCrawler

Bingの画像検索APIを叩いて結果の画像をローカルに保存するだけのやつ

## 準備

- [Microsoft Azure Marketplace](https://datamarket.azure.com/home?lc=1041)に登録
- [Bing Search API](https://datamarket.azure.com/dataset/bing/search)をサブスクリプト
- マイアカウントのプライマリアカウントキーを控えておく

## 使い方

- `git clone`
- `cd {project_dir}`
- `bundle install`
- 上で作成したアカウントキーを`config.yml`の`YOUR_API_KEY`のところに入力
- `ruby crawler.rb`
- 検索かけたいキーワードを入力
- output_{query_keyword}_{date}ディレクトリ配下に画像データが保存される

## Thanks to

[open-uri-redirections](https://github.com/open-uri-redirections/open_uri_redirections)

[searchbing](https://github.com/rcullito/searchbing)
