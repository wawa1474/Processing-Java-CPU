/*
CISC?

Interrupts
  interrupt vector table?
    with changable address like registers?
    indirect jumps?
    executable code?
    acknowledge and inturrupt code with software interrupt handler
  when key typed?
  
reset
  reset vector?
    startup?
    software reset?
    user reset?
    watchdog reset?

keyboard
  have large boolean array of all keys?(do we automatically clear this or have software do it when a key is checked)
  have fifo array of keys that were pressed?
  maybe a single boolean of if a button is/was pressed?

Registers in RAM
  8?/16?
  Workspace register to locate registers in ram

Boot ROM?
  Loads code to ram then jumps to it?

Status Register
  Carry Flag
  Zero Flag
  Borrow Flag

Stack
  256/65536? Spaces
  Push/Pop regPC, regWP, regSP, regST, regAM, REGS 0-15

Addressing Modes
  IMMediate
  REGister
  InDirect
  RELative
  Register Indirect
  INdexed indirect
  INdexed Register indirect
  Indexed Register Offset indirect
  Register Indirect autoIncrement
  Register Indirect autoDecrement
  Register Indirect Pre-Decrement

CPU Information
  supported opcodes
  included hardware
  cpu version
  mmu type
  processing clocks
  ...

Nop
Halt

Compare
Call
Return
Jump

Increment/Decrement Register/Memory/Stack

And/Nand
Or/Nor
Xor/Xnor
Not/Negate

Logical/Arithmetic Rotate Left/Right
Carry/No Carry Shift Left/Right

Set/Clear Flags

Addition Carry/No Carry
Subtraction Borrow/No Borrow

Bit Set/Clear
Bit Test
Bit Test and Set
Bit Test and Clear
Bit Test and Invert
*/