PRODUCT_NAME := IdeaMemo
WORKSPACE_NAME := ${PRODUCT_NAME}.xcworkspace

.PHONY: open
open:
	open ./${WORKSPACE_NAME}

.PHONY: setup
setup:
	$(MAKE) install-bundler
	$(MAKE) install-pods
	$(MAKE) install-carthage

############
# Bundler
############
.PHONY: install-bundler
install-bundler:
	bundle config path ./bundle
	bundle install --jobs 4 --retry 3

.PHONY: update-bundler
update-bundler:
	bundle config path ./bundle
	bundle update --jobs 4 --retry 3

############
# CocoaPods
############
.PHONY: install-pods
install-pods:
	bundle exec pod install

.PHONY: update-pods
update-pods:
	bundle exec pod update

############
# Carthage
############
.PHONY: install-carthage
install-carthage:
	bash run-carthage.sh bootstrap --platform iOS --no-use-binaries --cache-builds

.PHONY: update-carthage
update-carthage:
	bash run-carthage.sh update --platform iOS --no-use-binaries --cache-builds

############
# XcodeGen
############
.PHONY: xcodegen
xcodegen:
	xcodegen
	$(MAKE) install-pods
