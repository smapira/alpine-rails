# `alpine-rails`: Minimal Rails image (virtual 649 MB)

This is a *VERY* small mri Rails Image, based on the [ruby:2.4.1-alpine](https://hub.docker.com/_/ruby/).

## Install

As a prerequisite, you need [Docker](https://docker.com) to be installed.

## Usage

To run:

    $ rails new .
    $ docker build -t smapira/alpine-rails .
	$ docker run -d -p 300:3000 smapira/alpine-rails
	$ open http://localhost:3000

## Super Thanks
- [docker-library/rails](https://github.com/docker-library/rails)
- [alpine linuxベースのdocker imageに移行したはなし - VASILY DEVELOPERS BLOG](http://tech.vasily.jp/entry/docker_image_slim_in_alpinelinux)
