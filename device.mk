PRODUCT_COPY_FILES += \
	device/lge/iproj/configs/media_profiles.xml:system/etc/media_profiles.xml \
	device/lge/iproj/configs/media_codecs.xml:system/etc/media_codecs.xml

$(call inherit-product, build/target/product/full.mk)

$(call inherit-product, build/target/product/languages_small.mk)
$(call inherit-product, vendor/cm/config/common.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

PRODUCT_AAPT_CONFIG := normal hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

DEVICE_PACKAGE_OVERLAYS += device/lge/iproj/overlay

PRODUCT_TAGS += dalvik.gc.type-precise
$(call inherit-product, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)

# Publish that we support the live wallpaper feature.
PRODUCT_COPY_FILES += \
	packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:/system/etc/permissions/android.software.live_wallpaper.xml

# Permission files
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
	frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
	frameworks/native/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
	frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
	frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
	frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml


PRODUCT_COPY_FILES += \
	device/lge/iproj/configs/audio_policy.conf:system/vendor/etc/audio_policy.conf

# WiFi
PRODUCT_COPY_FILES += \
	device/lge/iproj/configs/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf 

# QCOM post boot stuff
PRODUCT_COPY_FILES += \
	device/lge/iproj/prebuilt/init.qcom.post_boot.sh:system/etc/init.qcom.post_boot.sh \
	device/lge/iproj/prebuilt/init.qcom.modem_links.sh:system/etc/init.qcom.modem_links.sh \
	device/lge/iproj/prebuilt/init.qcom.mdm_links.sh:system/etc/init.qcom.mdm_links.sh

# Configs
PRODUCT_COPY_FILES += \
	device/lge/iproj/configs/vold.fstab:system/etc/vold.fstab \
	device/lge/iproj/configs/atcmd_virtual_kbd.kl:system/usr/keylayout/atcmd_virtual_kbd.kl \
	device/lge/iproj/configs/ffa-keypad_qwerty.kl:system/usr/keylayout/ffa-keypad_qwerty.kl \
	device/lge/iproj/configs/i_atnt-keypad.kl:system/usr/keylayout/i_atnt-keypad.kl \
	device/lge/iproj/configs/pmic8058_pwrkey.kl:system/usr/keylayout/pmic8058_pwrkey.kl \
	device/lge/iproj/configs/touch_dev.kl:system/usr/keylayout/touch_dev.kl \
	device/lge/iproj/configs/touch_dev.idc:system/usr/idc/touch_dev.idc \
	device/lge/iproj/configs/thermald.conf:system/etc/thermald.conf

ifeq ($(TARGET_PRODUCT),cm_iproj) # XXX

$(call inherit-product-if-exists, vendor/lge/iproj/iproj-vendor.mk)

# Bluetooth
PRODUCT_COPY_FILES += \
	device/lge/iproj/prebuilt/init.qcom.bt.sh:system/bin/init.qcom.bt.sh

PRODUCT_COPY_FILES += \
	device/lge/iproj/prebuilt/root/init.iproj.rc:root/init.iproj.rc \
	device/lge/iproj/prebuilt/root/init.iproj.usb.rc:root/init.iproj.usb.rc \
	device/lge/iproj/prebuilt/root/init.qcom.sh:root/init.qcom.sh \
	device/lge/iproj/prebuilt/root/ueventd.iproj.rc:root/ueventd.iproj.rc

endif # TARGET_PRODUCT == cm_iproj

# HW HALS
PRODUCT_PACKAGES += \
	hdmid \
	libgenlock \
	libmemalloc \
	liboverlay \
	gralloc.msm8660 \
	hwcomposer.msm8660 \
	copybit.msm8660 \
	lights.msm8660 \
	gps.msm8660 \
	audio.primary.msm8660 \
	audio_policy.msm8660 \
	audio_policy.conf \
	audio.a2dp.default \
	power.msm8660 \
	com.android.future.usb.accessory

# OMX
PRODUCT_PACKAGES += \
	libstagefrighthw \
	libdivxdrmdecrypt \
	libOmxVdec \
	libOmxVenc \
	libOmxAacEnc \
	libOmxAmrEnc \
	libmm-omxcore \
	libOmxCore

PRODUCT_PACKAGES += \
	hcitool \
	hciconfig \
	hwaddrs

PRODUCT_PACKAGES += \
	Torch \
	WiFiDirectDemo

# Charger mode
PRODUCT_PACKAGES += \
	charger \
	charger_res_images

PRODUCT_PROPERTY_OVERRIDES += \
	ro.com.google.locationfeatures=1 \
	ro.com.google.clientidbase=android-lge \
	ro.com.google.clientidbase.gmm=android-lge \
	gsm.operator.iso-country=us
