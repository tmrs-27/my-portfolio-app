FROM ruby:3.3

# gitを追加（PropshaftやTailwindのビルドに必要になる場合があります）
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  git

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

# ビルド時にアセットを固めておく
# 1. Tailwind CSS を先にビルド（app/assets/builds/tailwind.css を生成）
# 2. 全アセットをプリコンパイル（public/assets/ に出力）
RUN RAILS_ENV=production SECRET_KEY_BASE=dummy bundle exec rails tailwindcss:build && \
    RAILS_ENV=production SECRET_KEY_BASE=dummy bundle exec rails assets:precompile

CMD ["sh", "-c", "bundle exec rails db:migrate && bundle exec rails server -b 0.0.0.0 -p 10000"]