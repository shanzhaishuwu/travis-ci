#!/bin/sh
security delete-keychain ~/Library/Keychains/ios-build.keychain
security find-identity -p codesigning ~/Library/Keychains/ios-build.keychain
security list-keychains