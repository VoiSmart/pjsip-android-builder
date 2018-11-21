include ../../../build.mak
include ../../../build/common.mak

export LIBDIR := ../../lib

RULES_MAK := $(PJDIR)/build/rules.mak

export G729_CODEC_LIB := libg729codec-$(TARGET_NAME)$(LIBEXT)

###############################################################################
# Gather all flags.
#
export _CFLAGS 	:= $(CC_CFLAGS) $(OS_CFLAGS) $(HOST_CFLAGS) $(M_CFLAGS) \
		   $(CFLAGS) $(CC_INC)../.. $(CC_INC)../../g729/include \
		   $(CC_INC)../../../pjlib/include $(CC_INC)../../../pjlib-util/include \
		   $(CC_INC)../../../pjnath/include $(CC_INC)../../../pjmedia/include
export _CXXFLAGS:= $(_CFLAGS) $(CC_CXXFLAGS) $(OS_CXXFLAGS) $(M_CXXFLAGS) \
		   $(HOST_CXXFLAGS) $(CXXFLAGS)
export _LDFLAGS := $(CC_LDFLAGS) $(OS_LDFLAGS) $(M_LDFLAGS) $(HOST_LDFLAGS) \
		   $(LDFLAGS)

export G729_CODEC_SRCDIR = ../../g729
export G729_CODEC_OBJS = src/acelp_ca.o src/cod_ld8a.o src/dec_gain.o src/dspfunc.o src/g729a_encoder.o \
                         src/lpcfunc.o src/oper_32b.o src/post_pro.o src/pred_lt3.o src/tab_ld8a.o \
			 src/basic_op.o src/cor_func.o src/dec_lag3.o src/filter.o src/gainpred.o \
			 src/lspdec.o src/p_parity.o src/postfilt.o src/qua_gain.o src/taming.o \
			 src/bits.o src/de_acelp.o src/dec_ld8a.o src/g729a_decoder.o src/lpc.o \
			 src/lspgetq.o src/pitch_a.o src/pre_proc.o src/qua_lsp.o src/util.o src/round.o

export G729_CODEC_CFLAGS = $(_CFLAGS)

export CC_OUT CC AR RANLIB HOST_MV HOST_RM HOST_RMDIR HOST_MKDIR OBJEXT LD LDOUT
###############################################################################
# Main entry
#
# $(TARGET) is defined in os-$(OS_NAME).mak file in current directory.
#
TARGETS := $(G729_CODEC_LIB)

all: $(TARGETS)

doc:
	cd .. && doxygen docs/doxygen.cfg

dep: depend
distclean: realclean

.PHONY: all dep depend clean realclean distclean
.PHONY: $(TARGETS)
.PHONY: $(G729_CODEC_LIB)

libg729codec:
	$(MAKE) -f $(RULES_MAK) APP=G729_CODEC app=libg729codec $(G729_CODEC_LIB)

$(G729_CODEC_LIB):
	$(MAKE) -f $(RULES_MAK) APP=G729_CODEC app=libg729codec $(subst /,$(HOST_PSEP),$(LIBDIR)/$@)

clean print_lib:
	$(MAKE) -f $(RULES_MAK) APP=G729_CODEC app=libg729codec $@

realclean:
	$(subst @@,$(subst /,$(HOST_PSEP),.ilbc-$(TARGET_NAME).depend),$(HOST_RMR))

	$(MAKE) -f $(RULES_MAK) APP=G729_CODEC app=libg729codec $@

depend:
	$(MAKE) -f $(RULES_MAK) APP=G729_CODEC app=libg729codec $@
