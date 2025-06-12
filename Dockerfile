FROM ruby:3.3.0

RUN apt-get update -qq && apt-get install -y nodejs sqlite3 libsqlite3-dev

WORKDIR /app

COPY Gemfile* ./
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]