################################################################################
#
# python-kivy
#
################################################################################

PYTHON_KIVY_VERSION = 1.10.1
PYTHON_KIVY_SITE = $(call github,kivy,kivy,$(PYTHON_KIVY_VERSION))
PYTHON_KIVY_SETUP_TYPE = distutils
PYTHON_KIVY_LICENSE = MIT
PYTHON_KIVY_LICENSE_FILES = LICENSE
PYTHON_KIVY_DEPENDENCIES = host-python-cython # libgl

PYTHON_KIVY_ENV += USE_RPI=1

#ifeq ($(BR2_PACKAGE_GSTREAMER),y)
#PYTHON_KIVY_DEPENDENCIES += gstreamer
#PYTHON_KIVY_ENV += USE_GSTREAMER=1
#endif

#ifeq ($(BR2_PACKAGE_HAS_LIBEGL),y)
#PYTHON_KIVY_DEPENDENCIES += libegl
#PYTHON_KIVY_ENV += USE_EGL=1
#endif

#ifeq ($(BR2_PACKAGE_SDL2)$(BR2_PACKAGE_SDL2_X11)$(BR2_PACKAGE_SDL2_IMAGE)$(BR2_PACKAGE_SDL2_MIXER)$(BR2_PACKAGE_SDL2_TTF),yyyyy)
ifeq ($(BR2_PACKAGE_SDL2)$(BR2_PACKAGE_SDL2_IMAGE)$(BR2_PACKAGE_SDL2_MIXER)$(BR2_PACKAGE_SDL2_TTF),yyyy)
PYTHON_KIVY_DEPENDENCIES += sdl2 sdl2_image sdl2_mixer sdl2_ttf
PYTHON_KIVY_ENV += USE_SDL2=1
PYTHON_KIVY_ENV += KIVY_SDL2_PATH=$(STAGING_DIR)/usr/include/SDL2
else
PYTHON_KIVY_ENV += USE_SDL2=0
endif

#ifeq ($(BR2_PACKAGE_WAYLAND),y)
#PYTHON_KIVY_DEPENDENCIES += wayland
#PYTHON_KIVY_ENV += USE_WAYLAND=1
#endif

#ifeq ($(BR2_PACKAGE_XSERVER_XORG_SERVER),y)
#PYTHON_KIVY_DEPENDENCIES += xserver_xorg-server
#PYTHON_KIVY_ENV += USE_X11=1
#endif

define PYTHON_KIVY_REMOVE_EXAMPLES
	rm -rf $(TARGET_DIR)/usr/share/kivy-examples
endef

PYTHON_KIVY_POST_INSTALL_TARGET_HOOKS += PYTHON_KIVY_REMOVE_EXAMPLES

$(eval $(python-package))
