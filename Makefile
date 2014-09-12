include $(TOPDIR)/rules.mk

PKG_NAME:=pbxopkg
PKG_VERSION:=0.1.0
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/pbxopkg
  SECTION:=utils
  CATEGORY:=Network
  TITLE:=Repository-Integration
  SUBMENU:=PirateBox
  URL:=http://piratebox.cc
  DEPENDS:= 
  PKGARCH:=all
  MAINTAINER:=Matthias Strubel <matthias.strubel@aod-rpg.de>
endef

define Package/pbxopkg/description
	Adds PirateBox OpenWRT Package-Tree to opkg.conf
endef

define Package/pbxopkg/postinst
	#!/bin/sh
	# . /etc/openwrt_release
	# echo "src/gz piratebox http://stable.openwrt.piratebox.de/$DISTRIB_TARGET/packages" >> /etc/opkg.conf
	if [ -e "/etc/opkg.conf" ]; then
		if grep '[ \t]*src/gz[ \t]*piratebox[ \t]*' "/etc/opkg.conf"; then
			exit 0
		else
			echo "src/gz piratebox http://stable.openwrt.piratebox.de/all/packages" >> "/etc/opkg.conf"
		fi
	fi
endef

define Package/pbxopkg/preinst
endef

define Package/pbxopkg/prerm
	#!/bin/sh
	sed -i '/src\/gz piratebox.*/d' /etc/opkg.conf
endef 

define Build/Compile
endef

define Build/Configure
endef

define Package/pbxopkg/install
# This is not allowed to be empty otherwise no ipk will be generated.
endef

$(eval $(call BuildPackage,pbxopkg))
