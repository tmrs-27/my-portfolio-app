# Render 環境でアセット 404 が発生する場合の確認ポイント

## 1. Render のデプロイ方式を確認

**重要**: Render がどの方式でデプロイしているかにより、Dockerfile が使われるかどうかが決まります。

| 方式 | Dockerfile の使用 | 確認場所 |
|------|------------------|----------|
| **Docker** | ✅ 使用する | Dashboard → 該当サービス → Settings → デプロイ方式 |
| **Native / Blueprint** | ❌ 使用しない | `render.yaml` や Build Command を確認 |

- **Docker の場合**: このリポジトリの Dockerfile がビルドに使われます
- **Native の場合**: Build Command に次を含めてください:
  ```bash
  bundle exec rails tailwindcss:build && bundle exec rails assets:precompile
  ```

---

## 2. Render ダッシュボードで確認すること

### 2.1 ビルドログ
- **場所**: Dashboard → 該当 Web Service → Logs → Build logs
- **確認内容**:
  - `tailwindcss:build` が実行されているか
  - `assets:precompile` が実行されているか
  - `ERROR: public/assets is empty after precompile` が出ていないか
  - 途中でエラーで止まっていないか

### 2.2 ビルドキャッシュ
- **場所**: Dashboard → 該当サービス → Manual Deploy
- **操作**: 「Clear build cache & deploy」を実行して再デプロイ

### 2.3 環境変数
- **PORT**: Render が自動設定。Dockerfile の `-p 10000` をそのままにしている場合は、Render のデフォルトポートと一致しているか確認
- **RAILS_ENV**: `production` が設定されているか

---

## 3. 想定される原因と対応

| 原因 | 確認方法 | 対処 |
|------|----------|------|
| **Render が Native で Docker 未使用** | サービスの種別を確認 | Build Command に `tailwindcss:build` を追加 |
| **ビルドキャッシュの影響** | ログでビルド手順がスキップされていないか確認 | Clear build cache & deploy |
| **tailwindcss:build の失敗** | ビルドログにエラーが出ていないか | Node.js の有無、パス設定を確認 |
| **@source のパス不一致** | application.css の `@source "/app/..."` | Docker 内の WORKDIR が /app であることを確認 |
| **Thruster の挙動** | Gemfile に thruster がある場合 | 一時的に無効化して挙動を確認 |
| **静的ファイル配信の無効化** | production.rb | `config.public_file_server.enabled = true` であること |

---

## 4. 直接 URL での確認

デプロイ後にブラウザや curl で次の URL にアクセス:

```
https://my-rails-portfolio.onrender.com/assets/<実際のファイル名>.css
```

- 実際のファイル名はページの HTML ソース（`<link>` タグ）で確認
- **200 OK** → 配信はできている
- **404** → ファイルが存在しないか、パスが違う

---

## 5. ローカルでの Docker ビルドテスト

```bash
docker build -t rails-test .
docker run --rm rails-test ls -la public/assets/
```

`public/assets/` 内に `.css` ファイルが存在するか確認。
