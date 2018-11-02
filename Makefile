image:
	docker build -t gnomedev .
.PHONY: image

run:
	exec docker run -it --rm gnomedev bash
.PHONY: run
