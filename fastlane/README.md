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
### ios increment_build_number_push
```
fastlane ios increment_build_number_push
```
increment build number
### ios increment_version_number_push
```
fastlane ios increment_version_number_push
```
increment version number

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
