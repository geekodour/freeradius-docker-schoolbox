IMGNAME = freeradius-schoolbox
IMGTAG = latest
NETWORK = schoolbox-network
PORT = 3306
.PHONY: all build

all: build
kill: stop delete

build:
	@docker build -t $(IMGNAME):$(IMGTAG) .

run:
	docker run -t -d\
    --name $(IMGNAME)_run \
	--net $(NETWORK) \
	$(IMGNAME):$(IMGTAG)

debug:
	docker run -t \
    --name $(IMGNAME)_run \
	--net $(NETWORK) \
	$(IMGNAME):$(IMGTAG) -X

start:
	@docker start $(IMGNAME)_run

stop:
	@docker stop $(IMGNAME)_run

delete:
	@docker container rm $(IMGNAME)_run
