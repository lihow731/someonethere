# someonethere

Someonethere is a solution to find machines and  devices in the same sub-network.

This project provides twe command-line utiles.

The "someonethere" is a command-line tool to broadcast "someonethere" message via UDP (port 8613) then to wait for the respond from other devices.

The "utp-reply-someonethere" is a daemon run on the remote machines or devices. This daemon listens UDP port 8613 and waits for the "someonethere" message.
When this daemon received the "someonethere" message, the "domain name" and "IP address" information will be replyed to the message sender.
 

## Download & Install

### Source code
The source code is [someonethere github](https://github.com/lihow731/someonethere).

```
git clone https://github.com/lihow731/someonethere
```


### Install the Debian package

On ubuntu 16.04,

```
sudo add-apt-repository ppa:lihow731/ppa
sudo apt-get update
sudo apt-get install someonethere
```

##Files:
* udp-reply-someonethere:

    This is a service that listen the UDP port:8613.
    This service will reply the domain name and IP address when received "someonethere" message.
    We could put this daemon into _/usr/bin/_.

* someonethere: 

    This is a client tool that will broad "someonethere" message via UDP port:8613.
    And, wait the reply for one second.
    If get the replied message then print it out.
    We could put this tool into _/usr/bin/_.

* urs.service:

    For ubuntu 16.04 or newer.
    Systemd's service file.
    Put this file to _/lib/systemd/system/_.

* urs:
    For ubuntu 14.04 and Raspbian 8.0 (jessie)
    startup service file. Put this file to _/etc/init.d/_.
    Make it as a default service (start during booting.)
    
    `$ update-rc.d urs defaults`

## Usage

Run the daemon on remote machines or devices:

```
$ udp-reply-someonethere
```


When we want to know the machines IP.

```
$ someonethere
```

## Build

Under ubuntu 16.04,

```
dpkg-buildpackage
```

Built a unsigned package,

```
dpkg-buildpackage -us -uc -sa
```
