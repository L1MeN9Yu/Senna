rm -r build
xcodebuild archive -scheme "Senna.iOS" -sdk iphoneos OBJROOT=build/iOS
xcodebuild archive -scheme "Senna.iOS" -sdk iphonesimulator OBJROOT=build/simulator
xcodebuild -create-xcframework -framework build/iOS/UninstalledProducts/iphoneos/Senna.framework -framework build/simulator/UninstalledProducts/iphonesimulator/Senna.framework -output build/Senna.xcframework
mv build/Senna.xcframework Senna.xcframework