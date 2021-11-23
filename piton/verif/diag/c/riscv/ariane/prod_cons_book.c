
// Author: Marcelo Ruaro <marcelo.ruaro@univ-ubs.fr>, UBS Lorient
// Date: 05.05.2021
// Description: Simple dataflow application implementing fork and join
//
#include <stdint.h>
#include <stdio.h>
#include "util.h"
#include "semaphore.h"
#include "barrier.h"

#define N 5

#define LOOP_SIZE 1

semaphore mutex;
semaphore empty;
semaphore full;

//Barrier descriptor
m_barrier iter_barrier;

void insert_item(int index){
    printf("Prod inserting %d\n", index);
}

void consume_item(int index){
    printf("Cons removing %d\n", index);
}   

//#define	 L2_ACCESS_COUNTER	0xAA
//#define	 L2_MISS_COUNTER	0xAB

void producer(){
    //float b, a = 2.5f;
    for(int index=0;index<LOOP_SIZE;index++){
        down(&empty);
        down(&mutex);
        insert_item(full.count);
        up(&mutex);
        up(&full);

        barrier_wait(&iter_barrier);

        //b = a / 0.5f;
        //printf("T: %d\n", (int)b);
    }

    printf("Producer end\n");

}

void consumer(){
    //barrier_wait(&barrier_it, 2);

    for(int index=0;index<LOOP_SIZE;index++){
        down(&full);
        down(&mutex);
        consume_item(full.count);
        up(&mutex);
        up(&empty);
        //Just to make consumer slower than producer
        for (volatile int i = 0; i < 200; i++);

        barrier_wait(&iter_barrier);
        
    }

    printf("Consumer end\n");
}

int main(int argc, char** argv) {

    uint32_t core_id, core_num;
    core_id = argv[0][0];
    core_num = argv[0][1];

    sema_init(&mutex, 1);
    sema_init(&empty, N);
    sema_init(&full, 0);

    barrier_init(&iter_barrier, 2); //2 is number of threads

    printf("Program started\n");
    switch(core_id){
        case 0:
            printf("calling producer\n");
            producer();
            break;
        case 1:
            printf("calling consumer\n");
            consumer();
            break;
        default:
            printf("Empty ID: core_id\n");
            //printf("ERROR, unknown core_id = %d\n", core_id);
            break;
    }


    return 0;

}
