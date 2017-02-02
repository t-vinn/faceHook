#facebookもどき　仕様書
##目次
- サービス名、コンセプト、機能要件、未確定要件
- 見積もり
- UI設計
- テーブル設計

##サービス名、コンセプト、機能要件、未確定要件
###サービス名
###コンセプト
###機能要件

|通し番号|担当|要件|
|---|---|---|
|1|ユーザ|	ユーザはemail, password, 氏名で新規登録できる|
|2|ユーザ|	ログイン前のユーザはタイムラインの閲覧のみ可能|
|3|ユーザ|	登録 or ログイン後のユーザは投稿が可能|
|4|ユーザ|	投稿できる内容はコメントと写真。写真は最大3枚まで。|
|5|ユーザ|	投稿されたものに返信ができる|
|6|ユーザ|	投稿されたものと返信にはいいねができる|
|7|ユーザ|	他の人をフォローすることができる|
|8|ユーザ	|投稿は公開レベルを設定できる。全体公開、フォロワーのみに公開、自分のみに公開|
|9|ユーザ	|ユーザはグループを作成可能、facebookのグループのようなもの|
|10|ユーザ|	フォローしているユーザの投稿から構成されるタイムラインが作成可能|
|11|ユーザ|	いいね、コメントをするとその投稿をした本人と他にコメントをした人に通知が飛ぶ|
|12|ユーザ|	ユーザの影響力を集計。投稿にいいねされると1点、投稿をすると1点、コメントにいいねがつくと1点、プロフィールが閲覧されると1点。影響力は一部カスタマイズする|
|13|ユーザ	|おすすめユーザ機能。影響力の高い順に並んだランキングを作成しフォローをおすすめする。|
|14|ユーザ	|ユーザはメールの通知を受け取るか受け取らないかを設定可能|
|15|ユーザ|	プロフィールページを作成|
|16|グループ|グループ内への投稿が可能|
|17|グループ|グループは招待制、グループメンバーのみが他の人を招待可能|
|18|グループ|	グループ内の投稿はグループメンバーのみ閲覧可能|
|19|グループ|グループへの投稿内容はコメントと写真、返信はなし、いいねあり|
|20|管理画面|ユーザが一覧できる|
|21|管理画面|ユーザ情報の詳細が見られる|

###機能要件の未確定部分
テーブル設計にも関連

- adminとuserを分離するか yes
	- userでないadminが存在するか yes
- adminは複数人登録可能か yes
- 投稿は編集・削除可能か
	- reply含めた流れが消えるのでできれば不可としたい can edit, but can't delete
	- 編集可能でないとしても、公開度だけは編集可能か yes
- ログイン後すぐの画面(first view)において表示する投稿は公開投稿&フォローユーザー投稿&グループ投稿で良いか yes
- グループに友人以外のuserを招待可能か no
	- 不可として、相互フォローのみ招待可能とするか、片側フォローでも可とするか only follow_followed relationship
- フォローユーザー投稿への切り替えはページ遷移とするか、first viewと同じ画面で切り替える same page

##見積もり
まずは基本機能から

1. ユーザーモデル関連(devise)
	1. 新規ユーザー作成
	1. ユーザーのログイン
	1. ユーザーのログアウト
	1. ユーザーのプロフィール変更（hobbyはinfluenceまで後回し）
1. フォロー機能（influenceは後回し、とりあえずユーザーを列挙してフォローできるように、フォローは拒否できない、解除は可能）
1. 個人投稿(feeds)作成（写真は後回し、とりあえず文字だけ）
1. ファーストビューとっかかり
	1. ファーストビュー１（ログイン前）
	1. ファーストビュー２（ログイン後1)
	1. ファーストビュー３（ログイン後2、フォロワーの投稿に限定）
1. 個人投稿続き
	1. 返信機能
	1. いいね機能
	1. 編集機能（公開度のみ）
1. グループ
	1. グループ作成
	1. 招待
	1. グループ内投稿作成
	1. グループ内投稿閲覧
	1. 投稿へのいいね
1. ファーストビューの改良
	1. feedsだけでなくグループ投稿も表示できるようにする
	1. 
1. 写真の投稿機能
	1. 個人のfeedで
	1. グループ内で
	1. feedへのコメントで
1. 通知機能（mailer）
	1. いいねした時の通知
	1. コメントした時の通知
1. 管理者権限
	1. namespace使ってまず機能（profileの生年月日見れる）を
	1. ログイン関連
		1. 新規登録
		1. ログイン
		1. ログアウト
1. UI
	1. あまりこだわりはない
	1. そこそこ見やすい程度（僕個人では限界ありそう）
1. influence
	1. 全員共通の影響力(投稿やいいね数）
	1. ユーザーのhobbyテーブルの作成
	1. 影響力のカスタマイズ化のアルゴリズム決定
	1. アルゴリズム実装（投稿数、いいね数、etc..)

##UI設計
##テーブル設計
###1. users

|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|email|メアド| string |  | false | |
|name|ユーザーネーム | string | | false | |
|password|パスワード | string | | false | |
|birth_dates||date||true|同上|

誕生日は登録自由、公開only。

ageはbirth_datesに合体

###2. hobbies
|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|hobby|趣味|string||false|同上|

これはオススメに使いたいので公開only。

###3. users_hobbies
|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|user_id||integer||false||
|hobby_id||integer||false||

###4. follow_relationships

|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|follower_user_id||integer||false||
|followee_user_id||integer||false||


###5. user_influence

|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|influencer_user_id||integer||false||
|influenced_user_id|影響される側|integer||false||
|influence|影響力|integer|0|false||

influenceをどうやって定義するか
①自分のフォローしてるユーザーにいいねされまくってるユーザー、趣味共通のユーザー、をオススメしたい（年齢や誕生日はプライバシー感があるのでオススメには使わず）
②始めたばっかで友達少ないユーザーにはフォロワーめっちゃ多い人もオススメ

つまり、完全カスタマイズではなく、多少は共通部分もあるようにする。そうすればユーザーからすると、使い始めもサポートしてくれる一方で友達増やしたりサービス使えば使うほどオススメの精度が上がったように感じられるはず？

###6. groups

|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|name|グループ名|string||false||

###7. groups_users

|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|group_id||integer||false||
|user_id||integer||false||


###8. feeds
個人の投稿

|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|user_id||integer||false||
|content|メッセージ内容|stringか写真||false||
|privacy|公開度|enum|public|false|public, follower, privateの3つ|

###9. group_posts

|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|user_id||integer||false||
|group_id||integer||false||
|content|メッセージ内容|stringか写真？||false||


###10. group_posts_favorites

|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|group_post_id||integer||false||
|user_id||integer||false||

###11. replies
個人の投稿に対する返信

|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|post_id||integer||false||
|user_id||integer||false||
|content|返信内容|stringか写真||false||

###12. feeds_favorites

|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|post_id||integer||false||
|user_id||integer||false||

###13. replies_favorites
個人投稿への返信へのファボ

|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|reply_id||integer||false||
|user_id||integer||false||

###14. admin

|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|email|メアド| string |  | false | |
|name|ユーザーネーム | string | | false | |
|password|パスワード | string | | false | |





