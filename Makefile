ARCHS := arm64
PACKAGE_FORMAT := ipa
TARGET := iphone:clang:latest:15.0

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = MySystemShell

MySystemShell_FILES = \
  AppDelegate.m SceneDelegate.m ViewController.m main.m
MySystemShell_FRAMEWORKS = UIKit
MySystemShell_PRIVATE_FRAMEWORKS = FrontBoard
MySystemShell_CFLAGS = -fcommon -fobjc-arc -Ifun -I. -Wno-error
# MySystemShell_LDFLAGS =
MySystemShell_CODESIGN_FLAGS = -Sentitlements.xml

include $(THEOS_MAKE_PATH)/application.mk
