
// Author: Marcelo Ruaro <marcelo.ruaro@univ-ubs.fr>, UBS Lorient
// Date: 05.05.2021
// Description: Simple printf test
//
#include <stdint.h>
#include <stdio.h>
#include "util.h"

volatile int a = 0xF0DAEB0A;

int main(int argc, char** argv) {

    uint32_t core_id, core_num;
    volatile int i = 0;
    volatile int v[100];

    core_id = argv[0][0];

    if (core_id == 0){

        printf("Print test\n");
        printf("AddrA: %p\n", &a);
        printf("AddrI: %p\n", &i);
        printf("AddrV: %p\n", v);
        
        while (i < 20){
            v[i] = a+i;
            i++;
            //printf("%x\n", a);
        } 
    } else {
        printf("Idle core\n");
    }


    return 0;

}
/**
Print test
AddrA: 0x80000b90
AddrI: 0x8002094c
AddrV: 0x80020950

 */