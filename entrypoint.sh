#!/bin/sh

if [[ ! -f /etc/openvpn/passwd ]]; then
  echo "$OVPN_PASSWD">/etc/openvpn/passwd
fi

: > /var/log/openvpn

/usr/sbin/openvpn \
  --config /etc/openvpn/config \
  --askpass /etc/openvpn/passwd \
  --auth-nocache \
  --daemon \
  --log /dev/stdout \
  --script-security 2 \
  --up /etc/openvpn/up.sh \
  --down /etc/openvpn/down.sh \
  | tee /var/log/openvpn &

# wait till openvpn connected
grep -q 'Initialization Sequence Completed' <( tail -f /var/log/openvpn )

: > /etc/hosts.resolved

cat /etc/hosts.slow | while read domain; do
  if [[ "$domain" = "#"* ]]; then
    continue
  fi
  echo Find best IP for domain $domain
  all_ips=$( nslookup $domain | grep 'Address:' | grep -v ':53' | cut -d' ' -f2 )
  fastest_ip=$( echo "$all_ips" | head -n1 )
  if [[ "$( echo "$all_ips" | wc -l )" -gt 1 ]]; then
    fastest_ip=$(
      echo "$all_ips" | while read ip; do
        result=$( nmap -Pn -p 443 $ip )
        if [[ "$result" == *"1 host up"* ]]; then
          sec=$( echo $result | sed 's/.*scanned in //' | sed 's/ seconds//' )
          echo $ip $sec
        fi
      done | sort -k2 -n | head -n1 | cut -d' ' -f1
    )
  fi
  if [[ -n "$fastest_ip" ]]; then
    echo Found best IP for domain $domain: $fastest_ip
    echo $fastest_ip $domain >> /etc/hosts.resolved
  fi
done

# append resolved domains
cat /etc/hosts.resolved >> /etc/hosts

/usr/bin/tinyproxy -d &

sh
