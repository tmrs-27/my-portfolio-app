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

# ビルド時にアセットを固めておく（RAILS_ENVを指定）
RUN RAILS_ENV=production bundle exec rails assets:precompile

CMD ["sh", "-c", "bundle exec rails db:migrate && bundle exec rails server -b 0.0.0.0 -p 10000"]