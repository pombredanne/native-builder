HERE = $(shell pwd)

PACKAGE_NAME = file
PACKAGE_VERSION = 5.14
PACKAGE = $(PACKAGE_NAME)-$(PACKAGE_VERSION)
PACKAGE_DOWNLOAD = ftp://ftp.astron.com/pub/file/$(PACKAGE).tar.gz

BUILD_DIRS = $(PACKAGE)

.PHONY: all $(PACKAGE)

all: $(PACKAGE)

$(PACKAGE):
	@echo "Building $(PACKAGE)"
	mkdir -p $(PACKAGE)
	cd $(PACKAGE) && \
	curl --progress-bar $(PACKAGE_DOWNLOAD) | tar -zox
	cd $(PACKAGE)/$(PACKAGE) && \
	./configure && \
	make
	@echo "Done Building $(PACKAGE)"

