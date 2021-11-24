# Credits
This many-core project is based on OpenPiton, an open-source many-core platform developed by Princeton University. We use OpenPiton as starting point to do our modifications. Please don't forget to cite OpenPiton properly if you use the many-core herein provided.


[Link to OpenPiton's original project](https://github.com/PrincetonUniversity/openpiton)



# Tutorial Instalation OpenPiton - Lab-STICC on Ubuntu 20.04

## Prerequisites
* Install packages:
  ```c
  sudo apt install git python gcc-7 g++-7 gperf autoconf automake autotools-dev libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo python-pexpect libusb-1.0-0-dev default-jdk zlib1g-dev valgrind csh
    ```

* Prepare your terminal
  * Edit your terminal to "Run a custom command instead of my shell" (search this entire sentence in google):
  * Add this custom command in the text field:
    ```c
    bash --login
    ```
  * Restart your terminal
  

## Clone OpenPiton
* Clone OpenPiton from Lab-STICC git:
   ```c
    git clone https://github.com/Nooman-LabSTICC/openpiton.git
   ```

## Set Enviroments Variables

  
  * OPENPITON: 
  ```
    #OPEN_PITON_ARIANE  
    export PITON_ROOT=/home/**username**/openpiton  
    export PATH=\${PITON_ROOT}/bin:${PATH}  
    cd \$PITON_ROOT; source $PITON_ROOT/piton/ariane_setup.sh; cd -
  ```

* Close and open your terminal again.
  
## RISC-V Toolchain
* Go to $PITON_ROOT:
    ```c
    cd $PITON_ROOT
    ```
* Install risc-v toolchain:
    ```c
    .piton/design/chip/tile/ariane/ci/build-riscv-gcc.sh
    ```
    * Wait the installation process. It takes time.
    * When finished, it will install risc-v inside ~/riscv_install
    * To check if risc-v was installed, type the command and pres TAB two times. It must show all extensions programs of the toolchain.
      ```c
      riscv64-unknown-elf-
      ```

## Verilator
* Go to $PITON_ROOT:
    ```c
    cd $PITON_ROOT
    ```
* Install Verilator:
    ```c
    ./piton/design/chip/tile/ariane/ci/install-verilator.sh
    ```

## QuestaSim
* Install QuestaSim following the own tool instructions
* Make sure that the command vsim is running/working from your terminal

<br/><br/>

Tutorial of **openpiton** command (used to run testcases)
============
Edited: 11.Oct.2021, by Marcelo Ruaro

The **openpiton** command abstract significantly the OpenPiton generation, execution, and debugging process. Making more easy the sims command and focusing on what is really important.

How to make this command visible (ignore if you already set this)?
---------------
Export in your .bashrc the openpiton/bin path:
```c
export PITON_ROOT=/home/user_name/openpiton
export PATH=${PITON_ROOT}/bin:${PATH}
```

Mandatory arguments
---------------
* *X_DIMMENSION*: 1st argument is an integer positive number representing the X dimmension
* *Y_DIMMENSION*:  2nd argument is an integer positive number representing the Y dimmension
  

  

Optional arguments (-run or -gen or -all is mandatory):
---------------
* **-gen**: Generates the manycore model according to the XY dimmension
  * Ex: ``` openpiton 2 1 -gen ```
* **-run**: Runs the manycore model in the specified testcase. Requires a testcase name
  * Ex: ```openpiton 2 1 -run prod_cons```
* **-vsim**: Runs and opens the modelsim. Must be used with the *-run* command.
  * Ex: ```openpiton 2 1 -run prod_cons -vsim```
* **-wave**: Generate the wave.do to be loaded in modelsim. Must be used with the *-run* command.
  * Ex: ```openpiton 2 1 -run prod_cons -vsim -wave```
* **-debug**: Open the graphical debugger. Must be used with the *-run* command.
  *  Ex.1: ```openpiton 2 1 -run prod_cons -vsim -wave -debug```
  *  Ex.1: ```openpiton 2 1 -run prod_cons -debug```

## Running an example

```c
openpiton 3 3 -all syn_parallel_9cores -debug
```

    
   