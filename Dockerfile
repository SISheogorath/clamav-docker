FROM alpine:3.6

RUN apk add --no-cache clamav-daemon

COPY freshclam.cron.sh /freshclam.cron.sh
COPY entrypoint.sh /entrypoint.sh

EXPOSE 3310

ENTRYPOINT ["/entrypoint.sh"]
