//Misc
/*
NOP - No OPeration
HLT - HaLT
RET - RETurn from function
CPUID - returns information about CPU
*/

//Arithmetic and Logic
/*
ADD - Add two numbers into ACCumalator
ADC - Add two numbers into ACCumalator with carry

SUB - Subtract two numbers into ACCumalator
SBC - Subtract two numbers into ACCumalator with borrow

NEG - NEGate ACCumalator
NEGM - NEGate a Memory location

INC - INCrement Register
INCM - INC Memory location

DEC - DECrement Register
DECM - DEC Memory location

AND
NAND

OR
NOR

XOR
XNOR

NOT

ASL - Arithmetic Shift Left
ASR - Arithmetic Shift Right

LSL - Logical Shift Left
LSR - Logical Shift Right

ROL - ROtate Left
ROR - ROtate Right

SCF/SEC - SEt Carry
CCF/CLC - CLear Carry
*/

//Bit Testing
/*
BT - Test bit and set Carry if true
BTS - Test and Set bit and set Carry if true
BTR - Test and Reset bit and set Carry if true
BTC - Test and Invert bit and set carry if true
*/

//Jumps
//Set PC
/*
JP EQU - Jump if EQUAL
JP NEQ - Jump if NOT EQUAL

JP GT - Jump if GREATER THAN
JP LT - Jump if LESS THAN

JP GE - Jump if GREATER THAN OR EQUAL
JP LE - Jump if LESS THAN OR EQUAL

JP C  - Jump if CARRY
JP NC - Jump if NOT CARRY

JP B  - Jump if BORROW
JP NB - Jump if NOT BORROW

JP Z  - Jump if ZERO
JP NZ - Jump if NOT ZERO

JP    - Jump UNCONDITIONALY

JP BS - Jump if Bit Set
JP BC - Jump if Bit Clear

JP ??
*/

//Indirect Jumps
//Set PC to value at memory location pointed to by register
/*
JP EQU - Jump if EQUAL
JP NEQ - Jump if NOT EQUAL

JP GT - Jump if GREATER THAN
JP LT - Jump if LESS THAN

JP GE - Jump if GREATER THAN OR EQUAL
JP LE - Jump if LESS THAN OR EQUAL

JP C  - Jump if CARRY
JP NC - Jump if NOT CARRY

JP B  - Jump if BORROW
JP NB - Jump if NOT BORROW

JP Z  - Jump if ZERO
JP NZ - Jump if NOT ZERO

JP    - Jump UNCONDITIONALY

JP BS - Jump if Bit Set
JP BC - Jump if Bit Clear

JP ??
*/

//Relative Jumps/Branches
//Add Signed Value To PC
/*
JR EQU - Jump if EQUAL
JR NEQ - Jump if NOT EQUAL

JR GT - Jump if GREATER THAN
JR LT - Jump if LESS THAN

JR GE - Jump if GREATER THAN OR EQUAL
JR LE - Jump if LESS THAN OR EQUAL

JR C  - Jump if CARRY
JR NC - Jump if NOT CARRY

JR B  - Jump if BORROW
JR NB - Jump if NOT BORROW

JR Z  - Jump if ZERO
JR NZ - Jump if NOT ZERO

JR    - Jump UNCONDITIONALY

JR BS - Jump if Bit Set
JR BC - Jump if Bit Clear


JR ??
*/

//Function Calls
//Push PC, Set PC
/*
CALL EQU - Call Function if EQUAL
CALL NEQ - Call Function if NOT EQUAL

CALL GT - Call Function if GREATER THAN
CALL LT - Call Function if LESS THAN

CALL GE - Call Function if GREATER THAN OR EQUAL
CALL LE - Call Function if LESS THAN OR EQUAL

CALL C  - Call Function if CARRY
CALL NC - Call Function if NOT CARRY

CALL B  - Call Function if BORROW
CALL NB - Call Function if NOT BORROW

CALL Z  - Call Function if ZERO
CALL NZ - Call Function if NOT ZERO

CALL    - Call Function UNCONDITIONALY

CALL BS - Call Function if Bit Set
CALL BC - Call Function if Bit Clear


Call Function ??
*/

//Indirect Calls
//Push PC, Set PC to value at memory location pointed to by register
/*
CALL EQU - Call Function if EQUAL
CALL NEQ - Call Function if NOT EQUAL

CALL GT - Call Function if GREATER THAN
CALL LT - Call Function if LESS THAN

CALL GE - Call Function if GREATER THAN OR EQUAL
CALL LE - Call Function if LESS THAN OR EQUAL

CALL C  - Call Function if CARRY
CALL NC - Call Function if NOT CARRY

CALL B  - Call Function if BORROW
CALL NB - Call Function if NOT BORROW

CALL Z  - Call Function if ZERO
CALL NZ - Call Function if NOT ZERO

CALL    - Call Function UNCONDITIONALY

CALL BS - Call Function if Bit Set
CALL BC - Call Function if Bit Clear


Call Function ??
*/

//Indirect Calls
//Push PC, Set PC to value at memory location pointed to by register
/*
CALL EQU - Call Function if EQUAL
CALL NEQ - Call Function if NOT EQUAL

CALL GT - Call Function if GREATER THAN
CALL LT - Call Function if LESS THAN

CALL GE - Call Function if GREATER THAN OR EQUAL
CALL LE - Call Function if LESS THAN OR EQUAL

CALL C  - Call Function if CARRY
CALL NC - Call Function if NOT CARRY

CALL B  - Call Function if BORROW
CALL NB - Call Function if NOT BORROW

CALL Z  - Call Function if ZERO
CALL NZ - Call Function if NOT ZERO

CALL    - Call Function UNCONDITIONALY

CALL BS - Call Function if Bit Set
CALL BC - Call Function if Bit Clear


Call Function ??
*/

//Indexed Indirect Calls
//Push PC, Set PC to value at memory location pointed to by register + Index
/*
CALL EQU - Call Function if EQUAL
CALL NEQ - Call Function if NOT EQUAL

CALL GT - Call Function if GREATER THAN
CALL LT - Call Function if LESS THAN

CALL GE - Call Function if GREATER THAN OR EQUAL
CALL LE - Call Function if LESS THAN OR EQUAL

CALL C  - Call Function if CARRY
CALL NC - Call Function if NOT CARRY

CALL B  - Call Function if BORROW
CALL NB - Call Function if NOT BORROW

CALL Z  - Call Function if ZERO
CALL NZ - Call Function if NOT ZERO

CALL    - Call Function UNCONDITIONALY

CALL BS - Call Function if Bit Set
CALL BC - Call Function if Bit Clear


Call Function ??
*/