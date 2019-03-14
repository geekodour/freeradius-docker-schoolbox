IMGNAME = freeradius-schoolbox
IMGTAG = latest
NETWORK = bridge
MYSQL_PORT = 3306
MYSQL_SERVER := $(shell docker inspect --format '{{ .NetworkSettings.IPAddress }}' mysql-schoolbox_run)
MYSQL_USERNAME = root
MYSQL_PASSWORD = password
MYSQL_DATABASE = radius
.PHONY: all build

all: build
kill: stop delete
killall: stopall deleteall
dpush: taglatest push

build:
	@docker build -t $(IMGNAME):$(IMGTAG) \
	--build-arg server=$(MYSQL_SERVER) \
	--build-arg port=$(MYSQL_PORT) \
	--build-arg username=$(MYSQL_USERNAME) \
	--build-arg password=$(MYSQL_PASSWORD) \
    --build-arg database=$(MYSQL_DATABASE) .

run:
	docker run -t -d\
    --name $(IMGNAME)_run \
	--net $(NETWORK) \
    -p 1812-1813:1812-1813/udp \
    -e MYSQL_SERVER=$(MYSQL_SERVER) \
	$(IMGNAME):$(IMGTAG)

debug:
	docker run -t \
    --name $(IMGNAME)_run \
	--net $(NETWORK) \
    -p 1812-1813:1812-1813/udp \
    -e MYSQL_SERVER=$(MYSQL_SERVER) \
	$(IMGNAME):$(IMGTAG) -X

start:
	@docker start $(IMGNAME)_run

stop:
	@docker stop $(IMGNAME)_run

delete:
	@docker container rm $(IMGNAME)_run

deleteall:
	@docker container rm $(shell docker ps -aq)

stopall:
	@docker stop $(shell docker ps -aq)

taglatest:
	docker tag $(IMGNAME):$(IMGTAG) schoolboxsih/$(IMGNAME):$(IMGTAG)

push:
	@docker push schoolboxsih/$(IMGNAME):$(IMGTAG)
