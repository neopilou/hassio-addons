ARG BUILD_FROM
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

# Setup base
RUN apk add --no-cache tvheadend

# Copy data
COPY rootfs /
RUN ["chmod", "a+x", "/rootfs/etc/services.d/tvheadend/run"]