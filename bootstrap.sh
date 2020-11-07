# setup Carthage variables ( for Xcode 12.x )
# bootstrap Carthage Libraries ( from Cartfile.resolved )
sh setup-carthage.sh bootstrap --platform iOS --no-use-binaries

# bootstrap CocoaPods Libraries ( from Podfile.lock )
pod install
