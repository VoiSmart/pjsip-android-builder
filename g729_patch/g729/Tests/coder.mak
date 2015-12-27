#

CC = /Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/gcc-4.0 \
  -isysroot /Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS2.2.sdk
CFLAGS = -arch armv6 -mno-thumb -x c \
  -Wall -Os -I ../Headers 

SRCDIR = ../Sources
OBJDIR = ../Build
EXEDIR = ../Bin

# objects needed for encoder

OBJECTS= \
 acelp_ca.o\
 basic_op.o\
 bits.o\
 cod_ld8a.o\
 dspfunc.o\
 filter.o\
 gainpred.o\
 lpc.o\
 lpcfunc.o\
 lspgetq.o\
 oper_32b.o\
 p_parity.o\
 pitch_a.o\
 pre_proc.o\
 pred_lt3.o\
 qua_gain.o\
 qua_lsp.o\
 tab_ld8a.o\
 util.o\
 taming.o\
 cor_func.o\
 g729a_encoder.o

OBJECTS += coder.o

OBJS = $(foreach file, $(OBJECTS), $(OBJDIR)/$(file))

coder : $(OBJECTS)
	$(CC) -arch armv6 -mno-thumb -o $(EXEDIR)/arm_coder $(OBJS)

coder.o : coder.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

# Dependencies for each file

acelp_ca.o : $(SRCDIR)/acelp_ca.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

basic_op.o : $(SRCDIR)/basic_op.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

bits.o : $(SRCDIR)/bits.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

cod_ld8a.o : $(SRCDIR)/cod_ld8a.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

dspfunc.o : $(SRCDIR)/dspfunc.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

filter.o : $(SRCDIR)/filter.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

gainpred.o : $(SRCDIR)/gainpred.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

lpc.o : $(SRCDIR)/lpc.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

lpcfunc.o : $(SRCDIR)/lpcfunc.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

lspgetq.o : $(SRCDIR)/lspgetq.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

oper_32b.o : $(SRCDIR)/oper_32b.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

p_parity.o : $(SRCDIR)/p_parity.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

pitch_a.o : $(SRCDIR)/pitch_a.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

pre_proc.o : $(SRCDIR)/pre_proc.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

pred_lt3.o : $(SRCDIR)/pred_lt3.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

qua_gain.o : $(SRCDIR)/qua_gain.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

qua_lsp.o : $(SRCDIR)/qua_lsp.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

tab_ld8a.o : $(SRCDIR)/tab_ld8a.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

util.o : $(SRCDIR)/util.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

taming.o : $(SRCDIR)/taming.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

cor_func.o : $(SRCDIR)/cor_func.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

g729a_encoder.o : $(SRCDIR)/g729a_encoder.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@
