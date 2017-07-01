# iOS Bluetooth-LE Debugger

**UPDATE (2017):** As of this year Apple has completely overhauled how iOS interacts with apps involving bluetooth LE capabilities. There has been large changes to the permission system and this app will no longer run on a device "out of the box" by just compiling it. The operations and states that BLE use should still be valid, however in order for the app to run code will need to be implemented that makes the proper system calls in order to get user permission and usage of the wireless capabilities


## What is this?

The iOS Bluetooth-LE Debugger is an app I developed that will allow users to explore the different Bluetooth Low Energy devices and signals around them, as well as the data (if public) they broadcast. 

This app is capable of acting as both the Central and Peripheral (Master and Slave) in the BLE communication.

As of 4/27/17 Apples documentation on accessing the BLE components of iOS devices has not been updated to reflect changes that came along with Swift 1/2. Please feel free to pick apart the code and learn different methods of utilizing BLE using the Swift programming language.

## How do you compile this?

This was created in Xcode 7.3.1, Build version 7D1014, on a Mac-Book Pro running OS X El Captain Version 10.11.5 using Swift 2. To compile it open the “Bluetooth Debugger.xcodeproj” file and the project should be ready to compile and run without any outside dependencies.


**PLEASE NOTE:** Because the BLE features are not present on the iOS Device Simulator this must be run on a physical device, otherwise it will not function. To run it on a device you must have a valid signing certificate and developer account. Please see apples [documentation](https://developer.apple.com/library/content/documentation/IDEs/Conceptual/AppDistributionGuide/TestingYouriOSApp/TestingYouriOSApp.html) on the subject. 


