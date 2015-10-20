ARCHS = armv7 armv7s arm64
include theos/makefiles/common.mk

TWEAK_NAME = RingTone4All
RingTone4All_FILES = Tweak.xmi
RingTone4All_FRAMEWORKS = UIKit AVFoundation CoreMedia
RingTone4All_PRIVATE_FRAMEWORKS = ToneLibrary AppSupport
RingTone4All_LIBRARIES = substrate rocketbootstrap 

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
after-install::
	install.exec "killall -9 SpringBoard"
