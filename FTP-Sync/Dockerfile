ARG BUILD_FROM
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
RUN apk add --no-cache \
jq \
curl \
wget \
findutils \
python3 \
python3-dev
RUN pip3 install python-dateutil==2.8.1 pytz==2020.1

# Copy data
COPY run.sh /
COPY keep_last.py /
RUN ["chmod", "a+x", "/run.sh"]
WORKDIR /

CMD [ "/run.sh" ]
