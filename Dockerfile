FROM alpine:3.5

ARG VERSION=0.99.2

RUN apk add --no-cache --virtual .download-utils wget ca-certificates && \
    apk add --no-cache --virtual .build-utils gcc pkgconfig && \
    apk add --no-cache --virtual .dependencies libgcc libstdc++ zlib && \
    cd /src/ && \
    wget "https://www.clamav.net/downloads/production/clamav-${VERSION}.tar.gz" && \
    tar -xvf "clamav-${VERSION}.tar.gz" && \
    rm "clamav-${VERSION}.tar.gz" && \
    cd "clamav-${VERSION}" && \
    adduser -u 10327 -h /clamav/ -D -S clamav && \
    groupadd clamav && \
    usermod -a -G clamav clamav && \
    ./configure --with-user clamav --with-group clamav && \
    make -j`getconf _NPROCESSORS_ONLN` && \
    make install && \
    ldconfig && \
    apk del .download-utils .build-utils
