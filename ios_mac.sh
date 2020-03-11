rm -r build Senna.xcframework
xcodebuild archive -scheme "Senna.iOS" -sdk iphoneos OBJROOT=build/iOS
xcodebuild archive -scheme "Senna.iOS" -sdk iphonesimulator OBJROOT=build/simulator
xcodebuild archive -scheme "Senna.iOS" -destination 'platform=macOS,arch=x86_64,variant=Mac Catalyst'  OBJROOT=build/maccatalyst
xcodebuild -create-xcframework \
-framework build/iOS/UninstalledProducts/iphoneos/Senna.framework \
-framework build/simulator/UninstalledProducts/iphonesimulator/Senna.framework \
-framework build/maccatalyst/UninstalledProducts/macosx/Senna.framework \
-output build/Senna.xcframework
mv build/Senna.xcframework Senna.xcframework