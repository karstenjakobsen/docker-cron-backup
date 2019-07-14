FROM alpine:3.6

RUN apk add --update bash

RUN apk update && apk add dcron wget rsync ca-certificates && rm -rf /var/cache/apk/*

RUN mkdir -p /var/log/cron && mkdir -m 0644 -p /var/spool/cron/crontabs && touch /var/log/cron/cron.log && mkdir -m 0644 -p /etc/cron.d

RUN mkdir /app
ADD cron-backup.sh /app/
ADD backup.sh /app/

WORKDIR /app

CMD ["/bin/bash" , "cron-backup.sh"]
