ifeq ($(TARGET_PRODUCT),cm_iproj) # XXX
include vendor/lge/iproj/BoardConfigVendor.mk
endif

USE_CAMERA_STUB := true

# Platform
TARGET_BOARD_PLATFORM := msm8660
TARGET_BOARD_PLATFORM_GPU := qcom-adreno200
TARGET_BOOTLOADER_BOARD_NAME := iproj
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
ARCH_ARM_HAVE_TLS_REGISTER := true
TARGET_CPU_SMP := true

TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true
TARGET_GLOBAL_CFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_USE_SCORPION_BIONIC_OPTIMIZATION := true
TARGET_USE_SCORPION_PLD_SET := true
TARGET_SCORPION_BIONIC_PLDOFFS := 6
TARGET_SCORPION_BIONIC_PLDSIZE := 128

BOARD_FLASH_BLOCK_SIZE := 131072

COMMON_GLOBAL_CFLAGS += -DQCOM_HARDWARE

TARGET_SPECIFIC_HEADER_PATH := device/lge/iproj/include

# Egl
USE_OPENGL_RENDERER := true
BOARD_EGL_CFG := device/lge/iproj/configs/egl.cfg

# QCOM stuff
BOARD_USES_QCOM_HARDWARE := true
TARGET_USES_C2D_COMPOSITION := true
TARGET_FORCE_CPU_UPLOAD := true
BOARD_USES_QCOM_LIBS := true
TARGET_USES_ION := true

# Wifi
BOARD_WPA_SUPPLICANT_DRIVER	:= NL80211
WPA_SUPPLICANT_VERSION		:= VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER		:= NL80211
BOARD_HOSTAPD_PRIVATE_LIB	:= lib_driver_cmd_bcmdhd
BOARD_WLAN_DEVICE		:= bcmdhd
WIFI_DRIVER_FW_PATH_PARAM	:= "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA		:= "/system/etc/firmware/fw_bcmdhd_p2p.bin"
WIFI_DRIVER_FW_PATH_P2P		:= "/system/etc/firmware/fw_bcmdhd_p2p.bin"
WIFI_DRIVER_FW_PATH_AP		:= "/system/etc/firmware/fw_bcmdhd_apsta.bin"

BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
TARGET_NEEDS_BLUETOOTH_INIT_DELAY := true

# to enable the GPS HAL
BOARD_USES_QCOM_LIBRPC := true
BOARD_USES_QCOM_GPS := true
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := iproj
# AMSS version to use for GPS
BOARD_VENDOR_QCOM_GPS_LOC_API_AMSS_VERSION := 50000

TARGET_PROVIDES_LIBLIGHTS := true

BOARD_HAVE_BACK_MIC_CAMCORDER := true

COMMON_GLOBAL_CFLAGS += -DICS_CAMERA_BLOB -DQCOM_ACDB_ENABLED
BOARD_NEEDS_MEMORYHEAPPMEM := true

## This is evil. The mt9m114 (FFC) data inside the liboemcamera blob is in the .bss section,
## and inaccessible if PIE is enabled
TARGET_DISABLE_ARM_PIE := true

TARGET_BOOTANIMATION_USE_RGB565 := true
TARGET_BOOTANIMATION_PRELOAD := true

BOARD_LEGACY_NL80211_STA_EVENTS := true

# mmc_erase sometimes hangs and requires a reboot, so skip it
BOARD_SUPPRESS_EMMC_WIPE := true

ENABLE_WEBGL := true

# Recovery
BOARD_HAS_NO_SELECT_BUTTON := true
#BOARD_TOUCH_RECOVERY := true
BOARD_CUSTOM_GRAPHICS := ../../../device/lge/iproj/recovery-gfx.c

ifeq ($(TARGET_PRODUCT),cm_iproj) # XXX

# Partitions
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x01400000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x01400000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 527433728
BOARD_USERDATAIMAGE_PARTITION_SIZE := 2004621312

# Kernel
BOARD_USE_PREBUILT_KERNEL := true

ifeq ($(BOARD_USE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL_DIR := device/lge/iproj/kernels/cm
else
# Build kernel from source
TARGET_KERNEL_SOURCE := kernel/lge/iproj
TARGET_KERNEL_CONFIG := cyanogenmod_p930_defconfig
TARGET_KERNEL_CUSTOM_TOOLCHAIN := arm-eabi-4.4.3
endif

BOARD_KERNEL_CMDLINE := androidboot.hardware=iproj
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_BASE := 0x40200000
BOARD_FORCE_RAMDISK_ADDRESS := 0x41a00000

endif # TARGET_PRODUCT == cm_iproj

ifneq ($(TARGET_PREBUILT_KERNEL_DIR),)
TARGET_PREBUILT_KERNEL := $(TARGET_PREBUILT_KERNEL_DIR)/kernel
TARGET_PREBUILT_MODULES := $(wildcard $(TARGET_PREBUILT_KERNEL_DIR)/*.ko)
PRODUCT_COPY_FILES += \
	$(TARGET_PREBUILT_KERNEL):kernel
PRODUCT_COPY_FILES += \
	$(foreach mod,$(TARGET_PREBUILT_MODULES),$(mod):system/lib/modules/$(notdir $(mod)))
$(PRODUCT_OUT)/kernel: $(foreach mod,$(TARGET_PREBUILT_MODULES),$(PRODUCT_OUT)/system/lib/modules/$(notdir $(mod)))
endif

TARGET_OTA_ASSERT_DEVICE := auto
