IMAGE = meg4r0m/debian-php5.4
VERSIONS = 5.4_5.4.45

.PHONY: all $(VERSIONS)

all: $(VERSIONS) tag-latest

$(VERSIONS): MAJOR = $(firstword $(subst _, ,$@))
$(VERSIONS): MINOR = $(word 2,$(subst _, ,$@))
$(VERSIONS):
	@echo "=> building $(IMAGE):$(MAJOR)"
	@docker build \
		--build-arg HAPROXY_VERSION=$(MINOR) \
		--build-arg HAPROXY_MAJOR=$(MAJOR) \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		-t $(IMAGE):$(MAJOR) -f Dockerfile .
	@docker tag $(IMAGE):$(MAJOR) $(IMAGE):$(MINOR)
	@echo "=> pushing $(IMAGE):$(MAJOR)"
	@docker push $(IMAGE):$(MAJOR)
	@docker push $(IMAGE):$(MINOR)

tag-latest: MAJOR = $(firstword $(subst _, ,$(word $(words $(VERSIONS)),$(VERSIONS))))
tag-latest:
	@echo "=> pushing $(IMAGE):latest"
	@docker tag $(IMAGE):$(MAJOR) $(IMAGE):latest
@docker push $(IMAGE):latest