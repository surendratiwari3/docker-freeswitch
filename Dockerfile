FROM debian:buster

RUN apt-get update && apt-get install -yq git gnupg2 wget lsb-release pkg-config

RUN wget -O - https://files.freeswitch.org/repo/deb/debian-release/fsstretch-archive-keyring.asc | apt-key add -

RUN echo "deb http://files.freeswitch.org/repo/deb/debian-release/ `lsb_release -sc` main" > /etc/apt/sources.list.d/freeswitch.list

RUN echo "deb-src http://files.freeswitch.org/repo/deb/debian-release/ `lsb_release -sc` main" >> /etc/apt/sources.list.d/freeswitch.list

RUN apt-get update

RUN apt-get -yq build-dep freeswitch

WORKDIR /usr/local/src

RUN git clone https://github.com/signalwire/freeswitch.git --branch v1.10.2 freeswitch

WORKDIR /usr/local/src/freeswitch

COPY freeswitch/patches /usr/local/src/freeswitch/pathces

COPY freeswitch/custom_mod/asr_tts/mod_polly /usr/local/src/freeswitch/mod/asr_tts/mod_polly

RUN git apply --ignore-whitespace /usr/local/src/freeswitch/pathces/*.patch

COPY freeswitch/modules.conf /usr/local/src/freeswitch/modules.conf

RUN ./bootstrap.sh -j && ./configure && make && make install

RUN cp -Rf /usr/local/freeswitch/lib/pkgconfig/ /usr/local/lib/pkgconfig/

WORKDIR /usr/local/src/freeswitch/mod/asr_tts/mod_polly

RUN ./bootstrap.sh -j && ./configure && make && make install

WORKDIR /usr/local/src/freeswitch

RUN apt install curl

COPY entrypoint.sh /home/entrypoint.sh

COPY freeswitch/conf/vars.xml /usr/local/freeswitch/conf/vars.xml

COPY freeswitch/conf/autoload_configs/ /usr/local/freeswitch/conf/autoload_configs/

COPY freeswitch/conf/dialplan/ /usr/local/freeswitch/conf/dialplan/

COPY freeswitch/conf/sip_profiles/ /usr/local/freeswitch/conf/sip_profiles/

RUN apt install curl

RUN ln -s /usr/local/freeswitch/bin/freeswitch /usr/local/bin/

RUN ln -s /usr/local/freeswitch/bin/fs_cli /usr/local/bin

RUN chmod 755 /home/entrypoint.sh && \
        chown root:root /home/entrypoint.sh

COPY freeswitch/certs /usr/local/freeswitch/certs

ENTRYPOINT ["/home/entrypoint.sh"]
