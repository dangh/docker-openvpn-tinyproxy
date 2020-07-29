#!/bin/sh

echo "$1">/etc/openvpn/passwd

/usr/sbin/openvpn \
  --config /etc/openvpn/config \
  --askpass /etc/openvpn/passwd \
  --daemon \
  --log /dev/stdout \
  --script-security 2 \
  --up /etc/openvpn/up.sh \
  --down /etc/openvpn/down.sh

/usr/bin/tinyproxy -c /etc/tinyproxy.conf -d
