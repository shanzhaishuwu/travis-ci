#!/bin/sh
xcrun xcodebuild -project travis.xcodeproj -scheme travis \
  -archivePath travis.xcarchive archive

xcrun xcodebuild -exportArchive -archivePath travis.xcarchive \
  -exportPath ./build -exportOptionsPlist ExportOptions.plist