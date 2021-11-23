
// Author: Marcelo Ruaro <marcelo.ruaro@univ-ubs.fr>, UBS Lorient
// Date: 05.05.2021
// Description: Simple dataflow application implementing fork and join
//
#include <stdint.h>
#include <stdio.h>
#include "util.h"
#include "semaphore.h"

semaphore sema_1;
semaphore sema_2;
m_barrier barrier_it;

void Core1(){
    for(int i=0; i<5; i++){
        barrier_wait(&barrier_it, 1);
        //printf("Core 1 loop %d\n", i);
    }
}

void Core2(){
    for(int i=0; i<5; i++){
        barrier_wait(&barrier_it, 2);
        //printf("Core 2 loop %d\n", i);
        for (volatile int k = 0; k < 500; k++);
        
    }
}


int main(int argc, char** argv) {

    uint32_t core_id, core_num;

    sema_init(&sema_1, 1);
    barrier_init(&barrier_it, 2);

    core_id = argv[0][0];
    core_num = argv[0][1];

    switch(core_id){
        case 0:
            Core1();
            break;
        case 1:
            Core2();
            break;
        default:
            printf("ERROR, unknown core_id = %d\n", core_id);
    }


    //volatile static uint32_t amo_lrsc[20];

    
    return 0;

}
