fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## iOS
### ios test
```
fastlane ios test
```
Runs all tests
### ios build
```
fastlane ios build
```
Build for Scheme
### ios setup_cirtificates
```
fastlane ios setup_cirtificates
```
setup cirtificates
### ios sync_xcode_signing
```
fastlane ios sync_xcode_signing
```
sync xcode signing
### ios beta
```
fastlane ios beta
```
deploy to TestFlight
### ios release
```
fastlane ios release
```
deploy to app store connect

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
