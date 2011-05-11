
ROOT=${shell pwd}/

DEBS = \
	m68k-amigaos-binutils-2.14.deb \
	m68k-amigaos-gcc-2.95.3.deb \
	m68k-amigaos-gcc-3.4.0.deb \
	ixemul-48.0.deb \
	libnix-1.2.deb \
	libamiga.deb \
	ndk-3.9-includes.deb

all: $(DEBS)

$(DEBS): %.deb: control/%/control %.tar.bz2
	rm -rf $(ROOT)/$*
	mkdir -p $(ROOT)/$*/usr/local
	(export PWD=`pwd` && cd $(ROOT)/$*/usr/local && tar jxf $(PWD)/$< )
	cp -Rap control/$* $(ROOT)/$*/DEBIAN
	dpkg --build $(ROOT)/$*
	rm -rf $(ROOT)/$*

# Retrieve any binaries not present
# FIXME: The "nice" thing to do would be to build these from source.
# (Thanks to ZeroHero aka Joachim Birging for hosting the binaries)

 %.tar.bz2:
	wget http://cross.zerohero.se/i686-linux/$*.tar.bz2

