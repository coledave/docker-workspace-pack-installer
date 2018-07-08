FROM alpine:3.7

RUN \
  echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories && \
  apk update && apk upgrade && apk add --no-cache \
      bash \
      git \
      openssh \
      python \
      py-pip \
      shadow \
  && pip install shyaml

RUN useradd --create-home --system build
ENV PATH "$PATH:/home/build/bin"

COPY bin /bin
COPY entrypoint.sh /entrypoint.sh

RUN mkdir /app
WORKDIR /app 

ENTRYPOINT ["/entrypoint.sh"]
