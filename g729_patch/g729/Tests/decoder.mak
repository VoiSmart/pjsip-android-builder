#

CC = /Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/gcc-4.0 \
  -isysroot /Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS2.2.sdk
CFLAGS = -arch armv6 -mno-thumb -x c \
  -Wall -Werror -Os -I ../Headers

SRCDIR = ../Sources
OBJDIR = ../Build
EXEDIR = ../Bin

# objects needed for decoder

OBJECTS = \
 basic_op.o \
 bits.o \
 de_acelp.o\
 dec_gain.o\
 dec_lag3.o\
 dec_ld8a.o\
 dspfunc.o\
 filter.o\
 gainpred.o\
 lpcfunc.o\
 lspdec.o\
 lspgetq.o\
 oper_32b.o\
 p_parity.o\
 post_pro.o\
 pred_lt3.o\
 postfilt.o\
 tab_ld8a.o\
 util.o\
 g729a_decoder.o

# g729a_decoder.o \
# g729a_encoder.o \
# g729a.o
 
OBJECTS += decoder.o

OBJS = $(foreach file, $(OBJECTS), $(OBJDIR)/$(file))

# linker
decoder : $(OBJECTS)
	$(CC) -arch armv6 -mno-thumb -o $(EXEDIR)/arm_decoder $(OBJS)

decoder.o : decoder.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

# Dependencies for each routine
basic_op.o : $(SRCDIR)/basic_op.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

bits.o : $(SRCDIR)/bits.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

de_acelp.o : $(SRCDIR)/de_acelp.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

dec_gain.o : $(SRCDIR)/dec_gain.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

dec_lag3.o : $(SRCDIR)/dec_lag3.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

dec_ld8a.o : $(SRCDIR)/dec_ld8a.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

dspfunc.o : $(SRCDIR)/dspfunc.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

filter.o : $(SRCDIR)/filter.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

gainpred.o : $(SRCDIR)/gainpred.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

lpcfunc.o : $(SRCDIR)/lpcfunc.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

lspdec.o : $(SRCDIR)/lspdec.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

lspgetq.o : $(SRCDIR)/lspgetq.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

oper_32b.o : $(SRCDIR)/oper_32b.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

p_parity.o : $(SRCDIR)/p_parity.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

post_pro.o : $(SRCDIR)/post_pro.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

pred_lt3.o : $(SRCDIR)/pred_lt3.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

postfilt.o : $(SRCDIR)/postfilt.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

tab_ld8a.o : $(SRCDIR)/tab_ld8a.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

util.o : $(SRCDIR)/util.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@

g729a.o : $(SRCDIR)/g729a.c
	echo $(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@ 

g729a_decoder.o : $(SRCDIR)/g729a_decoder.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@ 

g729a_encoder.o : $(SRCDIR)/g729a_encoder.c
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@ 
