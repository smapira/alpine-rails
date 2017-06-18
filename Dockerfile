FROM ruby:2.4.1-alpine

RUN apk add --no-cache --update sqlite sqlite-dev mysql-client nginx supervisor build-base patch linux-headers mariadb-dev tzdata
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN echo -e 'http://dl-cdn.alpinelinux.org/alpine/edge/main\nhttp://dl-cdn.alpinelinux.org/alpine/edge/community\nhttp://dl-cdn.alpinelinux.org/alpine/edge/testing' > /etc/apk/repositories
RUN apk add --no-cache nodejs-current yarn

ENV app_path /usr/src/app
WORKDIR $app_path

RUN echo "install: --no-document" > $HOME/.gemrc && echo "update: --no-document" >> $HOME/.gemrc
COPY Gemfile* ./
RUN bundle install --path vendor/bundle --jobs 4

ADD . $app_path

EXPOSE 3000
ENTRYPOINT ["rails", "server"]