
include ./hack/help.mk

SERVE=serve -D --bind=0.0.0.0
BASE_URL=http://localhost/

.PHONY: run
run: hugo stop ##@setup start
	docker run --rm -p 1313:1313 -v $(PWD):$(PWD) -w $(PWD) --entrypoint hugo hugo $(SERVE)

.PHONY: start
start: hugo stop ##@setup start in background
	docker run --rm -d --name hugo -p 1313:1313 -v $(PWD):$(PWD) -w $(PWD) --entrypoint hugo hugo $(SERVE)

.PHONY: logs
logs: ##@setup show logs
	docker logs -f hugo

.PHONY: stop
stop: ##@setup stop background process
	docker stop -t 1 hugo || true

.PHONY: build
build: ##@setup build container image and execute
	docker build -t build -f ./hack/Dockerfile --build-arg BASE_URL=$(BASE_URL) .
	docker run --rm -p 80:80 build

.PHONY: hugo
hugo:
	docker build -t hugo -f ./hack/Dockerfile --target hugo .
