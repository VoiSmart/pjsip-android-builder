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

/*-------------------------------------------------------------------*
 * Main program of the ITU-T G.729A  8 kbit/s encoder.               *
 *                                                                   *
 *    Usage : coder speech_file  bitstream_file                      *
 *-------------------------------------------------------------------*/

#include <stdio.h>
#include <stdlib.h>

#include "typedef.h"
#include "basic_op.h"
#include "ld8a.h"

#include "g729a.h"

int main(int argc, char *argv[] )
{
  FILE *f_speech;               /* File of speech data                   */
  FILE *f_serial;               /* File of serial bits for transmission  */

  Word16  speech[L_FRAME];
#if defined(CONTROL_OPT) && (CONTROL_OPT == 1)
  Word16 serial[SERIAL_SIZE];    /* Output bitstream buffer               */
#else
  UWord8  serial[M];                    /* Serial stream               */
#endif
  Word16 frame;                  /* frame counter */
  Word32 size;
  void *hEncoder;

  printf("\n");
  printf("***********    ITU G.729A 8 KBIT/S SPEECH CODER    ***********\n");
  printf("\n");
  printf("------------------- Fixed point C simulation -----------------\n");
  printf("\n");
  printf("------------ Version 1.1 (Release 2, November 2006) --------\n");
  printf("\n");


/*--------------------------------------------------------------------------*
 * Open speech file and result file (output serial bit stream)              *
 *--------------------------------------------------------------------------*/

  if ( argc != 3 )
    {
       printf("Usage : coder speech_file  bitstream_file\n");
       printf("\n");
       printf("Format for speech_file:\n");
       printf("  Speech is read from a binary file of 16 bits PCM data.\n");
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
       exit(1);
    }

  if ( (f_speech = fopen(argv[1], "rb")) == NULL) {
     printf("%s - Error opening file  %s !!\n", argv[0], argv[1]);
     exit(0);
  }
  printf(" Input speech file    :  %s\n", argv[1]);

  if ( (f_serial = fopen(argv[2], "wb")) == NULL) {
     printf("%s - Error opening file  %s !!\n", argv[0], argv[2]);
     exit(0);
  }
  printf(" Output bitstream file:  %s\n", argv[2]);

/*--------------------------------------------------------------------------*
 * Initialization of the coder.                                             *
 *--------------------------------------------------------------------------*/

  size = g729a_enc_mem_size();
  hEncoder = calloc(1, size * sizeof(UWord8));
  if (hEncoder == NULL)
  {
    printf("%s - Not enough memory", argv[0]);
    fclose(f_speech);
    fclose(f_serial);
    exit(0);
  }
  g729a_enc_init(hEncoder);

  /* Loop for each "L_FRAME" speech data. */
  frame = 0;
  while( fread(speech, sizeof(Word16), L_FRAME, f_speech) == L_FRAME)
  {
#if defined(CONTROL_OPT) && (CONTROL_OPT == 1)
#else
    printf("Frame =%d\r", frame++);
#endif
    g729a_enc_process(hEncoder, speech, serial);

#if defined(CONTROL_OPT) && (CONTROL_OPT == 1)
    fwrite(serial, sizeof(Word16), SERIAL_SIZE, f_serial);
#else
    fwrite(serial, sizeof(UWord8), M, f_serial);
#endif
  }

  g729a_enc_deinit(hEncoder);
  free(hEncoder);
  fclose(f_serial);
  fclose(f_speech);

  return (0);
}
