DOCKER_IMAGE_NAME ?= ccharon/kali-desktop
DATETIME = $(shell date +"%Y%m%d%H%M")

build:
	docker build -f Dockerfile -t docker-kali .
	docker tag docker-kali ${DOCKER_IMAGE_NAME}:${DATETIME}
	docker tag docker-kali ${DOCKER_IMAGE_NAME}:$$(docker run --entrypoint '' docker-kali bash -c '. /etc/os-release; echo "$$VERSION";')
	${MAKE} list

list:
	docker images | grep ${DOCKER_IMAGE_NAME}

push:
	docker images --format '{{.Repository}}:{{.Tag}}' | \
		grep '${DOCKER_IMAGE_NAME}' | \
		xargs -n1 docker push

run:
	docker rm -f docker-kali || true
	docker run -d --name docker-kali -p 5900:5900 -p 6080:6080 --privileged -e RESOLUTION=1280x1024x24 -e USER=${USER} -e PASSWORD=kali -e ROOT_PASSWORD=root -v ${HOME}/kali:${HOME} docker-kali

debug:
	docker rm -f docker-kali || true
	docker run -it --name docker-kali -p 5900:5900 -p 6080:6080 --privileged -e RESOLUTION=1280x1024x24 -e USER=${USER} -e PASSWORD=kali -e ROOT_PASSWORD=root -v ${HOME}/kali:${HOME} docker-kali

stop:
	docker kill docker-kali

cli:
	docker exec -it docker-kali bash
