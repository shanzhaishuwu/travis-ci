#!/bin/sh

# Create a custom keychain
security create-keychain -p travis ios-build.keychain

# Make the custom keychain default, so xcodebuild will use it for signing
security default-keychain -s ios-build.keychain

# Unlock the keychain
security unlock-keychain -p travis ios-build.keychain

# Set keychain timeout to 1 hour for long builds
# see http://www.egeek.me/2013/02/23/jenkins-and-xcode-user-interaction-is-not-allowed/
security set-keychain-settings -t 3600 -l ~/Library/Keychains/ios-build.keychain

# Add certificates to keychain and allow codesign to access them
security import ./profile/apple.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import ./profile/dis.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import ./profile/dis.p12 -k ~/Library/Keychains/ios-build.keychain -P "0728" -T /usr/bin/codesign

security set-key-partition-list -S apple-tool:,apple: -s -k travis ios-build.keychain

security find-identity -p codesigning ~/Library/Keychains/ios-build.keychain
security list-keychains

# Put the provisioning profile in place
mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
cp "./profile/tap_adc.mobileprovision" ~/Library/MobileDevice/Provisioning\ Profiles/



security create-keychain -p travis ios-build.keychain
security default-keychain -s ios-build.keychain

security unlock-keychain -p travis ios-build.keychain
security set-keychain-settings -t 3600 -l ~/Library/Keychains/ios-build.keychain

security import ./scripts/apple.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import ./scripts/dis.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import ./scripts/dis.p12 -f pkcs12 -k ~/Library/Keychains/ios-build.keychain -P $KEY_PASSWORD -T /usr/bin/codesign

security set-key-partition-list -S apple-tool:,apple: -s -k travis ios-build.keychain

security find-identity -p codesigning ~/Library/Keychains/ios-build.keychain
security list-keychains

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
cp ./scripts/profile/tap_adc.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles