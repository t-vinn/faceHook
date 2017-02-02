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
|12|ユーザ|	ユーザの影響力を集計。投稿にいいねされると1点、投稿をすると1点、コメントにいいねがつくと1点、プロフィールが閲覧されると1点|
|13|ユーザ	|おすすめユーザ機能。影響力の高い順に並んだランキングを作成しフォローをおすすめする。|
|14|ユーザ	|ユーザはメールの通知を受け取るか受け取らないかを設定可能|
|15|ユーザ|	プロフィールページを作成|
|16|グループ|グループ内への投稿が可能|
|17|グループ|グループは招待制、グループメンバーのみが他の人を招待可能|
|18|グループ|	グループ内の投稿はグループメンバーのみ閲覧可能|
|19|グループ|グループへの投稿内容はコメントと写真|
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
##UI設計
##テーブル設計
###users


|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|email|メアド| string |  | false | |
|name|ユーザーネーム | string | | false | |
|password|パスワード | string | | false | |
|age|年齢|integer||true|プロフィール画面で後から設定可能|
|birth|生年月日|||true|同上|
|hobby|趣味|string||true|同上|

###follow_relationships

|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|follower_id||integer||false||
|followed_id||integer||false||


###user_influence


|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|user_id||integer||false||
|influence|影響力|integer|0|false||

###groups

|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|name|グループ名|string||false||

###groups_users

|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|group_id||integer||false||
|user_id||integer||false||


###feeds
個人の投稿

|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|user_id||integer||false||
|content|メッセージ内容|stringか写真||false||
|privacy|公開度|enum|public|false|public, follower, privateの3つ|

###group_posts

|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|user_id||integer||false||
|group_id||integer||false||
|content|メッセージ内容|stringか写真？||false||


###group_posts_favorites

|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|group_post_id||integer||false||
|user_id||integer||false||

###replies
個人の投稿に対する返信

|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|post_id||integer||false||
|user_id||integer||false||
|content|返信内容|stringか写真||false||

###feeds_favorites

|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|post_id||integer||false||
|user_id||integer||false||

###replies_favorites
個人投稿への返信へのファボ

|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|reply_id||integer||false||
|user_id||integer||false||

###admin

|column|説明|type|default|null|備考|
|---|---|---|---|---|---|
|email|メアド| string |  | false | |
|name|ユーザーネーム | string | | false | |
|password|パスワード | string | | false | |


