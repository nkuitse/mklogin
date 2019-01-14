include config.mk

build: build-prog

build-prog: build/$(PROG)

configure: config.mk

config.mk: config.mk.def
	if [ ! -e $@ ]; then \
		cp $< $@; \
		$(VISUAL) $<; \
	fi

build/$(PROG): configure mklogin
	install -d build
	bin/build PROG=$(PROG) VERSION=$(VERSION) PREFIX=$(PREFIX) ROOT=$(ROOT) BUILDDATE=`date +%F` < mklogin > $@

data: build/passwd build/group build/type

build/passwd: data/passwd
	cp $< $@

build/group: data/group
	cp $< $@

build/type: data/type
	cp $< $@

data/passwd: /etc/passwd
	perl -ne 'print if /^[^:]+:x:([0-9]+):/ && $$1 >= 1000' $< > $@

data/group: /etc/group
	perl -ne 'print if /^[^:]+:x:([0-9]+):/ && $$1 >= 1000' $< > $@

data/type:
	touch data/type

clean:
	rm -Rf build

install: install-prog
	
install-prog: build-prog
	install -d $(PREFIX)/bin
	install build/$(PROG) $(PREFIX)/bin/

install-data:
	install -d $(ROOT)
	cp build/passwd build/group build/type $(ROOT)/

.PHONY: configure build build-prog build-data clean install install-prog install-data
