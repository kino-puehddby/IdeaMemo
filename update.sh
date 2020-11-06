# setup Carthage variables ( for Xcode 12.x )
# update Carthage Libraries ( from Cartfile )
sh setup-carthage.sh update --platform iOS --no-use-binaries

# update CocoaPods Libraries ( from Podfile )
pod update
