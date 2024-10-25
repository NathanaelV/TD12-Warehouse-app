FROM ruby:3.2.3
WORKDIR /warehouse

RUN apt-get update && apt-get upgrade -y && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash && \
    apt-get install -y \
    libasound2 \
    libatk-bridge2.0-0 \
    libgtk-4-1 \
    libnss3 \
    xdg-utils

RUN gem install bundler
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .
