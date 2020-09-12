FROM ruby:2.5.1

# Default encoding of files.
ENV LANG C.UTF-8

# Timezone.
ENV TZ America/Sao_Paulo

# Basic dependencies.
RUN apt-get update -y
RUN apt-get install -y build-essential libpq-dev

# Node.js and Yarn.
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g yarn

# App.
RUN mkdir /app
WORKDIR /app
COPY ./Gemfile /app/Gemfile
COPY ./Gemfile.lock /app/Gemfile.lock
RUN bundle install
EXPOSE 3000
COPY ./* /app/
VOLUME /app

# Command.
CMD rm -Rf tmp/pids/ && \
    npm cache clean --force && \
    yarn install && \
    bundle exec rails s -b 0.0.0.0
