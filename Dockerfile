FROM debian:jessie

ENV GRAFANA_VERSION 3.1.1-1470047149

RUN apt-get update && \
    apt-get -y install libfontconfig wget adduser openssl ca-certificates && \
    apt-get clean && \
    wget https://grafanarel.s3.amazonaws.com/builds/grafana_${GRAFANA_VERSION}_amd64.deb -O /tmp/grafana.deb && \
    dpkg -i /tmp/grafana.deb && \
    rm /tmp/grafana.deb

ADD conf/logrotate /etc/logrotate.d/graphite

VOLUME ["/var/lib/grafana", "/var/log/grafana", "/etc/grafana"]

EXPOSE 3000

ENTRYPOINT ["/usr/sbin/grafana-server", "--homepath=/usr/share/grafana", "--config=/etc/grafana/grafana.ini", "cfg:default.paths.data=/var/lib/grafana", "cfg:default.paths.logs=/var/log/grafana"]
