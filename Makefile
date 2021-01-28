PRODUCT_NAME := IdeaMemo
PROJECT_NAME := ${PRODUCT_NAME}.xcodeproj
WORKSPACE_NAME := ${PRODUCT_NAME}.xcworkspace
SCHEME_NAME := ${PRODUCT_NAME}
UI_TESTS_TARGET_NAME := ${PRODUCT_NAME}UITests

TEST_SDK := iphonesimulator
TEST_CONFIGURATION := Debug
TEST_PLATFORM := iOS Simulator
TEST_DEVICE ?= iPhone 12
TEST_OS ?= 14.3
TEST_DESTINATION := 'platform=${TEST_PLATFORM},name=${TEST_DEVICE},OS=${TEST_OS}'

XCODEBUILD_BUILD_LOG_NAME := xcodebuild_build.log
XCODEBUILD_TEST_LOG_NAME := xcodebuild_test.log

.PHONY: open
open:
	open ./${WORKSPACE_NAME}

.PHONY: setup
setup:
	bundle config set path ./bundle
	$(MAKE) install-bundler
	$(MAKE) install-pods
	$(MAKE) install-carthage

############
# Bundler
############
.PHONY: install-bundler
install-bundler:
	bundle install --jobs 4 --retry 3

.PHONY: update-bundler
update-bundler:
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
	bundle exec fastlane ios sync_xcode_signing

############
# Fastlane Match
############
.PHONY: match
match:
	bundle exec fastlane match development
	bundle exec fastlane match adhoc
	bundle exec fastlane match appstore

############
# Xcode
############

.PHONY: build-debug
build-debug: # Xcode build for debug
	set -o pipefail \
&& xcodebuild \
-sdk ${TEST_SDK} \
-configuration ${TEST_CONFIGURATION} \
-workspace ${WORKSPACE_NAME} \
-scheme ${SCHEME_NAME} \
-destination ${TEST_DESTINATION} \
build \
| tee ./${XCODEBUILD_BUILD_LOG_NAME} \
| bundle exec xcpretty --color
