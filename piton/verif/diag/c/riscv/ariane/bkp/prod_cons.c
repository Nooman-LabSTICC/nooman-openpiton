
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

m_barrier barrier_it;
semaphore mutex;


void producer(){
    int item = 0;
    while(1){
        down(&mutex);
        printf("Producer %d\n",item++);
        up(&mutex);
    }

}

void consumer(){
    int item = 0;
    //barrier_wait(&barrier_it, 2);
    while(1){
        down(&mutex);
        printf("Consumer %d\n",item++);
        up(&mutex);
    }
    
}

int main(int argc, char** argv) {

    uint32_t core_id, core_num;
    core_id = argv[0][0];
    core_num = argv[0][1];

    sema_init(&mutex, 1);
    barrier_init(&barrier_it, 2);

    switch(core_id){
        case 0:
            producer();
            break;
        case 1:
            consumer();
            break;
        default:
            printf("ERROR, unknown core_id = %d\n", core_id);
    }


    //volatile static uint32_t amo_lrsc[20];

    
    return 0;

}
