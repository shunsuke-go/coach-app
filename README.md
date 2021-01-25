※このREADMEは製作途中です
# [Coacher!](https://coacher-app.work)

# アプリ概要
スポーツを教わりたい人と教えたい人がマッチングできるWEBアプリケーションです。
教えたい人、教わりたい人をそれぞれ探し、コミュニケーションを取ることができます！  
[Coacher!](https://coacher-app.work)

# 使用技術
**◆フロントエンド**
* HTML/SCSS
* Javascript
* Materialize
**◆バックエンド**
* Ruby:2.6.6
* Rails:6.0.3
**◆インフラ・開発環境**
* AWS(VPC, Rout53, ALB, EC2, EDS, S3)
* CircleCI(CI/CD)
* Docker/docker-compose
* MySQL:8.0.2.2
* Nginx
* Puma
**◆テスト・静的コード解析**
* Rspec
* Rubocop

# インフラ構成図

# こだわった点
* **N+1問題の解決**  
当初、トップページの読み込み時間の長さに頭を抱えておりました。
どうしても解決したいと強く思いましたので、自分で調査しトライアンドエラーを何度も繰り返しました。
その結果、現在では1秒未満に抑えるこに成功しました。
具体的に行ったことはincludeメソッドや生のSQL文を記述することです。
特に、実務において使用しているSQLの技術が非常に役に立ちました。

* **Ajaxを素のJavascript(fetch API)のみで実現**  
将来的にはVue.jsやReactを習得する予定ですので、素のJavascriptの扱いに慣れる必要があると考えました。
そのために、練習も兼ねて素のJavascript(fetch API)のみでAjaxを実現させました。
その甲斐あって、RailsからフロントエンドにJSONを返すという基本的なフロントエンド、バックエンド分離の構造を学ぶ事ができました。

* **記事機能において外部APIを使用（GoogleMaps API, Geocoding API）**  
アプリの設計段階で、GoogleMapを表示することができると非常に使いやすいものになると判断いたしました。
私にとっては難易度が高いものでしたが、粘り強く取り組むことにより、想定通りの機能を実装することができました。
特に苦労した点は以下になります。
  * マップ上にマーカーを立てる方法２つを併存させたこと。
  マップをクリックすることと、位置を検索することでマップ上にマーカーを立てることができます。
  * 同時に2つのテーブルにレコードを挿入できるように設計したこと。
  記事の作成と同時に、別テーブルに位置情報のレコードを挿入することができます。また、この2つは紐付いています。
  * 「近所の募集を探す」機能を実装したこと。
  検索した位置から半径20km以内の、位置情報と紐付いている記事を探すことができます。

# 機能一覧
* ユーザーに関する機能
  * コーチ一覧機能
  * ユーザー一覧機能
* 管理者機能
* 記事に関する機能(GoogleMaps API, Geocoding API, Action text)
  * 記事ワード検索機能
  * 検索位置から近い募集記事検索機能
  * タグ管理機能
* フォロー機能
* いいね機能
  * いいねした記事一覧機能
* コメント機能
* ダイレクトメッセージ機能
* レビュー機能
  * レビューランキング機能
  * レビューランキング機能
* 通知機能

# 機能詳細
