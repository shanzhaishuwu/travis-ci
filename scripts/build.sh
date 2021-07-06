#!/bin/sh
xcrun xcodebuild -workspace travis.xcworkspace -scheme travis -configuration Release clean

xcrun xcodebuild archive -workspace travis.xcworkspace -scheme travis -archivePath travis.xcarchive -configuration Release -destination generic/platform=iOS

xcrun xcodebuild -exportArchive -archivePath travis.xcarchive -exportOptionsPlist ExportOptions.plist -exportPath output