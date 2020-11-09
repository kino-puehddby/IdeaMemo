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
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios install_lib
```
fastlane ios install_lib
```

### ios test
```
fastlane ios test
```
Runs all tests
### ios build_for_develop
```
fastlane ios build_for_develop
```
Generate ipa for develop
### ios build_for_staging
```
fastlane ios build_for_staging
```
Generate ipa for staging
### ios build_for_production
```
fastlane ios build_for_production
```
Generate ipa for production

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
