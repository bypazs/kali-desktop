# ccharon / kali-desktop
Fork von lukaszlach/kali-desktop
Angepasst weil es das kali-desktop Image so nicht mehr gibt und das Original Jahre alt ist.

![Kali Desktop](./docs/kali-desktop.png)

## Ausfuehren
Wie im Original sind alle Abhaengigkeiten im Image enthalten. Man muss also nur das Image starten und im Webbrowser http://localhost:6080/vnc_auto.html gehts los
```bash
docker run -d \
    -p 5900:5900 -p 6080:6080 \
    --privileged \
    -e RESOLUTION=1280x1024x24 \
    -e USER=${USER}\
    -e PASSWORD=kali \
    -e ROOT_PASSWORD=root \
    -v ${HOME}/kali:${HOME} \
    --name kali-desktop \
    kali-desktop:latest
```

### Parameter
* `--privileged` - optional, aber empfohlen. Nur so funktionieren Dinge wie Portscans und so
* `-e RESOLUTION` - optional, setzen der Ausgabeauflösung, default `1280x1024x24`
* `-e USER` - optional, legt einen Nutzer mit dem angegebenen Namen an, default `root`
* `-e PASSWORD` - optional, vergeben eines Passworts fuer USER, default `kali`
* `-e ROOT_PASSWORD` - optional, vergeben eines Passworts fuer root, default `root`
* `-v /home/kali:/home/kali` - optional, so kann man ein persistentes /home Verzeichnis haben

### Portfreigaben

* `5900/tcp` - VNC
* `6080/tcp` - noVNC, web browser VNC client

### Image bauen
```bash
docker build -f Dockerfile -t kali-desktop:latest  .
```
