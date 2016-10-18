BASHRC = $(HOME)/.bashrc

install:
	if [ -f "$(BASHRC)" ] && ! grep 'gvm start' "$(BASHRC)" > /dev/null ; then \
		cat ./temp/bashrc >> "$(BASHRC)"; \
		. $(BASHRC); \
		mkdir -p $(GOPATH)/{src,bin,pkg} ;\
	fi;

	sudo ln -sf $(PWD)/gvm.sh /usr/local/bin/gvm;

