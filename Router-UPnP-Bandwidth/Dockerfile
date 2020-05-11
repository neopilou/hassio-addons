ARG BUILD_FROM
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

# Setup base
RUN apk add --no-cache curl gcc git go jq libc-dev python3 sed 
RUN go get -u github.com/huin/goupnp
RUN go get -u github.com/eclipse/paho.mqtt.golang
RUN go get -u github.com/gorilla/websocket
RUN go get -u golang.org/x/net/proxy

# Copy data
COPY run.sh /
COPY rub.go /
RUN ["chmod", "a+x", "/run.sh"]
WORKDIR /

CMD [ "/run.sh" ]
