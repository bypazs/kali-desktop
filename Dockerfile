FROM kalilinux/kali-rolling:latest

ARG KALI_METAPACKAGE=tools-top10
ARG KALI_DESKTOP=xfce

ENV DEBIAN_FRONTEND=noninteractive

RUN true \
# Alles was nicht mit Exitcode 0 endet sorgt fuer einen Abbruch des Shellscripts
   && set -e \
# Debugging, Alle Kommandos werden vor der Ausfhrung ausgegeben
   && set -x \
# Kali non-free Paketquellen hinzufgen
   && echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" > /etc/apt/sources.list \
   && echo "deb-src http://http.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list \
# System aktualisieren.
   && apt-get update \
   && apt-get -y dist-upgrade \
# Kali Desktop und novnc installieren.
   && apt install -y \
        curl sudo apt-transport-https gnupg \
        x11vnc xvfb novnc dbus-x11 x11-xkb-utils \
        kali-defaults \
        kali-${KALI_METAPACKAGE} \
        kali-desktop-${KALI_DESKTOP} \
        python3-pip python3 wpscan \
        mc nano zaproxy \
# putzen
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*...

# S6 Overlay, angepasstes Init System
ARG S6_OVERLAY_VERSION=2.2.0.3
ENV S6_OVERLAY_VERSION $S6_OVERLAY_VERSION

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz /tmp/
RUN true \
# entpacken direkt ins root verzeichnis
   && tar xzf "/tmp/s6-overlay-amd64.tar.gz" -C / \
# putzen
   && rm -f /tmp/s6-overlay-amd64.tar.gz...

COPY etc/ /etc

ENV DISPLAY=:1
ENV KALI_DESKTOP=xfce
ENV ROOT_PASSWORD=root
ENV PASSWORD=kali
ENV USER=admin
ENV RESOLUTION=1280x1024x24

EXPOSE 5900/tcp 6080/tcp

ENTRYPOINT ["/init"]
