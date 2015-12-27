/**
 *  g729a codec for iPhone and iPod Touch
 *  Copyright (C) 2009 Samuel <samuelv0304@gmail.com>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License along
 *  with this program; if not, write to the Free Software Foundation, Inc.,
 *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */
/****************************************************************************************
Portions of this file are derived from the following ITU standard:
   ITU-T G.729A Speech Coder    ANSI-C Source Code
   Version 1.1    Last modified: September 1996

   Copyright (c) 1996,
   AT&T, France Telecom, NTT, Universite de Sherbrooke
****************************************************************************************/

/*-----------------------------------------------------------------*
 * Main program of the G.729a 8.0 kbit/s decoder.                  *
 *                                                                 *
 *    Usage : decoder  bitstream_file  synth_file                  *
 *                                                                 *
 *-----------------------------------------------------------------*/

#include <stdlib.h>
#include <stdio.h>

#include "typedef.h"
#include "basic_op.h"
#include "ld8a.h"

#include "g729a.h"

/*-----------------------------------------------------------------*
 *            Main decoder routine                                 *
 *-----------------------------------------------------------------*/

int main(int argc, char *argv[] )
{
  Word16  synth[L_FRAME];
#if defined(CONTROL_OPT) && (CONTROL_OPT == 1)
  Word16 i;
  Word16  serial[SERIAL_SIZE];          /* Serial stream               */
#else
  UWord8  serial[M];                    /* Serial stream               */
#endif
  Word16 frame;
  Word32 size;
  void *hDecoder;
  FILE   *f_syn, *f_serial;
  Flag badFrame;

  printf("\n");
  printf("************   G.729a 8.0 KBIT/S SPEECH DECODER  ************\n");
  printf("\n");
  printf("------------------- Fixed point C simulation ----------------\n");
  printf("\n");
  printf("------------ Version 1.1 (Release 2, November 2006) --------\n");
  printf("\n");

   /* Passed arguments */

   if ( argc != 3)
     {
        printf("Usage :%s bitstream_file  outputspeech_file\n",argv[0]);
        printf("\n");
        printf("Format for bitstream_file:\n");
#if defined(CONTROL_OPT) && (CONTROL_OPT == 1)
        printf("  One (2-byte) synchronization word \n");
        printf("  One (2-byte) size word,\n");
        printf("  80 words (2-byte) containing 80 bits.\n");
#else
        printf("  10 bytes - g729a parameters\n");
#endif
        printf("\n");
        printf("Format for outputspeech_file:\n");
        printf("  Synthesis is written to a binary file of 16 bits PCM data.\n");
        exit( 1 );
     }

   /* Open file for synthesis and packed serial stream */

   if( (f_serial = fopen(argv[1],"rb") ) == NULL )
     {
        printf("%s - Error opening file  %s !!\n", argv[0], argv[1]);
        exit(0);
     }

   if( (f_syn = fopen(argv[2], "wb") ) == NULL )
     {
        printf("%s - Error opening file  %s !!\n", argv[0], argv[2]);
        exit(0);
     }

   printf("Input bitstream file  :   %s\n",argv[1]);
   printf("Synthesis speech file :   %s\n",argv[2]);

/*-----------------------------------------------------------------*
 *           Initialization of decoder                             *
 *-----------------------------------------------------------------*/

  size = g729a_dec_mem_size();
  hDecoder = calloc(1, size * sizeof(UWord8));
  if (hDecoder == NULL)
  {
    printf("%s - Not enough memory", argv[0]);
    fclose(f_syn);
    fclose(f_serial);
    exit(0);
  }
  g729a_dec_init(hDecoder);

/*-----------------------------------------------------------------*
 *            Loop for each "L_FRAME" speech data                  *
 *-----------------------------------------------------------------*/

  frame = 0;
  badFrame = 0;

#if defined(CONTROL_OPT) && (CONTROL_OPT == 1)
  while( fread(serial, sizeof(Word16), SERIAL_SIZE, f_serial) == SERIAL_SIZE)
#else
  while( fread(serial, sizeof(UWord8), M, f_serial) == M)
#endif
  {

#if defined(CONTROL_OPT) && (CONTROL_OPT == 1)
#else
    printf("Frame =%d\r", frame++);
#endif

#if defined(CONTROL_OPT) && (CONTROL_OPT == 1)
    badFrame = 0;
    /* the hardware detects frame erasures by checking if all bits
       are set to zero */
    for (i=2; i < SERIAL_SIZE; i++)
      if (serial[i] == 0 ) badFrame = 1; /* frame erased     */

    g729a_dec_process(hDecoder, &serial[2], synth, badFrame);
#else
    g729a_dec_process(hDecoder, serial, synth, badFrame);
#endif



    fwrite(synth, sizeof(short), L_FRAME, f_syn);
  }
  g729a_dec_deinit(hDecoder);
  free(hDecoder);
  fclose(f_syn);
  fclose(f_serial);

  return(0);
}
