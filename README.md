# docker-openvpn-tinyproxy

### Build docker image

```sh
$ git clone https://github.com/dangh/docker-openvpn-tinyproxy.git
$ cd docker-openvpn-tinyproxy
$ ./build
```

### Run docker container

Run *start* script with first argument is the path to the VPN profile file.
To avoid password prompt, put the raw password in the `.passwd` file next to the profile file.

```
$ ls
profile.ovpn
profile.ovpn.passwd

$ ./start profile.ovpn
```

### Troubleshooting

If you notice some hosts has slow connection (for example: `ssm.ap-southeast-1.amazonaws.com`), add the domain to *etc/hosts.slow* and start container with `-r` flag
