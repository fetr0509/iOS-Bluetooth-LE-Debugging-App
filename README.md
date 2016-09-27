## iOS-Bluetooth-LE-Debugging-App

#What is this?

The yet-to-be-named “iOS-Bluetooth-LE-Debugging-App” is an app I am in the process of developing that will allow users to explore the different Bluetooth Low Energy devices and signals around them, as well as the data they broadcast. 

As of 9/27/16 Apples documentation on accessing the BLE components of iOS devices has not been updated to reflect changes that came along with Swift 1/2. Please feel free to pick apart the code and learn different methods of utilizing BLE and the Swift programming language.

#How do you compile this?

This was created in Xcode 7.3.1, Build version 7D1014, on a MacBook Pro running OS X El Captain Version 10.11.5 using Swift 2. To compile it open the “Bluetooth Debugger.xcodeproj” file and the project should be ready to compile and run without any outside dependencies.

**PLEASE NOTE:** Because the BLE features are not present on the iOS Device Simulator this must be run on a physical device, otherwise it will not function. To run it on a device you must have a valid signing certificate and developer account. Please see apples[documentation](https://developer.apple.com/library/content/documentation/IDEs/Conceptual/AppDistributionGuide/TestingYouriOSApp/TestingYouriOSApp.html) on the subject. 

