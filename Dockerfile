FROM ubuntu:rolling

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y libio-socket-ssl-perl ddclient curl ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add configuration files
COPY ddclient /etc/default/ddclient
COPY ddclient.conf /etc/ddclient.conf
COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

ENTRYPOINT  ["/opt/entrypoint.sh"]