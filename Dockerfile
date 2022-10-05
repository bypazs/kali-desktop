FROM scratch as s6-amd64
ARG S6_OVERLAY_VERSION=2.2.0.3
ENV S6_OVERLAY_VERSION $S6_OVERLAY_VERSION

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz /tmp/s6-overlay.tar.gz

FROM scratch as s6-arm64
ARG S6_OVERLAY_VERSION=2.2.0.3
ENV S6_OVERLAY_VERSION $S6_OVERLAY_VERSION

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-arm.tar.gz /tmp/s6-overlay.tar.gz

# no action here just choose the right s6 archive depending on architecture
FROM s6-${TARGETARCH} as s6

FROM kalilinux/kali-rolling:latest

ARG KALI_METAPACKAGE=tools-top10
ARG KALI_DESKTOP=xfce

ENV DEBIAN_FRONTEND=noninteractive

# add kali non-free package source
RUN echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" > /etc/apt/sources.list 
RUN echo "deb-src http://http.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list 
# update system
RUN apt-get update 
RUN apt-get -y dist-upgrade 
# install kali xfce desktop and top 10
RUN apt-get install -y \
        curl sudo apt-transport-https gnupg \
        x11vnc xvfb novnc dbus-x11 x11-xkb-utils \
        kali-defaults \
        kali-${KALI_METAPACKAGE} \
        kali-desktop-${KALI_DESKTOP} \
        python3-pip python3 wpscan \
        mc nano zaproxy gobuster \
        ffuf arp-scan cewl dirb \
        dnsenum enum4linux evil-winrm \
        hash-identifier hashcat hydra \
        impacket-scripts masscan \
        netdiscover nikto openvpn \
        p7zip-full proxychains4 \
        python3-impacket smbmap \
        snmp snmpcheck telnet theharvester \
        wafw00f webshells wfuzz \
        whatweb windows-binaries \
        winexe wordlists seclists 
# clean up
RUN apt-get clean 
RUN rm -rf /var/lib/apt/lists/*

# install s6 init overlay
COPY --from=s6 /tmp/s6-overlay.tar.gz /tmp/s6-overlay.tar.gz

RUN true \
# unpack
   && tar xzf "/tmp/s6-overlay.tar.gz" -C / \
# cleanup
   && rm -f /tmp/s6-overlay.tar.gz

COPY etc/ /etc

ENV DISPLAY=:1
ENV KALI_DESKTOP=xfce
ENV ROOT_PASSWORD=kali
ENV PASSWORD=kali
ENV USER=kali
ENV RESOLUTION=1980x1080x24

EXPOSE 5900/tcp 6080/tcp

# Gimmick
RUN sudo echo 'SOSECURE More than Secure\nGrim The Ripper Team\nhttps://medium.com/@grimthereaperteam\nhttps://github.com/bypazs/GrimTheRipper' >> /root/bypazs.txt

# Extract Wordlist
RUN sudo gunzip /usr/share/wordlists/rockyou.txt.gz

ENTRYPOINT ["/init"]
