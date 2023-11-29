# 465project
Verilog files for a 32-bit ALU capable of and, or, xor, sll, srl, sra, add, subtract, multiply, and divide.

Each "ALU" folder contains all verilog files required to simulate/synthesize/implement a complete ALU in vivado as well as a timing constraints file in .xdc format for vivado.

All results were obtained implementing on a Kria K26C SOM. All results shown in presentation were obtained from vivado's post-implementation utilization reports.

"Module_testbenches" contain testbenches used throughout the creation and editing process and were used for a mixture of debugging as well as standard testbenching, they were included for completeness though some may be obsolete now as final testbenching was done using complete ALU.
