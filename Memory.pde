class RAM{//RAM
  char contents[];
  
  public RAM(int size){
    contents = new char[size];
  }
}

int regPC;//Program Counter
int regWP;//Workspace Pointer Register

int regST;//Status Register
/*
BIT    VALUE    HEX    INVERSE   MEANING
0      1        0001 - FFFE      Carry
1      2        0002 - FFFD      Zero
2      4        0004 - FFFB      BORROW
3      8        0008 - FFF7      NONE
4      16       0010 - FFEF      NONE  
5      32       0020 - FFDF      NONE
6      64       0040 - FFBF      NONE
7      128      0080 - FF7F      NONE
8      256      0100 - FEFF      NONE
9      512      0200 - FDFF      NONE
a      1024     0400 - FBFF      NONE
b      2048     0800 - F7FF      NONE
c      4096     1000 - EFFF      NONE
d      8192     2000 - DFFF      NONE
e      16384    4000 - BFFF      NONE
f      32768    8000 - 7FFF      NONE
*/
  
void incPC(){regPC++; if(regPC >= RAMSize){regPC = 0;}}
void decPC(){if(regPC <= 0){regPC = RAMSize;} regPC--;}

int regSP = 0;
int stack[] = new int[STKSize];
  
void push(int c){
  stack[regSP] = c;
  regSP++;
}
  
int pop(){
  regSP--;
  return stack[regSP];
}