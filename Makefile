ARCHS = armv7 armv7s arm64
TARGET = iphone:clang:7.1:7.1
CFLAGS = -fobjc-arc
THEOS_PACKAGE_DIR_NAME = debs

include $(THEOS)/makefiles/common.mk

FRAMEWORK_NAME = SettingsKit
SettingsKit_FILES = SKTintedControlCell.m \
		    SKTintedCell.m \
		    SKTintedSwitchCell.m \
		    SKTintedListController.m \
		    SKSharedHelper.m \
		    SKSpecifierParser.m \
		    SKPersonCell.m

SettingsKit_PRIVATE_FRAMEWORKS = Preferences
SettingsKit_INSTALL_PATH = /Library/Frameworks
SettingsKit_FRAMEWORKS = UIKit Social CoreGraphics

include $(THEOS_MAKE_PATH)/framework.mk


after-install::
	install.exec "killall -9 Preferences"
	./install
