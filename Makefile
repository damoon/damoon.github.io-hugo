
include ./hack/help.mk

BASE_URL=http://localhost/

.PHONY: run
run: hugo ##@setup start hugo server
	hugo server -D $(SERVE)

.PHONY: container
container: ##@setup build container image and execute
	docker build -t build -f ./hack/Dockerfile --build-arg BASE_URL=$(BASE_URL) .
	docker run --rm -p 80:80 build

.PHONY: publish
publish: ##@publish generate into docs folder
	hugo --baseURL https://damoon.github.io/
	cd public && git add . && git commit -m "automatic commit" && git push origin master
