ARG BUILD_FROM
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

# Setup base
RUN apk add --no-cache jq curl sed python3 go gcc libc-dev
RUN go get -u -v github.com/huin/goupnp
RUN go get -u -v github.com/eclipse/paho.mqtt.golang
RUN go get -u -v github.com/gorilla/websocket
RUN go get -u -v golang.org/x/net/proxy

# Copy data
COPY run.sh /
COPY rub.go /
RUN ["chmod", "a+x", "/run.sh"]
WORKDIR /

CMD [ "/run.sh" ]
