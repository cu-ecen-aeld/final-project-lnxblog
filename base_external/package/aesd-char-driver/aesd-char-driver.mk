
##############################################################
#
# AESDCHAR
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
AESD_CHAR_DRIVER_VERSION = '613f3c7b0b0971bf2dceffb8d32a950598cffa22'
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
AESD_CHAR_DRIVER_SITE = 'git@github.com:cu-ecen-aeld/assignments-3-and-later-lnxblog.git'
AESD_CHAR_DRIVER_SITE_METHOD = git
AESD_CHAR_DRIVER_GIT_SUBMODULES = YES

#define AESD_ASSIGNMENTS_BUILD_CMDS
#	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server all
#endef
AESD_CHAR_DRIVER_MODULE_SUBDIRS = aesd-char-driver/

#define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
#	$(INSTALL) -m 0755 $(@D)/misc_modules/aesdsocket-start-stop $(TARGET_DIR)/etc/init.d/S99aesdsocket
#	$(INSTALL) -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin
	
#endef

$(eval $(kernel-module))
$(eval $(generic-package))
