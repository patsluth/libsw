




export FINALPACKAGE = 1
PACKAGE_VERSION = 1.1-7





ifeq ($(FINALPACKAGE), 0)
    ARCHS = arm64
else
    ARCHS = armv7 armv7s arm64
endif
TARGET = iphone:clang:latest:8.0





LIBRARY_NAME = libsw2
libsw2_CFLAGS = -fobjc-arc
libsw2_LDFLAGS += -F$(THEOS)/lib/
libsw2_FILES = \
                SWApplicationLauncher.xm \
				SWControlCenterHelper.xm \
                SWPSListController.mm \
                SWPSListControllerHeaderView.mm \
                SWPSTwitterCell.m \
                SWSuperiorWindow.m
libsw2_FRAMEWORKS = CoreFoundation Foundation UIKit Social
libsw2_PRIVATE_FRAMEWORKS = Preferences
libsw2_WEAK_FRAMEWORKS = Sluthware
libsw2_LIBRARIES = substrate packageinfo

ADDITIONAL_CFLAGS = -Ilibsw2





include $(THEOS)/makefiles/common.mk
include $(THEOS)/makefiles/library.mk
include $(THEOS)/makefiles/swcommon.mk





clean::
	rm -rf $(THEOS)/include/libsw2
	rm -rf $(THEOS)/lib/libsw2.dylib





INCLUDE_DIR = $(THEOS_STAGING_DIR)/usr/include
FRAMEWORKS_DIR = $(THEOS_STAGING_DIR)/Library/Frameworks

stage::
	$(ECHO_NOTHING) mkdir -p $(INCLUDE_DIR) $(ECHO_END)
	$(ECHO_NOTHING) mkdir -p $(FRAMEWORKS_DIR) $(ECHO_END)
	$(ECHO_NOTHING) cp -r libsw2 $(INCLUDE_DIR) $(ECHO_END)
	$(ECHO_NOTHING) cp -r libsw2 $(THEOS)/include $(ECHO_END)
	$(ECHO_NOTHING) cp $(THEOS_STAGING_DIR)/usr/lib/libsw2.dylib $(THEOS)/lib $(ECHO_END)
	$(ECHO_NOTHING)	cp -a $(THEOS)/lib/Sluthware.framework $(THEOS_STAGING_DIR)/Library/Frameworks/Sluthware.framework$(ECHO_END)




