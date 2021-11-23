#ifndef _PREESM_COMMUNICATION_H
#define _PREESM_COMMUNICATION_H

#include "semaphore.h"
#include "preesm_defines.h"


semaphore interCoreSem[NB_CORES][NB_CORES];


void communicationInit() {
  int i, j;
  for (i = 0; i < NB_CORES; i++) {
    for (j = 0; j < NB_CORES; j++) {
      sema_init(&interCoreSem[i][j], 0);
    }
  }
}

void sendEnd() {
}

void receiveStart() {
}

#define sendStart(senderID, receiverID)     up(&interCoreSem[receiverID][senderID])
#define receiveEnd(senderID, receiverID)    down(&interCoreSem[receiverID][senderID])


#endif