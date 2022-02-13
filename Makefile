PDFBOX_VER = 2.0.25
TAG = $(PDFBOX_VER)
REPO = takekazuomi

build:
	docker build \
		-t $(REPO)/pdfbox:$(TAG) \
		--build-arg VARIANT=$(PDFBOX_VER) .
	docker tag $(REPO)/pdfbox:$(TAG) $(REPO)/pdfbox:latest

run:
	docker run --rm -it -v $${PWD}:/ws -e UID=$$(id -u $${USER}) -e GID=$$(id -g $${USER}) $(REPO)/pdfbox

login:
	docker run --rm -it -v $${PWD}:/ws -e UID=$$(id -u $${USER}) -e GID=$$(id -g $${USER}) --entrypoint /bin/sh $(REPO)/pdfbox

push:
	docker push  $(REPO)/pdfbox:$(TAG)	
	docker push  $(REPO)/pdfbox:latest	

tag:
	git tag -a v$(TAG)

release:
	gh release create v$(TAG) -d --generate-notes -t v$(TAG) --target main
