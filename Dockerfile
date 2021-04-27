FROM alpine
RUN apk add --no-cache openvpn tinyproxy
ENTRYPOINT ["/entrypoint.sh"]
