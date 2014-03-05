ARCHS = armv7 armv7s arm64

TARGET = iphone:clang:latest:7.0

THEOS_BUILD_DIR = Packages

include theos/makefiles/common.mk

BUNDLE_NAME = CleverPinFlipswitch
CleverPinFlipswitch_CFLAGS = -fobjc-arc
CleverPinFlipswitch_FILES = CleverPinFlipswitchSwitch.x
CleverPinFlipswitch_FRAMEWORKS = Foundation UIKit
CleverPinFlipswitch_PRIVATE_FRAMEWORKS = GraphicsServices
CleverPinFlipswitch_LDFLAGS = -weak_library libflipswitch.dylib
CleverPinFlipswitch_INSTALL_PATH = /Library/Switches

include $(THEOS_MAKE_PATH)/bundle.mk

after-install::
	install.exec "rm -rf /tmp/FlipswitchCache; killall -9 backboardd"
