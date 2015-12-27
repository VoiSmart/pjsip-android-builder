include ../../../build.mak
include ../../../build/common.mak

export LIBDIR := ../../lib

RULES_MAK := $(PJDIR)/build/rules.mak

export G729_CODEC_LIB := libg729codec-$(TARGET_NAME)$(LIBEXT)

###############################################################################
# Gather all flags.
#
export _CFLAGS 	:= $(CC_CFLAGS) $(OS_CFLAGS) $(HOST_CFLAGS) $(M_CFLAGS) \
		   $(CFLAGS) $(CC_INC)../.. $(CC_INC)../../g729/Headers \
		   $(CC_INC)../../../pjlib/include
export _CXXFLAGS:= $(_CFLAGS) $(CC_CXXFLAGS) $(OS_CXXFLAGS) $(M_CXXFLAGS) \
		   $(HOST_CXXFLAGS) $(CXXFLAGS)
export _LDFLAGS := $(CC_LDFLAGS) $(OS_LDFLAGS) $(M_LDFLAGS) $(HOST_LDFLAGS) \
		   $(LDFLAGS)

export G729_CODEC_SRCDIR = ../../g729
export G729_CODEC_OBJS = Sources/acelp_ca.o Sources/cod_ld8a.o Sources/dec_gain.o Sources/dspfunc.o Sources/g729a_encoder.o \
                         Sources/lpcfunc.o Sources/oper_32b.o Sources/post_pro.o Sources/pred_lt3.o Sources/tab_ld8a.o \
			 Sources/basic_op.o Sources/cor_func.o Sources/dec_lag3.o Sources/filter.o Sources/gainpred.o \
			 Sources/lspdec.o Sources/p_parity.o Sources/postfilt.o Sources/qua_gain.o Sources/taming.o \
			 Sources/bits.o Sources/de_acelp.o Sources/dec_ld8a.o Sources/g729a_decoder.o Sources/lpc.o \
			 Sources/lspgetq.o Sources/pitch_a.o Sources/pre_proc.o Sources/qua_lsp.o Sources/util.o

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
