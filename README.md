# ccharon / kali-desktop
Fork of lukaszlach/kali-desktop

Modified because the kali-desktop image that lukaszlach uses and his own image have not been updated in almost 2 years.

![Kali Desktop](./docs/kali-desktop.png)

## Running the image
Like the original image all dependencies are included. After starting the image you can open your webbrowser at http://localhost:6080/vnc_auto.html and start.

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
* `--network host` - optional but recommended, use the host network interfaces, if you do not need to use this option you have to manually publish the ports by passing `-p 5900:5900 -p 6080:6080`
* `--privileged` - optional but recommended
* `-e RESOLUTION` - optional, set streaming resolution and color depth, default `1280x1024x24`
* `-e USER` - optional, work as a user with provided name, default `root`
* `-e PASSWORD` - optional, provide a password for USER, default `kali`
* `-e ROOT_PASSWORD` - optional, provide password for root, default `root`
* `-v /home/kali:/home/kali` - optional, if USER was provided it is a good idea to persist user settings, work files and look-and-feel

### Exposed ports

* `5900/tcp` - VNC
* `6080/tcp` - noVNC, web browser VNC client

### Building the image
```bash
docker build -f Dockerfile -t kali-desktop:latest  .
```

## How this image works
mostly for myself as it took me a while to understand 😁
...
