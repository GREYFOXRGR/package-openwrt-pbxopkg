include $(TOPDIR)/rules.mk

PKG_NAME:=pbxopkg
PKG_VERSION:=0.0.5
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/pbxopkg
  SECTION:=utils
  CATEGORY:=Network
  TITLE:=PirateBox-pbxopkg
  SUBMENU:=PirateBox
  URL:=http://piratebox.aod-rpg.de
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
	[ -f "$IPKG_INSTROOT/etc/opkg.conf" ] &&
	  grep '[ \t]*src/gz[ \t]*piratebox[ \t]*' "$IPKG_INSTROOT/etc/opkg.conf" > /dev/null &&
	  exit 0

	echo "src/gz piratebox http://stable.openwrt.piratebox.de/all/packages" >> "$IPKG_INSTROOT/etc/opkg.conf"
endef

define Package/pbxopkg/preinst
endef

define Package/pbxopkg/prerm
	#!/bin/sh
	sed 's|src/gz piratebox|#src/gz piratebox|'  -i /etc/opkg.conf
endef 

define Build/Compile
endef

define Build/Configure
endef

define Package/pbxopkg/install
# This is not allowed to be empty otherwise no ipk will be generated.
endef

$(eval $(call BuildPackage,pbxopkg))
