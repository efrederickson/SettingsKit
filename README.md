SettingsKit.framework
==========================
SettingsKit is a framework with the sole goal of simplifying creating a preference bundle.  
You can create a header in 1 line of code, and with another line add a subText to the header!  
Automatically localizable, you don't have to worry about localizations anymore!  
Want a tint? There are MANY available options for adding and modifying tint!  
Publicity? Thats covered too! Simply enable the showHeartImage, change the shareMessage, change the heart image color! (Note: uses Twitter for sharing)   

Even better, you don't have to hassle with preference bundle plist files anymore! You can create your entire preference pane with Objective-C code!  
Using the Objective-C inline Array and Dictionary features, the entire plist can be simplified.  
For example:  

    // tint
    -(UIColor*) tintColor { return [UIColor awesomeColor]; }
    // Settings
    -(NSString*) customTitle { return @"Project"; }
    -(NSArray*) customSpecifiers
    {
        return @[
                 @{
                     @"cell": @"PSGroupCell",
                     @"label": @"Project Settings"
                     },
                 @{
                     @"cell": @"PSSwitchCell",
                     @"default": @YES,
                     @"defaults": @"project.settings",
                     @"key": @"enabled",
                     @"label": @"Enabled",
                     @"PostNotification": @"project/reloadSettings",
                     @"cellClass": @"SKTintedSwitchCell"
                     }
                 ];
    }

Make sure to visit the [wiki](https://github.com/mlnlover11/SettingsKit/wiki) for more information, detailed help and descriptions!
How easy is that?! You can view `SKListControllerProtocol.h` to see all the amazing things you can do with SettingsKit.

SettingsKit includes a THEOS NIC template, so it's super easy to build & create preference bundles with it.  
To install the NIC template for use, simply run `cd NICTemplate && sudo ./build_nic`, then it should show up when you create a project with Theos.

Building:
 - Make sure $THEOS is set up correctly, and you have Xcode as well as the iOS 7.1 SDK.
 - Run `make` - this should build SettingsKit
 - Run `make package install THEOS_DEVICE_IP=XXX.XXX.X.XXX` to install both locally and on your device
 - Run `./install` to install locally for your other projects (make sure to run `make` first!)

Example steps:

    make
    ./install
 
Local installation is important too - view or run the file "install" to see what it does. It installs the SettingsKit.framework to Theos (imporant for the NIC and other projects using SettingsKit) and installs the headers. You may need to run it as root (using `sudo ./install` or `su root -c ./install`)

----------------------------------------------------------------

License under the BSD license. Do as you wish.

----------------------------------------------------------------
