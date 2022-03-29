FROM alpine
RUN apk add --update --no-cache openvpn tinyproxy nmap
ENTRYPOINT ["/entrypoint.sh"]
