# Release name
PRODUCT_RELEASE_NAME := Iproj

## Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/gsm.mk)

TARGET_BOOTANIMATION_NAME := vertical-720x1280

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/lge/iproj/full_iproj.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := iproj
PRODUCT_NAME := cm_iproj
PRODUCT_BRAND := Android
PRODUCT_MODEL := LG-IPROJ
PRODUCT_MANUFACTURER := LGE
PRODUCT_CHARACTERISTICS := phone
