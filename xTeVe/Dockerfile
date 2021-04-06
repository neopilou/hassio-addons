ARG BUILD_FROM
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

# Copy data
COPY xteve /
RUN ["chmod", "x", "/xteve"]
WORKDIR /

CMD [ "./xteve" ]
