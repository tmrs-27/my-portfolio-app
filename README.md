# My Rails Portfolio

Rails 8 + Tailwind CSS で作成した、シンプルなブログ型ポートフォリオアプリです。  
投稿の作成・編集・削除、カテゴリ管理、キーワード検索、カテゴリ絞り込みに対応しています。

## URL

- 本番環境: `https://my-rails-portfolio.onrender.com/`
- GitHub: `https://github.com/tmrs-27/my-portfolio-app`

## このアプリでできること

- 投稿の CRUD（作成 / 一覧 / 詳細 / 編集 / 削除）
- カテゴリの CRUD
- 投稿とカテゴリの多対多紐付け
- カテゴリ別フィルタ
- キーワード検索（タイトル / 本文）
- ダークモード切り替え

## 技術スタック

- Backend: `Ruby 3.3`, `Rails 8.1`
- Frontend: `ERB`, `Tailwind CSS v4`, `Importmap`, `Turbo`, `Stimulus`
- DB:
  - 開発/テスト: `SQLite3`
  - 本番(Render): `PostgreSQL`
- インフラ/デプロイ: `Docker`, `Render`

## 画面イメージ

- Home: 最近の投稿一覧
- Posts: 投稿一覧 / 詳細 / 作成 / 編集
- Categories: カテゴリ管理画面

※ スクリーンショットは `docs/images/` などに追加すると、より伝わりやすくなります。

## ローカルでの起動方法

### 1. 依存関係をインストール

```bash
bundle install
```

### 2. DB セットアップ

```bash
bin/rails db:create db:migrate
```

### 3. サーバー起動

```bash
bin/rails s
```

`http://localhost:3000` にアクセスしてください。

## Docker での起動（任意）

```bash
docker build -t rails-portfolio .
docker run --rm -p 10000:10000 rails-portfolio
```

`http://localhost:10000` にアクセスできます。

## Render デプロイメモ

- `RAILS_ENV=production`
- `DATABASE_URL` を Render 側で設定
- Docker デプロイを利用

## データモデル（概要）

- `Post`
  - title, body
- `Category`
  - name, color
- `PostCategory`
  - Post と Category の中間テーブル

## 工夫したポイント

- シンプルで読みやすい UI
- カテゴリ絞り込み + 検索で投稿を探しやすく設計

## 今後の改善案

- 認証機能（管理者のみ投稿編集）
- ページネーション
- テストコード拡充（モデル/システムテスト）
- CI（GitHub Actions）導入
