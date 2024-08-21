FROM ruby:3.2.3-slim
WORKDIR /warehouse

RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/* \
    gem install bundler

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .
RUN bin/setup
