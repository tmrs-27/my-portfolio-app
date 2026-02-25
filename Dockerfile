FROM ruby:3.3

# 必要なパッケージのインストール
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  git

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

# 【ここが重要】Rails 8 + Tailwind v4 用のシンプルなプリコンパイル
# 1. 一旦古いアセットを削除
# 2. tailwindcss:build は使わず、assets:precompile だけを実行
RUN rm -rf public/assets && \
    RAILS_ENV=production SECRET_KEY_BASE=dummy bundle exec rails assets:precompile

# 実行コマンドに RAILS_ENV を明示的に追加
CMD ["sh", "-c", "RAILS_ENV=production bundle exec rails db:migrate && RAILS_ENV=production bundle exec rails server -b 0.0.0.0 -p 10000"]
