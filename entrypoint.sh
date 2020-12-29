#!/bin/sh

if [ ! -f /etc/openvpn/passwd ]; then
  echo "$1">/etc/openvpn/passwd
fi

/usr/sbin/openvpn \
  --config /etc/openvpn/config \
  --askpass /etc/openvpn/passwd \
  --daemon \
  --log /dev/stdout \
  --script-security 2 \
  --up /etc/openvpn/up.sh \
  --down /etc/openvpn/down.sh

/usr/bin/tinyproxy -c /etc/tinyproxy.conf -d
