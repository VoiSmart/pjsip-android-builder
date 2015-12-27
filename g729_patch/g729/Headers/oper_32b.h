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

/* Double precision operations */

Word32 Div_32(Word32 L_num, Word16 denom_hi, Word16 denom_lo);

/*___________________________________________________________________________
 |                                                                           |
 |  Function L_Comp()                                                        |
 |                                                                           |
 |  Compose from two 16 bit DPF a 32 bit integer.                            |
 |                                                                           |
 |     L_32 = hi<<16 + lo<<1                                                 |
 |                                                                           |
 |  Arguments:                                                               |
 |                                                                           |
 |   hi        msb                                                           |
 |   lo        lsf (with sign)                                               |
 |                                                                           |
 |   Return Value :                                                          |
 |                                                                           |
 |             32 bit long signed integer (Word32) whose value falls in the  |
 |             range : 0x8000 0000 <= L_32 <= 0x7fff fff0.                   |
 |                                                                           |
 |___________________________________________________________________________|
*/
#define L_Comp(hi, lo)  (((Word32)(hi) << 16) + ((Word32)(lo) << 1))

/*___________________________________________________________________________
 |                                                                           |
 |  Function L_Extract()                                                     |
 |                                                                           |
 |  Extract from a 32 bit integer two 16 bit DPF.                            |
 |                                                                           |
 |  Arguments:                                                               |
 |                                                                           |
 |   L_32      : 32 bit integer.                                             |
 |               0x8000 0000 <= L_32 <= 0x7fff ffff.                         |
 |   hi        : b16 to b31 of L_32                                          |
 |   lo        : (L_32 - hi<<16)>>1                                          |
 |___________________________________________________________________________|
*/

static inline void L_Extract(Word32 L_32, Word16 *hi, Word16 *lo)
{
  *hi = (Word16) (L_32 >> 16);
  *lo = (Word16)((L_32 >> 1) - (*hi << 15));
}

/*___________________________________________________________________________
 | Function Mpy_32_16()                                                      |
 |                                                                           |
 |   Multiply a 16 bit integer by a 32 bit (DPF). The result is divided      |
 |   by 2**15                                                                |
 |                                                                           |
 |   This operation can also be viewed as the multiplication of a Q31        |
 |   number by a Q15 number, the result is in Q31.                           |
 |                                                                           |
 |   L_32 = (hi1*lo2)<<1 + ((lo1*lo2)>>15)<<1                                |
 |                                                                           |
 | Arguments:                                                                |
 |                                                                           |
 |  hi          hi part of 32 bit number.                                    |
 |  lo          lo part of 32 bit number.                                    |
 |  n           16 bit number.                                               |
 |                                                                           |
 |___________________________________________________________________________|
*/
static inline Word32 Mpy_32_16(Word16 shi, Word16 slo, Word16 n)
{
  register Word32 a = L_Comp(shi, slo);
  register Word32 b = n;

  int lo, hi;
  __asm__("smull %0, %1, %2, %3     \n\t"
          "mov   %0, %0,     LSR #15 \n\t"
          "add   %1, %0, %1, LSL #17 \n\t"
          : "=&r"(lo), "=&r"(hi)
          : "r"(b), "r"(a));
  return hi;
}

/*___________________________________________________________________________
 | Function Mpy_32()                                                         |
 |                                                                           |
 |   Multiply two 32 bit integers (DPF). The result is divided by 2**31      |
 |                                                                           |
 |   L_32 = (hi1*hi2)<<1 + ( (hi1*lo2)>>15 + (lo1*hi2)>>15 )<<1              |
 |                                                                           |
 |   This operation can also be viewed as the multiplication of two Q31      |
 |   number and the result is also in Q31.                                   |
 |                                                                           |
 | Arguments:                                                                |
 |                                                                           |
 |  hi1         hi part of first number                                      |
 |  lo1         lo part of first number                                      |
 |  hi2         hi part of second number                                     |
 |  lo2         lo part of second number                                     |
 |                                                                           |
 |___________________________________________________________________________|
*/
static inline Word32 Mpy_32(Word16 hi1, Word16 lo1, Word16 hi2, Word16 lo2)
{
  register Word32 ra = hi1 << 16 | lo1;
  register Word32 rb = hi2 << 16 | lo2;
  Word32 out, outl;

  __asm__("smultt %0, %1, %2 \n\t"
          "qadd %0, %0, %0   \n\t"
          : "=r"(out)
          : "r"(ra), "r"(rb));
  __asm__("smultb %0, %2, %3   \n\t"
          "mov %0, %0, ASR #15 \n\t"
          "qdadd %1, %4, %0"
          : "=r"(outl), "=r"(out)
          : "r"(ra), "r"(rb), "1"(out));
  __asm__("smulbt %0, %2, %3   \n\t"
          "mov %0, %0, ASR #15 \n\t"
          "qdadd %1, %4, %0"
          : "=r"(outl), "=r"(out)
          : "r"(ra), "r"(rb), "1"(out));

  return out;
}
