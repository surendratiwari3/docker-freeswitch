# docker-freeswitch


# FreeSWITCH 1.10.x


## Maintainer
Surendra Tiwari | <surendratiwari3@gmail.com> | [github](https://github.com/surendratiwari3)


## Description
FreeSWITCH deployment using docker that can provide way to add your changes configuration and your patches also.This image uses Buster Debian Linux.

## Structure

docker-freeswitch have below structure


```txt
.
├── freeswitch
│   ├── certs [In this directory, place all the certificates that freeswitch required]
│   ├── conf  [Place all file configuration files that you have modifies in freeswitch vanila in respective folder]
│   ├── patches [All freeswitch pathces]
│   └── modules.conf [This file is used in freeswitch installation, please keep all the module that you want in your installation here]
├── Dockerfile
├── entrypoint.sh
```

## TODO

```markdown

- [ ]  running freeswitch without host mode @owner
- [ ]  iptables definition for rtp rules @owner
- [ ]  freeswitch custom module building support @owner
- [ ]  support for other providers

```

## Run Environment
* `PROFILE`

## Usage

To build:

```bash
git clone https://github.com/surendratiwari3/docker-freeswitch.git
cd docker-freeswitch
docker build -t surendratiwari/freeswitch-buster .
```

To run:

```bash
docker run -d \ 
    --name freeswitch \
    --net=host \
    -e "PROFILE=aws" \  
    --mount type=bind,source=/call_recordings,target=/call_recordings \
    surendratiwari/freeswitch-buster
```
