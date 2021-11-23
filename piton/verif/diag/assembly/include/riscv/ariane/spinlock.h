/* SPDX-License-Identifier: GPL-2.0-only */
/*
 * Copyright (C) 2015 Regents of the University of California
 * Copyright (C) 2017 SiFive
 */

#ifndef _ASM_RISCV_SPINLOCK_H
#define _ASM_RISCV_SPINLOCK_H

//#include "fence.h"

/*
 * Simple spin lock operations.  These provide no fairness guarantees.
 */

static inline int arch_spin_trylock(volatile unsigned int lock)
{
	int tmp = 1, busy;

	//If the lock is zero (busy == 0), its is free. 
	//Else, busy is 1, set 1 to busy and return false (busy == 1), since its lock

	__asm__ __volatile__ (
		"	amoswap.w %0, %2, %1\n"
		//RISCV_ACQUIRE_BARRIER //Commented because there are one hart per core
		: "=r" (busy), "+A" (lock)
		: "r" (tmp)
		: "memory");

	return !busy;
}


static inline void arch_unlock(volatile unsigned int lock)
{

	//Just decrement the lock by doing lock = lock - 1 (remember that lock is 1)
	__asm__ __volatile__(
		//RISCV_RELEASE_BARRIER //Commented because there are one hart per core
		"	amoadd.w x0, %1, %0\n"
		: "+A" (lock)
		: "r" (-1)
		: "memory");
}





/***********************************************************/
#if 0
static inline void arch_read_lock(arch_rwlock_t *lock)
{
	int tmp;

	__asm__ __volatile__(
		"1:	lr.w	%1, %0\n"
		"	bltz	%1, 1b\n"
		"	addi	%1, %1, 1\n"
		"	sc.w	%1, %1, %0\n"
		"	bnez	%1, 1b\n"
		RISCV_ACQUIRE_BARRIER
		: "+A" (lock->lock), "=&r" (tmp)
		:: "memory");
}

static inline void arch_write_lock(arch_rwlock_t *lock)
{
	int tmp;

	__asm__ __volatile__(
		"1:	lr.w	%1, %0\n"
		"	bnez	%1, 1b\n"
		"	li	%1, -1\n"
		"	sc.w	%1, %1, %0\n"
		"	bnez	%1, 1b\n"
		RISCV_ACQUIRE_BARRIER
		: "+A" (lock->lock), "=&r" (tmp)
		:: "memory");
}

static inline int arch_read_trylock(arch_rwlock_t *lock)
{
	int busy;

	__asm__ __volatile__(
		"1:	lr.w	%1, %0\n"
		"	bltz	%1, 1f\n"
		"	addi	%1, %1, 1\n"
		"	sc.w	%1, %1, %0\n"
		"	bnez	%1, 1b\n"
		RISCV_ACQUIRE_BARRIER
		"1:\n"
		: "+A" (lock->lock), "=&r" (busy)
		:: "memory");

	return !busy;
}

static inline int arch_write_trylock(arch_rwlock_t *lock)
{
	int busy;

	__asm__ __volatile__(
		"1:	lr.w	%1, %0\n"
		"	bnez	%1, 1f\n"
		"	li	%1, -1\n"
		"	sc.w	%1, %1, %0\n"
		"	bnez	%1, 1b\n"
		RISCV_ACQUIRE_BARRIER
		"1:\n"
		: "+A" (lock->lock), "=&r" (busy)
		:: "memory");

	return !busy;
}

#endif


#endif /* _ASM_RISCV_SPINLOCK_H */
