#!/bin/sh
# Create a custom keychain
security create-keychain -p travis ios-build.keychain
security default-keychain -d user -s ios-build.keychain
security unlock-keychain -p travis ios-build.keychain
security set-keychain-settings -t 3600 -l ~/Library/Keychains/ios-build.keychain

security import profile/ios_distribution_zhenghao.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import profile/dis.p12 -k ~/Library/Keychains/ios-build.keychain -P $KEY_PASSWORD -A

echo "list keychains: "
security list-keychains
echo " ****** "

echo "find indentities keychains: "
security find-identity -p codesigning  ~/Library/Keychains/ios-build.keychain
echo " ****** "

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
cp "profile/tapnow_adc.mobileprovision" ~/Library/MobileDevice/Provisioning\ Profiles/