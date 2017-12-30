IMAGE = meg4r0m/alpine-apache-php5.6
VERSIONS = 2.4_2.4.29

.PHONY: all $(VERSIONS)

all: $(VERSIONS) tag-latest

$(VERSIONS): MAJOR = $(firstword $(subst _, ,$@))
$(VERSIONS): MINOR = $(word 2,$(subst _, ,$@))
$(VERSIONS):
	@echo "=> building $(IMAGE):$(MAJOR)"
	@docker build \
		--build-arg APACHE_VERSION=$(MINOR) \
		--build-arg APACHE_MAJOR=$(MAJOR) \
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