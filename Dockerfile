FROM ruby:3.3

# PostgreSQLを使うためのパッケージを追加
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

# 起動時にデータベースの準備をしてから、Railsを起動する設定に変更
CMD ["sh", "-c", "bundle exec rails db:migrate && bundle exec rails server -b 0.0.0.0 -p 10000"]