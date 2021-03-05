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
### ios build
```
fastlane ios build
```
Build for Scheme
### ios sync_xcode_signing_for_CI
```
fastlane ios sync_xcode_signing_for_CI
```
sync xcode signing for CI
### ios sync_xcode_signing
```
fastlane ios sync_xcode_signing
```
sync xcode signing
### ios deploy_to_testflight
```
fastlane ios deploy_to_testflight
```
deploy to TestFlight
### ios refresh_dsyms
```
fastlane ios refresh_dsyms
```
Download & Upload dSYMs to Firebase Clashlytics

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
