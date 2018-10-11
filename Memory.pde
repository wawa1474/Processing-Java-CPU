class RAM{//RAM
  char contents[];
  
  public RAM(int size){
    contents = new char[size];
  }
}

int regPC;//Program Counter
int regST;//Status Register
int regWP;//Workspace Pointer Register
  
void INCPC(){regPC++; if(regPC >= RAMSize){regPC = 0;}}
void DECPC(){if(regPC <= 0){regPC = RAMSize;} regPC--;}

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