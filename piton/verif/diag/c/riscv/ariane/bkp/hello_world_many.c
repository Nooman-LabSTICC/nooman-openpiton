// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// Author: Michael Schaffner <schaffner@iis.ee.ethz.ch>, ETH Zurich
// Date: 26.11.2018
// Description: Simple hello world program that prints the core id.
// Also runs correctly on manycore configs.
//

#include <stdint.h>
#include <stdio.h>
#include "util.h"

// synchronization variable
volatile static uint32_t amo_cnt = 0;

void print_core_1(){
  for(int i=0; i<5; i++){
    printf("Core 1 loop %d\n", i);
  }
}

void print_core_2(){
  for(int i=0; i<5; i++){
    printf("Core 2 loop %d\n", i);
  }
}

int main(int argc, char** argv) {



  int core_id = argv[0][0];

  
  if (core_id == 0){
    print_core_1();
  } else if (core_id == 1){
    print_core_2();
  }
  
  // synchronize with other cores and wait until it is this core's turn
  //while(argv[0][0] != amo_cnt);

  // assemble number and print
  //printf("Hello world, this is hart %d of %d harts!\n", argv[0][0], argv[0][1]);

  // increment atomic counter
  ATOMIC_OP(amo_cnt, 1, add, w);

  return 0;
}