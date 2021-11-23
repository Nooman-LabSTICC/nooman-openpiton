#ifndef __BARRIER_H
#define __BARRIER_H

#include "util.h"

typedef struct {
	volatile int bar; //Counts the number of thread that hit the barrier
    volatile int passed; //Count the number of passed barriers
    int P; //Stores the total number of threads
} m_barrier;

static inline void barrier_init(m_barrier *barr, int thread_number){
    barr->P = thread_number;
    barr->bar = 0; // Counter of threads, faced barrier.
    barr->passed = 0; // Number of barriers, passed by all threads.
}

static inline void barrier_wait(m_barrier *barr){

    int bar_ret, passed_old;
    //int passed_old = barr->passed; // Should be evaluated before incrementing *bar*!
    ATOMIC_FETCH_OP(passed_old, barr->passed, 0, add, w);
    
    //do { Maybe can fix an error of fast threads -- need to test more
    //Increment bar
    ATOMIC_FETCH_OP(bar_ret, barr->bar, 1, add, w);
    //} while(bar_ret < barr->P);
    
    //Test if all threads reached the barrier
    if(bar_ret == (barr->P - 1)) {

        //The last thread to reach the barrier will update the control params.
        //passed++
        ATOMIC_OP(barr->passed, 1, add, w);
        //bar = 0
        ATOMIC_OP(barr->bar, 0, swap, w);

    } else {
        // If Not the last thread. Wait others.
         do {
            ATOMIC_OP(barr->passed, 0, add, w);
         } while(barr->passed == passed_old);
    }
   
}


#endif //__BARRIER_H