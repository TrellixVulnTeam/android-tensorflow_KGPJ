LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

TENSORFLOW_CFLAGS	  := -frtti \
  -fstack-protector-strong \
  -fpic \
  -ffunction-sections \
  -funwind-tables \
  -no-canonical-prefixes \
  '-march=armv7-a' \
  '-mfpu=vfpv3-d16' \
  '-mfloat-abi=softfp' \
  '-std=c++11' '-mfpu=neon' -O2 \

LOCAL_LDLIBS     := -llog
LOCAL_MODULE     := tensorflow_jni
LOCAL_SRC_FILES  := tensorflow_jni.cc
LOCAL_ARM_MODE   := arm
LOCAL_CFLAGS     := $(TENSORFLOW_CFLAGS)
LOCAL_C_INCLUDES += $(LOCAL_PATH)/include $(LOCAL_PATH)/genfiles $(LOCAL_PATH)/include/third_party/eigen3
LOCAL_LDLIBS    :=  \
	-Wl,-whole-archive \
	$(LOCAL_PATH)/libs/$(TARGET_ARCH_ABI)/libandroid_tensorflow_lib_lite.a \
	$(LOCAL_PATH)/libs/$(TARGET_ARCH_ABI)/libandroid_tensorflow_operators.a \
	$(LOCAL_PATH)/libs/$(TARGET_ARCH_ABI)/libre2.a \
	$(LOCAL_PATH)/libs/$(TARGET_ARCH_ABI)/libprotos_all_cc.a \
	$(LOCAL_PATH)/libs/$(TARGET_ARCH_ABI)/libprotobuf.a \
	$(LOCAL_PATH)/libs/$(TARGET_ARCH_ABI)/libprotobuf_lite.a \
	-Wl,-no-whole-archive \
	$(NDK_ROOT)/sources/cxx-stl/gnu-libstdc++/4.9/libs/$(TARGET_ARCH_ABI)/libgnustl_static.a \
	$(NDK_ROOT)/sources/cxx-stl/gnu-libstdc++/4.9/libs/$(TARGET_ARCH_ABI)/libsupc++.a \
	-llog -landroid -lm -ljnigraphics -pthread -no-canonical-prefixes '-march=armv7-a' -Wl,--fix-cortex-a8 -Wl,-S \

NDK_MODULE_PATH := $(call my-dir)

include $(BUILD_SHARED_LIBRARY)
