FROM alpine:latest

RUN apk add --update --no-cache openvpn tinyproxy nmap

COPY ./etc/tinyproxy/tinyproxy.conf /etc/tinyproxy/tinyproxy.conf

COPY ./etc/openvpn/hosts /etc/openvpn/

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# expose 8888 as proxy port, remap using `docker run -p <port>:8888`
EXPOSE 8888

# where we keep slow hosts config
VOLUME /etc/openvpn/hosts

ENTRYPOINT ["/entrypoint.sh"]
