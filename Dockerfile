FROM alpine
RUN apk add --update-cache openvpn tinyproxy
ENTRYPOINT ["/entrypoint.sh"]
