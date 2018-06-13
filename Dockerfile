FROM ruby:alpine

ENV app_path /usr/src/app
WORKDIR $app_path
COPY Gemfile* ./
RUN echo "install: --no-document" > $HOME/.gemrc && echo "update: --no-document" >> $HOME/.gemrc
RUN apk add --update --no-cache --virtual=.build-dependencies \
		build-base \
		linux-headers \
		zlib-dev && \
    apk add --no-cache \
		git \
		sqlite-dev \
		mariadb-dev \
		openssh \
		patch \
		tzdata && \
    bundle install --path vendor/bundle --jobs 4 --without development test && \
    apk del .build-dependencies
RUN echo -e 'http://dl-cdn.alpinelinux.org/alpine/edge/main\nhttp://dl-cdn.alpinelinux.org/alpine/edge/community\nhttp://dl-cdn.alpinelinux.org/alpine/edge/testing' > /etc/apk/repositories
RUN apk add --no-cache nodejs-current yarn
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
ADD . $app_path

EXPOSE 3000
ENTRYPOINT ["rails", "server", "-b", "0.0.0.0"]
