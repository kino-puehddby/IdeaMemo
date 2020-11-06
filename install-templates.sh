#!/bin/bash

XCODE_PATH="/Applications/Xcode.app"
echo "Xcode app path: $XCODE_PATH"
sudo cp -r -f ./custom-templates/* $XCODE_PATH/Contents/Developer/Library/Xcode/Templates/File\ Templates
echo "Done!"
