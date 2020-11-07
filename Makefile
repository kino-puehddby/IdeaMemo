PRODUCT_NAME := IdeaMemo
WORKSPACE_NAME := ${PRODUCT_NAME}.xcworkspace

.PHONY: open
open: # Open workspace in Xcode
	open ./${WORKSPACE_NAME}

.PHONY: setup
setup: # Install dependencies and prepared development configuration
	$(MAKE) install-bundler
	$(MAKE) install-pods
	$(MAKE) install-carthage

.PHONY: install-bundler
install-bundler: # Install Bundler dependencies
	bundle config path ./bundle
	bundle install --jobs 4 --retry 3

.PHONY: update-bundler
update-bundler: # Update Bundler dependencies
	bundle config path ./bundle
	bundle update --jobs 4 --retry 3

.PHONY: install-mint
install-mint: # Install Mint dependencies
	mint bootstrap

.PHONY: install-pods
install-pods: # Install CocoaPods dependencies and generate workspace
	bundle exec pod install

.PHONY: update-pods
update-pods: # Update CocoaPods dependencies and generate workspace
	bundle exec pod update

.PHONY: install-carthage
install-carthage: # Install Carthage dependencies
	bash run-carthage.sh bootstrap --platform iOS --no-use-binaries --cache-builds

.PHONY: generate-proj
generate-proj:
	xcodegen
	$(MAKE) install-pods
