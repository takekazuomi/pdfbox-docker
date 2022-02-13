PDFBOX_VER = 2.0.25
REPO = takekazuomi

build:
	docker build \
		-t $(REPO)/pdfbox:$(PDFBOX_VER) \
		--build-arg VARIANT=$(PDFBOX_VER) .
	docker tag $(REPO)/pdfbox:$(PDFBOX_VER) $(REPO)/pdfbox:latest

run:
	docker run --rm -it -v $${PWD}:/ws -e UID=$$(id -u $${USER}) -e GID=$$(id -g $${USER}) $(REPO)/pdfbox

login:
	docker run --rm -it -v $${PWD}:/ws -e UID=$$(id -u $${USER}) -e GID=$$(id -g $${USER}) --entrypoint /bin/sh $(REPO)/pdfbox

push:
	docker push  $(REPO)/pdfbox:$(PDFBOX_VER)	
	docker push  $(REPO)/pdfbox:latest	