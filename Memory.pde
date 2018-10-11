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
BIT    VALUE    MEANING
0      1-FFFE   Carry
1      2-FFFD   Zero
2      4-FFFB   Negative
3      8-FFF7   
4      16-FFEF  
5      32-FFDF  
6
7
8
9
a
b
c
d
e
f
*/
  
void incPC(){regPC++; if(regPC >= RAMSize){regPC = 0;}}
void decPC(){if(regPC <= 0){regPC = RAMSize;} regPC--;}

int regSP = 0;
char stack[] = new char[STKSize];
  
void push(char c){
  stack[regSP] = c;
  this.regSP++;
}
  
char pop(){
  this.regSP--;
  return stack[regSP];
}