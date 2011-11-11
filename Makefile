NAME=provaric
VERSION=1.2.3-p456
ARCHITECTURE=all
TARDIR=$(NAME)-$(VERSION)
TARBALL=$(TARDIR).tar.gz
DESCRIPTION=This is my first Debian package on Github. Lets celebrate!
PREFIX=/opt/riccardo

PACKAGE_NAME=fpm-rictest
PACKAGE_VERSION=0.0.1

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
	$(PREFIX)/bin/fpm -s dir -t deb -v $(PACKAGE_VERSION) -n $(PACKAGE_NAME) -a $(ARCHITECTURE) -C $(PREFIX) --description "$(DESCRIPTION)" .

installa: deb
	sudo dpkg -i $(PACKAGE_NAME)_$(PACKAGE_VERSION)_$(ARCHITECTURE).deb

