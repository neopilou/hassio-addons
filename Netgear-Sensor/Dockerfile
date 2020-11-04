ARG BUILD_FROM
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

# Setup base
RUN apk add --no-cache jq curl mosquitto-clients sed coreutils

# Copy data
COPY cmd.sh /
RUN ["chmod", "a+x", "/cmd.sh"]
WORKDIR /

CMD [ "/cmd.sh" ]
