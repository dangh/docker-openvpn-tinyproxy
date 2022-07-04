# docker-openvpn-tinyproxy

### Usage

```sh
docker pull huynhminhdang/openvpn-tinyproxy
docker run \
  --volume <openvpn-profile-dir>:/etc/openvpn/profile \
  --volume <openvpn-hosts-dir>:/etc/openvpn/hosts \
  --publish <proxy-port>:8888 \
  --device /dev/net/tun \
  --cap-add NET_ADMIN \
  --rm \
  --tty \
  --detach \
  huynhminhdang/openvpn-tinyproxy
```

#### Mount points and files

- `<openvpn-profile-dir>/config`: OpenVPN profile file.
- `<openvpn-profile-dir>/passwd`: OpenVPN password in plain text.
- `<openvpn-hosts-dir>/resolve`: List of domains that have slow connection (for example: `ssm.ap-southeast-1.amazonaws.com`)

### Build docker image

```sh
git clone https://github.com/dangh/docker-openvpn-tinyproxy.git
cd docker-openvpn-tinyproxy
./build
```
