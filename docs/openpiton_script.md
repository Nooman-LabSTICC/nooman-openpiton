Tutorial of **openpiton** command
============
Edited: 11.Oct.2021, by Marcelo Ruaro

The **openpiton** command abstract significantly the OpenPiton generation, execution, and debugging process. Making more easy the sims command and focusing on what is really important.

How to make this command visible?
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



