ARG BUILD_FROM
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

# Setup base
RUN apk add --no-cache jq curl sed python3 go gcc libc-dev \
    && go get -u github.com/huin/goupnp \
    && go get -u github.com/eclipse/paho.mqtt.golang \
    && go get -u github.com/gorilla/websocket \
    && go get -u golang.org/x/net/proxy

# Copy data
COPY run.sh /
COPY rub.go /
RUN ["chmod", "a+x", "/run.sh"]
WORKDIR /

CMD [ "/run.sh" ]