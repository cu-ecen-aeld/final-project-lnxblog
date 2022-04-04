
##############################################################
#
# LDD-AESD
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
LDD_VERSION = 'e4b14f16e6f8c06ce39a6ad800c22d6c9df2ca88'
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
LDD_SITE = 'git@github.com:cu-ecen-aeld/assignment-7-lnxblog.git'
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES

#define AESD_ASSIGNMENTS_BUILD_CMDS
#	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server all
#endef
LDD_MODULE_SUBDIRS = misc-modules/ scull/

#define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
#	$(INSTALL) -m 0755 $(@D)/misc_modules/aesdsocket-start-stop $(TARGET_DIR)/etc/init.d/S99aesdsocket
#	$(INSTALL) -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin
	
#endef

$(eval $(kernel-module))
$(eval $(generic-package))
