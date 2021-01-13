# docker-freeswitch


# FreeSWITCH 1.10.x


## Maintainer
Surendra Tiwari | <surendratiwari3@gmail.com> | [github](https://github.com/surendratiwari3)


## Description
FreeSWITCH deployment using docker that can provide way to add your changes configuration and your patches also.This image uses Buster Debian Linux.

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
    surendratiwari/freeswitch-buster
```
