ARG BUILD_FROM
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

# Setup base
RUN apk add --no-cache sed jq curl mosquitto-clients coreutils

# Copy data
COPY cmd.sh /
RUN ["chmod", "a+x", "/cmd.sh"]
WORKDIR /

CMD [ "/cmd.sh" ]
