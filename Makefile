SRC_NAME=src-packetized
VERSION=1.0.2
PACKAGE_NAME=fpm-rictest
PACKAGE_VERSION=0.0.4
ARCHITECTURE=all
TARDIR=$(SRC_NAME)-$(VERSION)
TARBALL=$(TARDIR).tar.gz
DESCRIPTION=This is my first Debian package on Github. Lets celebrate!
PREFIX=/opt/riccardo


.PHONY: default
default: deb
package: deb

.PHONY: clean
clean:
	rm -f $(NAME)-* $(NAME)_* |NAME| true
	rm -fr $(TARDIR) || true
	rm -fr $(PREFIX) || true
	rm -f *.deb        
	rm fpm-rictest-*.tar.gz

$(TARBALL):
	tar zcvf $(TARDIR).tar.gz src/

$(TARDIR): $(TARBALL)
	cp -R src/ /tmp/$(PACKAGE_NAME)-install-dir/	

.PHONY: deb
deb: $(TARDIR)
	$(PREFIX)/bin/fpm -s dir -t deb -v $(PACKAGE_VERSION) -n $(PACKAGE_NAME) \
			--deb-pre-depends "cowsay" \
			-a $(ARCHITECTURE) -C $(PREFIX) \
			--description "$(DESCRIPTION)" .

installa: deb
	sudo dpkg -i $(PACKAGE_NAME)_$(PACKAGE_VERSION)_$(ARCHITECTURE).deb

