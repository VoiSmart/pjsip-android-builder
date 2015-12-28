## Disclaimer
G.729 implementation included in this project is Open Source and has been taken from [Siphon](http://siphon.googlecode.com/svn/trunk/g729a) and [CSipSimple](https://code.google.com/p/csipsimple/). If you want to use it in your app, you have to get a license from G.729 patent holders for every device on which you're going to use it. The authors of this project and of the open source implementation are not responsible for improper or unlicensed use of G.729 codec.

## G.729 Manual Patch instructions
All the operations described in this file have been also automated in the `install.sh` script, which is automatically executed after you download PJSIP sources with `./prepare-build-system`. The manual patching procedure is also described here for documentation purposes and for future use.

The paths described here are relative to `pjproject-2.4.5` folder. Just add the lines marked with `+` where indicated by the snippets (original code snippets, which have been modified for PJSIP 2.4.5, have been taken from: http://trac.etellicom.com/wiki/G729CodecForPJSIP2x_iOS6)

### build.mak.in
```
 APP_THIRD_PARTY_LIB_FILES += $(PJ_DIR)/third_party/lib/libg7221codec-$(LIB_SUFFIX)
 endif

+ifeq (@ac_has_g729_codec@,1)
+APP_THIRD_PARTY_LIBS += -lg729codec-$(TARGET_NAME)
+APP_THIRD_PARTY_LIB_FILES += $(PJ_DIR)/third_party/lib/libg729codec-$(LIB_SUFFIX)
+endif
+
```

### pjmedia/build/os-auto.mak.in
```
# Codecs
#
AC_NO_G711_CODEC=@ac_no_g711_codec@
AC_NO_L16_CODEC=@ac_no_l16_codec@
AC_NO_GSM_CODEC=@ac_no_gsm_codec@
AC_NO_SPEEX_CODEC=@ac_no_speex_codec@
AC_NO_ILBC_CODEC=@ac_no_ilbc_codec@
AC_NO_G722_CODEC=@ac_no_g722_codec@
AC_NO_G7221_CODEC=@ac_no_g7221_codec@
+AC_HAS_G729_CODEC=@ac_has_g729_codec@
AC_NO_OPENCORE_AMRNB=@ac_no_opencore_amrnb@
AC_NO_OPENCORE_AMRWB=@ac_no_opencore_amrwb@

export CODEC_OBJS=
```

and

```
 export G7221_CFLAGS += -I$(THIRD_PARTY)
 endif

+ifeq ($(AC_HAS_G729_CODEC),1)
+export CFLAGS += -I$(THIRD_PARTY)/g729/include -DPJMEDIA_HAS_G729_CODEC=1
+export CODEC_OBJS += g729.o
+else
+export CFLAGS += -DPJMEDIA_HAS_G729_CODEC=0
+endif

ifeq ($(AC_NO_OPENCORE_AMRNB),1)
export CFLAGS += -DPJMEDIA_HAS_OPENCORE_AMRNB_CODEC=0
```

### pjmedia/include/pjmedia-codec/config.h
```
#ifndef PJMEDIA_HAS_G722_CODEC
#   define PJMEDIA_HAS_G722_CODEC    1
#endif

+/**
+* Unless specified otherwise, G.729 codec is not included by default.
+*/
+#ifndef PJMEDIA_HAS_G729_CODEC
+#   define PJMEDIA_HAS_G729_CODEC    0
+#endif

/**
 * Default G.722 codec encoder and decoder level adjustment. The G.722
```

### pjmedia/include/pjmedia-codec/config_auto.h.in
```
/* G7221 codec */
#ifndef PJMEDIA_HAS_G7221_CODEC
#undef PJMEDIA_HAS_G7221_CODEC
#endif

+/* G729 codec */
+#ifndef PJMEDIA_HAS_G729_CODEC
+#undef PJMEDIA_HAS_G729_CODEC
+#endif

/* OpenCORE AMR-NB codec */
```

### pjmedia/include/pjmedia-codec.h
```
#include <pjmedia-codec/audio_codecs.h>
#include <pjmedia-codec/l16.h>
#include <pjmedia-codec/ffmpeg_vid_codecs.h>
#include <pjmedia-codec/gsm.h>
#include <pjmedia-codec/speex.h>
#include <pjmedia-codec/ilbc.h>
#include <pjmedia-codec/g722.h>
#include <pjmedia-codec/g7221.h>
+#include <pjmedia-codec/g729.h>
#include <pjmedia-codec/ipp_codecs.h>
#include <pjmedia-codec/opencore_amr.h>
#include <pjmedia-codec/passthrough.h>
#include <pjmedia-codec/silk.h>
```

### aconfigure.ac
```
                 [ac_v4l2_cflags="-DPJMEDIA_VIDEO_DEV_HAS_V4L2=1"
                  ac_v4l2_ldflags="-lv4l2"
                  LIBS="$LIBS -lv4l2"
                 ]
                 )
          ])

+dnl ########################################################
+dnl # G.729 support
+dnl #
+AC_SUBST(ac_has_g729_codec)
+AC_ARG_ENABLE(g729_codec,
+    AC_HELP_STRING([--enable-g729-codec],
+       [Enable g729 support (derived from ITU implementation).]),
+        [ac_has_g729_codec=1]
+        AC_DEFINE(PJMEDIA_HAS_G729_CODEC,1)
+        AC_MSG_RESULT([Checking if g729 codec is disabled...no]),
+    [ac_has_g729_codec=]
+    AC_DEFINE(PJMEDIA_HAS_G729_CODEC,0)
+    AC_MSG_RESULT([Checking if g729 codec is disabled...yes])
+    )
+
dnl ########################################################
dnl # Intel IPP support
```

### pjmedia/src/pjmedia-codec/audio_codecs.c
```
#endif /* PJMEDIA_HAS_G7221_CODEC */

+#if PJMEDIA_HAS_G729_CODEC
+    status = pjmedia_codec_g729_init(endpt);
+    if (status != PJ_SUCCESS) {
+        return status;
+    }
+#endif /* PJMEDIA_HAS_G729_CODEC */
+
#if PJMEDIA_HAS_L16_CODEC
```

### third_party/build/os-auto.mak.in
```
ifneq (@ac_no_g7221_codec@,1)
DIRS += g7221
endif

+ifeq (@ac_has_g729_codec@,1)
+DIRS += g729
+endif

ifneq ($(findstring pa,@ac_pjmedia_snd@),)
ifeq (@ac_external_pa@,1)
```

### Manual file copy operations and commands
- move `g729.c` into `pjmedia/src/pjmedia-codec/g729.c`
- move `g729.h` into `pjmedia/include/pjmedia-codec/g729.h`
- copy `g729` into `third_party/`
- create folder `third_party/build/g729/` and move `third_party/g729/Makefile` into it
- generate autoconfigure:
```
cd path/to/pjproject
rm -rf aconfigure
autoconf aconfigure.ac > aconfigure
sudo chmod 777 aconfigure
```

### Enable G.729 in config site
your `pjlib/include/pj/config_site.h` should look like this:
```
#define PJ_CONFIG_IPHONE 1
+#define PJMEDIA_HAS_G729_CODEC 1
+#define PJMEDIA_HAS_G7221_CODEC 1
#include <pj/config_site_sample.h>
```
