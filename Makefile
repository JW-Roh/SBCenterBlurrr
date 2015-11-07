ARCHS = armv7 armv7s arm64

PACKAGE_VERSION = 0.0.3

include theos/makefiles/common.mk

TWEAK_NAME = SBCenterBlurrr
SBCenterBlurrr_FILES = Tweak.xm
SBCenterBlurrr_FRAMEWORKS = UIKit
SBCenterBlurrr_LDFLAGS = -Xlinker -unexported_symbol -Xlinker "*"

include $(THEOS_MAKE_PATH)/tweak.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/$(TWEAK_NAME)$(ECHO_END)
	$(ECHO_NOTHING)cp Resources/$(TWEAK_NAME).plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/$(TWEAK_NAME)/$(TWEAK_NAME).plist$(ECHO_END)

after-install::
	install.exec "killall -9 SpringBoard"

FW_DEVICE_IP = 192.168.1.9

ri:: remoteinstall
remoteinstall:: all internal-remoteinstall after-remoteinstall
internal-remoteinstall::
	scp "$(FW_PROJECT_DIR)/${THEOS_OBJ_DIR_NAME}/$(TWEAK_NAME).dylib" root@$(FW_DEVICE_IP):"/Library/MobileSubstrate/DynamicLibraries/"
	scp "$(FW_PROJECT_DIR)/$(TWEAK_NAME).plist" root@$(FW_DEVICE_IP):"/Library/MobileSubstrate/DynamicLibraries/"
after-remoteinstall::
	ssh root@$(FW_DEVICE_IP) "killall -9 backboardd"
