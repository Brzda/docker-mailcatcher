FROM alpine:latest

MAINTAINER "Lukas Brzobohaty" <brzda.l@gmail.com>

ENV DEPENDECY_PACKAGES="ruby-dev make g++ sqlite-dev"
ENV BUILD_PACKAGES="ruby ruby-bigdecimal sqlite-libs libstdc++"

ENV MAILCATCHER_VERSION 0.5.12

RUN apk add --no-cache $DEPENDECY_PACKAGES $BUILD_PACKAGES \
	&& gem install -v $MAILCATCHER_VERSION mailcatcher --no-ri --no-rdoc \
	&& apk del $DEPENDECY_PACKAGES \
	&& rm -rf /var/cache/apk/*

# smtp port
EXPOSE 25

# webserver port
EXPOSE 80

CMD ["mailcatcher", "-f", "--ip=0.0.0.0", "--smtp-port=25", "--http-port=80"]