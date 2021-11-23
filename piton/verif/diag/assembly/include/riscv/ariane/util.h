// Copyright (c) 2012-2015, The Regents of the University of California (Regents).
// All Rights Reserved.

// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
// 1. Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
// 3. Neither the name of the Regents nor the
//    names of its contributors may be used to endorse or promote products
//    derived from this software without specific prior written permission.

// IN NO EVENT SHALL REGENTS BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT,
// SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS, ARISING
// OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF REGENTS HAS
// BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

// REGENTS SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
// THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
// PURPOSE. THE SOFTWARE AND ACCOMPANYING DOCUMENTATION, IF ANY, PROVIDED
// HEREUNDER IS PROVIDED "AS IS". REGENTS HAS NO OBLIGATION TO PROVIDE
// MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.

// this file has been copied and adapted for the OpenPiton testbench

#ifndef __UTIL_H
#define __UTIL_H


// some OpenPiton-specific defines
#define PITON_UART_ADDRESS  0xFFF0C2C000ULL
// this is used in piton stream to terminate correctly
#define PITON_TEST_GOOD_END 0x8100000000ULL
#define PITON_TEST_BAD_END  0x8200000000ULL

//Base address of CLINT memory mapped register
#define CLINT_CTRL_ADDR    0xfff1020000ULL


extern void setStats(int enable);

#include <stdint.h>

//Return the clock cycles. core id is the hard id (core id)
//Curiosity, running at 500MHz, this register will overflow after: 1169.8 years or continuous running.
#define get_cycles(core_id) (*(volatile uint64_t *)(CLINT_CTRL_ADDR + (0xBFF8 + core_id*8)))


// instantiation macros for atomic memory operation (non LR/SC)
// see also
// https://github.com/torvalds/linux/blob/ef78e5ec9214376c5cb989f5da70b02d0c117b66/arch/riscv/include/asm/atomic.h#L94

/*
Perform the expression fech and op
'asm_op' = swap, add, and, or, xor, max(u)
address 'mem' = address of the variable
i' = value used in the 'asm_op' 
'ret' = previous value of the variable at address 'mem'
*/

#define ATOMIC_FETCH_OP(ret, mem, i, asm_op, asm_type) \
  __asm__ __volatile__ (                               \
    " amo" #asm_op "." #asm_type " %1, %2, %0"         \
    : "+A" (mem), "=r" (ret)                           \
    : "r" (i)                                          \
    : "memory");


/* 

:"=r"(b)        output 
:"r"(a)         input 
:"+A"         address of read/write operation
            
/*
Perform the expression fech and op
'asm_op' = swap, add, and, or, xor, max(u)
address 'mem' = address of the variable
i' = value used in the 'asm_op' 
*/
#define ATOMIC_OP(mem, i, asm_op, asm_type)      \
  __asm__ __volatile__ (                         \
    " amo" #asm_op "." #asm_type " zero, %1, %0" \
    : "+A" (mem)                                 \
    : "r" (i)                                    \
    : "memory");



/*
load linked (LL) and store conditional (SC) instructions are a way to achieve 
atomic memory updates in shared memory multiprocessor systems, without locking 
memory locations for exclusive access by one processor.

The idea is that you use LL to load the value stored at a memory location into 
a register, modify it however you like there, and subsequently write it back to 
the same place using SC. SC will only overwrite the value in memory with your modified 
one if no other processor has altered it while you were working on the copy in the 
register. It has the side-effect of setting a status flag to indicate whether or not 
it was successful.

When the updated value is successfully stored, a thread can trust that its 
read-modify-write sequence was completed without interference from other threads. 
On a failure, it is up to the program to decide whether to give up or reload the address 
and try again, but at least it doesn't produce an undetected Race condition.
*/
/*
Loads value of address 'mem' into register 'ret'
asm_type = w
*/
#define LR_OP(ret, mem, asm_type)               \
  __asm__ __volatile__ (                        \
    " lr." #asm_type " %1, %0"                  \
    : "+A" (mem), "=r" (ret)                    \
    :                                           \
    : "memory");


/*
Stores the value of 'i' in address 'mem'
ret=0 - fail, ret = 1 - success
*/
#define SC_OP(ret, mem, i, asm_type)            \
  __asm__ __volatile__ (                        \
    " sc." #asm_type " %1, %2, %0"              \
    : "+A" (mem), "=r" (ret)                    \
    : "r" (i)                                   \
    : "memory");

#define static_assert(cond) switch(0) { case 0: case !!(long)(cond): ; }

static int verify(int n, const volatile int* test, const int* verify)
{
  int i;
  // Unrolled for faster verification
  for (i = 0; i < n/2*2; i+=2)
  {
    int t0 = test[i], t1 = test[i+1];
    int v0 = verify[i], v1 = verify[i+1];
    if (t0 != v0) return i+1;
    if (t1 != v1) return i+2;
  }
  if (n % 2 != 0 && test[n-1] != verify[n-1])
    return n;
  return 0;
}

static int verifyDouble(int n, const volatile double* test, const double* verify)
{
  int i;
  // Unrolled for faster verification
  for (i = 0; i < n/2*2; i+=2)
  {
    double t0 = test[i], t1 = test[i+1];
    double v0 = verify[i], v1 = verify[i+1];
    int eq1 = t0 == v0, eq2 = t1 == v1;
    if (!(eq1 & eq2)) return i+1+eq1;
  }
  if (n % 2 != 0 && test[n-1] != verify[n-1])
    return n;
  return 0;
}

static void __attribute__((noinline)) barrier(int ncores)
{
  static volatile int sense;
  static volatile int count;
  static __thread int threadsense;

  __sync_synchronize();

  threadsense = !threadsense;
  if (__sync_fetch_and_add(&count, 1) == ncores-1)
  {
    count = 0;
    sense = threadsense;
  }
  else while(sense != threadsense)
    ;

  __sync_synchronize();
}

static uint64_t lfsr(uint64_t x)
{
  uint64_t bit = (x ^ (x >> 1)) & 1;
  return (x >> 1) | (bit << 62);
}

static uintptr_t insn_len(uintptr_t pc)
{
  return (*(unsigned short*)pc & 3) ? 4 : 2;
}

#ifdef __riscv
#include "encoding.h"
#endif

#define stringify_1(s) #s
#define stringify(s) stringify_1(s)
#define stats(code, iter) do { \
    unsigned long _c = -read_csr(mcycle), _i = -read_csr(minstret); \
    code; \
    _c += read_csr(mcycle), _i += read_csr(minstret); \
    if (cid == 0) \
      printf("\n%s: %ld cycles, %ld.%ld cycles/iter, %ld.%ld CPI\n", \
             stringify(code), _c, _c/iter, 10*_c/iter%10, _c/_i, 10*_c/_i%10); \
  } while(0)

#endif //__UTIL_H
