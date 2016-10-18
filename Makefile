BASHRC = $(HOME)/.bashrc

install:
	if [ -f "$(BASHRC)" ] && ! grep 'gvm start' "$(BASHRC)" > /dev/null ; then \
		cat ./temp/bashrc >> "$(BASHRC)"; \
		. $(BASHRC); \
	fi;

	sudo ln -sf $(PWD)/gvm.sh /usr/local/bin/gvm;
