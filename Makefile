#NAME=ruby
#VERSION=1.9.2-p180
NAME=provaric
VERSION=1.2.3-p456
#MAJOR_VERSION=1.9
#ARCHITECTURE=x86
#ARCHITECTURE=amd64
ARCHITECTURE=all
TARDIR=$(NAME)-$(VERSION)
TARBALL=$(TARDIR).tar.gz
#DOWNLOAD=http://ftp.ruby-lang.org/pub/ruby/$(MAJOR_VERSION)/$(TARBALL)
DESCRIPTION=Test description for Piotr and Riccardo LDAP package. Its amazing
PREFIX=/opt/riccardo

PACKAGE_NAME=ldap-ric-piotr
PACKAGE_VERSION=0.0.50

.PHONY: default
default: deb
package: deb

.PHONY: clean
clean:
	rm -f $(NAME)-* $(NAME)_* |NAME| true
	rm -fr $(TARDIR) || true
	rm -fr $(PREFIX) || true
	rm -f *.deb        
	rm ldap-ric-piotr-*.tar.gz

$(TARBALL):
	tar zcvf $(TARDIR).tar.gz src/

$(TARDIR): $(TARBALL)
	cp -R src/ /tmp/$(PACKAGE_NAME)-install-dir/	
	#tar zxvf $(TARDIR).tar.gz src/
	#tar -zxf $(TARBALL)
	#cd $(TARDIR); ./configure --enable-shared=false --prefix=$(PREFIX); make; make install
	#$(PREFIX)/bin/gem install fpm

.PHONY: deb
deb: $(TARDIR)
	$(PREFIX)/bin/fpm -s dir -t deb -v $(PACKAGE_VERSION) -n $(PACKAGE_NAME) -a $(ARCHITECTURE) -C $(PREFIX) --description "$(DESCRIPTION)" .

installa: deb
	sudo dpkg -i $(PACKAGE_NAME)_$(PACKAGE_VERSION)_$(ARCHITECTURE).deb

