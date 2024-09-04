FROM ruby:3.2.3-slim
WORKDIR /warehouse

RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/* \
    gem install bundler

COPY Gemfile Gemfile.lock ./
RUN bundle install

# COPY db/seeds.rb ./db/
# RUN bundle exec rails db:reset

COPY . .
RUN bin/setup
# RUN bundle exec rails db:reset
