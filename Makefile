
GVM_DIR ?= ${HOME}/.gvm
GVMRC ?= /dev/stdout
GOPATH ?= ${HOME}/go
GOROOT = $(GVM_DIR)/go
OS = $(shell uname -s)

.PHONY: gvmrc
gvmrc: check-darwin
	@if [ "$(GVMRC)" != '/dev/stdout' ] && [ -f "$(GVMRC)" ];then \
		mv $(GVMRC) $(GVMRC).bak;\
	fi
	@echo '### this is gvmrc file' >> $(GVMRC)
	@echo export GVMRC=$(GVMRC) >> $(GVMRC)
	@echo export GVM_DIR=$(GVM_DIR) >> $(GVMRC)
	@echo export GOPATH=$(GOPATH) >> $(GVMRC)
	@echo export GOROOT=$(GOROOT) >> $(GVMRC)
	@echo PATH='$${PATH}:$${GOROOT}/bin' >> $(GVMRC)

.PHONY: install
install: check-darwin gvmrc
	mkdir -p $(GOPATH)/{src,bin,pkg}
	mkdir -p $(GVM_DIR)
	mkdir -p /usr/local/bin
	sudo ln -sf ${PWD}/gvm.sh /usr/local/bin/gvm

.PHONY: uninstall
uninstall: check-darwin
	rm -if /usr/local/bin/gvm
	-[ "$(GVMRC)" != '/dev/stdout' ] && [ -n "$(GVMRC)" ] && rm -rf $(GVMRC)
	-rm -r $(GVM_DIR)

.PHONY: check-darwin
check-darwin:
	@if [ "$(shell uname -s)" == "Darwin" ];then echo not support mac; exit 1; fi
