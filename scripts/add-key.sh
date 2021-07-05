security create-keychain -p travis ios-build.keychain
security default-keychain -s ios-build.keychain

security unlock-keychain -p travis ios-build.keychain
security set-keychain-settings -t 3600 -l ~/Library/Keychains/ios-build.keychain

security import ./scripts/apple.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import ./scripts/dis.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import ./scripts/dis.p12 -f pkcs12 -k ~/Library/Keychains/ios-build.keychain -P "0728" -T /usr/bin/codesign

security set-key-partition-list -S apple-tool:,apple: -s -k travis ios-build.keychain

security find-identity -p codesigning ~/Library/Keychains/ios-build.keychain
security list-keychains

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
cp "./profile/tap_adc.mobileprovision" ~/Library/MobileDevice/Provisioning\ Profiles