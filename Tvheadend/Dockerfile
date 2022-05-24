ARG BUILD_FROM
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

# Setup base
RUN apk add --update --no-cache tvheadend py-pip ffmpeg py3-lxml python3-dev g++ gcc libxslt-dev
RUN pip install --upgrade streamlink

# Copy data
COPY run.sh /
RUN ["chmod", "a+x", "run.sh"]