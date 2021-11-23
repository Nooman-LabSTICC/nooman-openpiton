#ifndef __SEMAPHORE_H
#define __SEMAPHORE_H

#include "util.h"

/* Please don't access any members of this structure directly */
typedef struct {
	volatile unsigned int   lock;
	unsigned int		    count;
} semaphore;


static inline void sema_init(semaphore *sem, int val) {
    sem->lock = 0;
    sem->count = val;
}


/**********************************************/
/* RISC-V spin_lock and unlock implementations*/
static inline void riscv_spin_lock(semaphore *sem){
    int locked;
    //Spin lock
    do {
        ATOMIC_FETCH_OP(locked, sem->lock, 1, swap, w.aq);
    } while(locked);
}

static inline void riscv_unlock(semaphore *sem){
    ATOMIC_OP(sem->lock, 0, swap, w.rl);
}
/**********************************************/



/**********************************************/
/*UP and DOWN semaphore implementation*/

static inline void up(semaphore *sem){

    riscv_spin_lock(sem);

    sem->count++;
    
    riscv_unlock(sem);
}

static inline void down(semaphore *sem)
{

    //Down spin lock - while count == 0
	while (1){
		
		riscv_spin_lock(sem);

		//Once lock achieved, test value of count 
		if (sem->count > 0){
			//If count > 0 decrement the count
			sem->count--;
			//Release the lock
            riscv_unlock(sem);
			//Exit the while, releasing the thread
			break;
		} 
		//Case count == 0 releases the lock and try again
        riscv_unlock(sem);
	}

}

/**********************************************/

#endif //__SEMAPHORE_H