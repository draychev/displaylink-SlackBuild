#!make

.PHONY: install-linter
install-linter:
	sudo sbopkg -i sbo-maintainer-tools

.PHONY: lint
lint: build-package
	@echo -e "\n\n>>> Running sbolint"
	/usr/bin/sbolint ./displaylink
	@echo -e "\n\n>>> Running sbopkglint"
	/usr/bin/sbopkglint ./displaylink.tgz

.PHONY: build-package
build-package: clean
	cp -R ./displaylink ./install
	tar -czf displaylink.tgz ./install
	rm -rf ./install


.PHONY: install
install: build-package
	sudo bash ./displaylink/displaylink.SlackBuild
	sudo /sbin/installpkg /tmp/displaylink-5.7.0-61.129-x86_64-1_SBo.tgz


.PHONY: prep-for-submission
prep-for-submission: lint
	tar -czf displaylink_1.40.0.tgz displaylink/
	ls -lah displaylink_1.40.0.tgz


.PHONY: clean
clean:
	rm -rf *.tar.gz *.tgz
