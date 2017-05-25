FROM alpine:3.5

RUN apk add --no-cache clamav-daemon

COPY freshclam.cron.sh /freshclam.cron.sh
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
