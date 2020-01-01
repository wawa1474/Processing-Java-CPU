//Misc
/*
NOP - No OPeration
HLT - HaLT
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
NEGS - NEGate a Stack location

INC - INCrement Register
INCM - INC Memory location
INCS - INC Stack location

DEC - DECrement Register
DECM - DEC Memory location
DECS - DEC Stack location

AND
NAND

OR
NOR

XOR
XNOR

NOT
INVERT

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
BTC - Test and complement(invert) bit and set carry if true

//Bit Manipulation
bit copy
bit store

mainRAM.contents[500] = 0x0001;
  bitTest(500, 0);
  println(hex(mainRAM.contents[500]) + ", " + hex(regST));
  bitTestReset(500, 0);
  println(hex(mainRAM.contents[500]) + ", " + hex(regST));
  bitTestSet(500, 0);
  println(hex(mainRAM.contents[500]) + ", " + hex(regST));
  bitTestInvert(500, 0);
  println(hex(mainRAM.contents[500]) + ", " + hex(regST));
*/

//Immediate Jumps
//Set PC to immediate
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

//Immediate Calls
//Push PC, Set PC to immediate
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


//Pop PC
/*
RTN EQU - Return From Function if EQUAL
RTN NEQ - Return From Function if NOT EQUAL

RTN GT - Return From Function if GREATER THAN
RTN LT - Return From Function if LESS THAN

RTN GE - Return From Function if GREATER THAN OR EQUAL
RTN LE - Return From Function if LESS THAN OR EQUAL

RTN C  - Return From Function if CARRY
RTN NC - Return From Function if NOT CARRY

RTN B  - Return From Function if BORROW
RTN NB - Return From Function if NOT BORROW

RTN Z  - Return From Function if ZERO
RTN NZ - Return From Function if NOT ZERO

RTN    - Return From Function UNCONDITIONALY

RTN BS - Return From Function if Bit Set
RTN BC - Return From Function if Bit Clear


RTN Function ??
*/