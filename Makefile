




FINALPACKAGE = 0
DEBUG = 0
PACKAGE_VERSION = 1.1-0





ifeq ($(DEBUG), 1)
    ARCHS = arm64
else
    ARCHS = armv7 armv7s arm64
endif
TARGET = iphone:clang:latest:8.0





LIBRARY_NAME = libsw
libsw_CFLAGS = -fobjc-arc
libsw_LDFLAGS += -F$(THEOS)/lib/
libsw_FILES = \
                SWAppLauncher.xm \
                SWPSListController.mm \
                SWPSListControllerHeaderView.mm \
                SWPSTwitterCell.m \
                SWSuperiorWindow.m
libsw_FRAMEWORKS = CoreFoundation Foundation UIKit Social
libsw_PRIVATE_FRAMEWORKS = Preferences
libsw_WEAK_FRAMEWORKS = Sluthware
libsw_LIBRARIES = substrate packageinfo

ADDITIONAL_CFLAGS = -Ilibsw





include theos/makefiles/common.mk
include theos/makefiles/library.mk
include theos/makefiles/swcommon.mk





clean::
	rm -rf $(THEOS)/include/libsw
	rm -rf $(THEOS)/lib/libsw.dylib





INCLUDE_DIR = $(THEOS_STAGING_DIR)/usr/include
FRAMEWORKS_DIR = $(THEOS_STAGING_DIR)/Library/Frameworks

stage::
	$(ECHO_NOTHING) mkdir -p $(INCLUDE_DIR) $(ECHO_END)
	$(ECHO_NOTHING) mkdir -p $(FRAMEWORKS_DIR) $(ECHO_END)
	$(ECHO_NOTHING) cp -r libsw $(INCLUDE_DIR) $(ECHO_END)
	$(ECHO_NOTHING) cp -r libsw $(THEOS)/include $(ECHO_END)
	$(ECHO_NOTHING) cp $(THEOS_STAGING_DIR)/usr/lib/libsw.dylib $(THEOS)/lib $(ECHO_END)
	$(ECHO_NOTHING)	cp -a $(THEOS)/lib/Sluthware.framework $(THEOS_STAGING_DIR)/Library/Frameworks/Sluthware.framework$(ECHO_END)




