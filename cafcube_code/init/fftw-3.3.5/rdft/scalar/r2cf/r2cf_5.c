/*
 * Copyright (c) 2003, 2007-14 Matteo Frigo
 * Copyright (c) 2003, 2007-14 Massachusetts Institute of Technology
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 *
 */

/* This file was automatically generated --- DO NOT EDIT */
/* Generated on Sat Jul 30 16:46:03 EDT 2016 */

#include "codelet-rdft.h"

#ifdef HAVE_FMA

/* Generated by: ../../../genfft/gen_r2cf.native -fma -reorder-insns -schedule-for-pipeline -compact -variables 4 -pipeline-latency 4 -n 5 -name r2cf_5 -include r2cf.h */

/*
 * This function contains 12 FP additions, 7 FP multiplications,
 * (or, 7 additions, 2 multiplications, 5 fused multiply/add),
 * 17 stack variables, 4 constants, and 10 memory accesses
 */
#include "r2cf.h"

static void r2cf_5(R *R0, R *R1, R *Cr, R *Ci, stride rs, stride csr, stride csi, INT v, INT ivs, INT ovs)
{
     DK(KP559016994, +0.559016994374947424102293417182819058860154590);
     DK(KP250000000, +0.250000000000000000000000000000000000000000000);
     DK(KP618033988, +0.618033988749894848204586834365638117720309180);
     DK(KP951056516, +0.951056516295153572116439333379382143405698634);
     {
	  INT i;
	  for (i = v; i > 0; i = i - 1, R0 = R0 + ivs, R1 = R1 + ivs, Cr = Cr + ovs, Ci = Ci + ovs, MAKE_VOLATILE_STRIDE(20, rs), MAKE_VOLATILE_STRIDE(20, csr), MAKE_VOLATILE_STRIDE(20, csi)) {
	       E T7, T1, T2, T4, T5;
	       T7 = R0[0];
	       T1 = R0[WS(rs, 2)];
	       T2 = R1[0];
	       T4 = R0[WS(rs, 1)];
	       T5 = R1[WS(rs, 1)];
	       {
		    E T3, T8, T6, T9, Tc, Ta, Tb;
		    T3 = T1 - T2;
		    T8 = T2 + T1;
		    T6 = T4 - T5;
		    T9 = T4 + T5;
		    Ci[WS(csi, 2)] = KP951056516 * (FMA(KP618033988, T3, T6));
		    Ci[WS(csi, 1)] = KP951056516 * (FNMS(KP618033988, T6, T3));
		    Tc = T8 - T9;
		    Ta = T8 + T9;
		    Tb = FNMS(KP250000000, Ta, T7);
		    Cr[0] = T7 + Ta;
		    Cr[WS(csr, 2)] = FNMS(KP559016994, Tc, Tb);
		    Cr[WS(csr, 1)] = FMA(KP559016994, Tc, Tb);
	       }
	  }
     }
}

static const kr2c_desc desc = { 5, "r2cf_5", {7, 2, 5, 0}, &GENUS };

void X(codelet_r2cf_5) (planner *p) {
     X(kr2c_register) (p, r2cf_5, &desc);
}

#else				/* HAVE_FMA */

/* Generated by: ../../../genfft/gen_r2cf.native -compact -variables 4 -pipeline-latency 4 -n 5 -name r2cf_5 -include r2cf.h */

/*
 * This function contains 12 FP additions, 6 FP multiplications,
 * (or, 9 additions, 3 multiplications, 3 fused multiply/add),
 * 17 stack variables, 4 constants, and 10 memory accesses
 */
#include "r2cf.h"

static void r2cf_5(R *R0, R *R1, R *Cr, R *Ci, stride rs, stride csr, stride csi, INT v, INT ivs, INT ovs)
{
     DK(KP250000000, +0.250000000000000000000000000000000000000000000);
     DK(KP559016994, +0.559016994374947424102293417182819058860154590);
     DK(KP587785252, +0.587785252292473129168705954639072768597652438);
     DK(KP951056516, +0.951056516295153572116439333379382143405698634);
     {
	  INT i;
	  for (i = v; i > 0; i = i - 1, R0 = R0 + ivs, R1 = R1 + ivs, Cr = Cr + ovs, Ci = Ci + ovs, MAKE_VOLATILE_STRIDE(20, rs), MAKE_VOLATILE_STRIDE(20, csr), MAKE_VOLATILE_STRIDE(20, csi)) {
	       E Ta, T7, T8, T3, Tb, T6, T9, Tc;
	       Ta = R0[0];
	       {
		    E T1, T2, T4, T5;
		    T1 = R0[WS(rs, 2)];
		    T2 = R1[0];
		    T7 = T2 + T1;
		    T4 = R0[WS(rs, 1)];
		    T5 = R1[WS(rs, 1)];
		    T8 = T4 + T5;
		    T3 = T1 - T2;
		    Tb = T7 + T8;
		    T6 = T4 - T5;
	       }
	       Ci[WS(csi, 1)] = FNMS(KP587785252, T6, KP951056516 * T3);
	       Cr[0] = Ta + Tb;
	       Ci[WS(csi, 2)] = FMA(KP587785252, T3, KP951056516 * T6);
	       T9 = KP559016994 * (T7 - T8);
	       Tc = FNMS(KP250000000, Tb, Ta);
	       Cr[WS(csr, 1)] = T9 + Tc;
	       Cr[WS(csr, 2)] = Tc - T9;
	  }
     }
}

static const kr2c_desc desc = { 5, "r2cf_5", {9, 3, 3, 0}, &GENUS };

void X(codelet_r2cf_5) (planner *p) {
     X(kr2c_register) (p, r2cf_5, &desc);
}

#endif				/* HAVE_FMA */
