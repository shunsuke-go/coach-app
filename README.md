※このREADMEは製作途中です  
# [Coacher!](https://coacher-app.work)

# アプリ概要
スポーツを教えたい人と教わりたい人のマッチングができるWebアプリケーションです。  
教えたい人、教わりたい人をそれぞれ探し、コミュニケーションを取ることができます！  
全て独学で開発いたしました。  
[Coacher!](https://coacher-app.work)  

# 使用技術
* フロントエンド
  * HTML/SCSS
  * Javascript
  * Materialize  
* バックエンド
  * Ruby:2.6.6
  * Rails:6.0.3
* インフラ・開発環境  
  * AWS(VPC, Rout53, ALB, EC2, RDS, S3)
  * CircleCI(CI/CD)
  * Docker/docker-compose
  * MySQL:8.0.2.2
  * Nginx
  * Puma
* テスト・静的コード解析
  * Rspec
  * Rubocop

# インフラ構成図

# こだわった点
* **N+1問題の解決**  
当初、トップページの読み込み時間の長さに頭を抱えておりました。  
<<<<<<< HEAD
読み込み時間の削減はWEBアプリケーションにおいて重要な要素であると認識しております。  
絶対に解決すべく、自分で調査しトライアンドエラーを何度も繰り返しました。  
その結果、現在では1秒未満に抑えることに成功いたしました。  

* **ActiveRecodeのメソッドでは実現が難しい機能については生のSQL文を用いて実装**  
メッセージボックス機能を実装するにあたって、最初はActive Recodeのメソッドを使用して作成いたしました。  
しかし、機能の細かい点にこだわると、Active Recodeのメソッドだけでは完璧なものが作れないことが判明いたしました。  
そこで、より良いものを作るべく、生のSQL文を用いて実装することといたしました。  
SQLは実務で頻繁に使用しますので、その経験が非常に役に立ちました。  
https://github.com/shunsuke-go/coach-app/blob/main/app/controllers/messages_controller.rb

* **Ajaxを素のJavascript(fetch API)のみで実現**  
将来的にはVue.jsやReactを習得する予定ですので、素のJavascriptの扱いに慣れる必要があると考えました。  
そのために、練習も兼ねて素のJavascript(fetch API)のみでAjaxを実現させました。  
その甲斐あって、RailsからフロントエンドにJSONを返すという基本的なフロントエンド、バックエンド分離の構造を学ぶ事ができました。  

* **記事機能において外部APIを使用（Google Maps API, Geocoding API）**  
アプリの設計段階で、GoogleMapを表示することができると非常に使いやすいものになると判断いたしました。  
私にとっては難易度が高いものでしたが、粘り強く取り組むことにより、想定通りの機能を実装することができました。  
特に苦労した点は以下になります。
  * マップ上にマーカーを立てる方法２つを併存させたこと。  
  マップをクリックすることと、位置を検索することでマップ上にマーカーを立てることができます。
  * 同時に2つのテーブルにレコードを挿入できるように設計したこと。  
  記事の作成と同時に、別テーブルに位置情報のレコードを挿入することができます。また、この2つは紐付いています。
  * 「近所の募集を探す」機能を実装したこと。  
  検索した位置から半径20km以内の位置情報と紐付いている記事を探すことができます。

# Coacher!を開発した背景
私は、社会人になってから現在に至るまで、フットサルというスポーツに本気で取り組んできました。  
スポーツに取り組んでいると、誰もが必ず伸び悩む時期が来ます。どれだけ練習をしても、試行錯誤をしても全く上達する気がしない。  
私も、そのように非常に苦しい時期を過ごしました。  
私の場合、その悩みが解決に至った経緯としては、本当に些細な出来事がきっかけでした。  
それは、「自分より上手な人に教えてもらったこと」です。  
そのおかげで私のプレイはすこぶる上達し、自信をつけることができました。  
教えてくれる人は、必ずしもプロ選手や有名選手である必要はありません。  
自分が感じている課題をすでに解決済みのプレイヤーからであれば、十分に有益な情報を得ることができます。  
そういった経験から、  
「スポーツをカジュアルに教えたい人と教わりたい人を繋げるサービスには価値があるのではないか」  
と思い、作成に至りました。

# 機能一覧
* ユーザーに関する機能
  * コーチ一覧表示機能
  * ユーザー一覧表示機能
* 管理者機能
* 記事に関する機能(GoogleMaps API, Geocoding API, Action text)
  * 記事ワード検索機能
  * 「近所の募集を探す」機能
  * タグ管理機能
* フォロー機能
* いいね機能
  * いいねした記事一覧表示機能
* コメント機能
* ダイレクトメッセージ機能
* レビュー機能
  * レビューランキング機能
  * レビューランキング機能
* 通知機能
* メッセージボックス機能

# 機能詳細
## ユーザーに関する機能
___
* ユーザー登録、ログイン、ログアウト、ユーザー情報編集
* ゲストログイン機能
* コーチ登録機能
* 管理者用機能（不適切な記事、コメント、レビュー、ユーザーを削除する事が可能）
* ユーザーの一覧表示（ユーザーとコーチに分かれる）
* プロフィール作成、編集、詳細表示機能

## 記事に関する機能
___
* 記事一覧表示、記事詳細表示、記事投稿、記事編集、記事削除機能
  * 記事投稿、編集機能については、Action text gemを使用し、UXの向上を図った
* タグに関する機能
  * acts_as_taggable gemを使用
  * タグを付けて登録することができる
  * タグをクリックすると同じタグが付けられた記事一覧を表示することができる
* 記事に対する位置情報保存、位置情報取得機能
  * Google Maps APIとGeocoding APIを使用
  * 記事に位置情報を紐付けて保存することが可能
  * 記事詳細画面にて、記事の位置情報をGoogle Mapで確認可能
* 「近所の募集を探す」機能
  * 検索した位置から半径20km以内の位置情報と紐付いている記事を探すことが可能
* 記事検索機能

## フォロー機能
___
* フォロー、フォロー解除機能
  * フォローしたユーザーのフォロワー数が変化する機能についてはJavascriptのfetch APIを用いて実装
* フォロー、フォロワー一覧表示機能
* フォローしたユーザーの投稿一覧機能

## いいね機能（Ajax）
___
* 記事にいいねを押す機能
  * いいねを押した記事のいいね数が変化する機能についてはJavascriptのfetch APIを用いて実装
* 自分がいいねを押した記事一覧表示機能


## コメント機能（Ajax）
___
* 記事毎にコメント投稿、削除、表示機能
  * Javascriptのfetch APIを用いて実装

## ダイレクトメッセージ機能(Ajax)
___
* 1:1のチャットルームを作成
* メッセージ送信、削除機能

## メッセージボックス機能
