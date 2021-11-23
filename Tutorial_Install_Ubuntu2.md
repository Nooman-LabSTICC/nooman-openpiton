# Tutorial Instalation OpenPiton - Lab-STICC on Ubuntu 20.04


* Install packages:
    > sudo apt-get install gcc git

* Clone OpenPiton from Lab-STICC git:
   > git clone https://github.com/Nooman-LabSTICC/openpiton.git

* Define Enviroment variables:
  * Edit your .bashrc, add this code at end:  
    > #OPEN_PITON_ARIANE  
    export PITON_ROOT=/home/**<user>**/openpiton
    export PATH=\${PITON_ROOT}/bin:${PATH}  
    cd $PITON_ROOT; source $PITON_ROOT/piton/ariane_setup.sh; cd -
   