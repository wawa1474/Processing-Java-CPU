class RAM{//RAM
  char contents[];
  
  public RAM(int size){
    contents = new char[size];
  }
}

int regPC;//Program Counter
int regA = 0, regF = 1;//Accumulator, Flags?
int regB = 2, regC = 3;//Registers B & C
int regD = 4, regE = 5;//Registers D & E
int regH = 6, regL = 7;//Registers H & L
int regI = 8;//Interrupt Vector
int regX = 9, regY = 10;//Index X, Index Y
boolean flagC, flagZ;//Carry, Zero
boolean flagO, flagN;//Overflow, Negative
boolean flagS, flagP;//Sign, Parity

char registers[] = {0,0,0,0,0,0,0,0,0,0,0};
String registerNames[] = {"regA", "regF",
                          "regB", "regC",
                          "regD", "regE",
                          "regH", "regL",
                          "regI",
                          "regX", "regY"};
  
void INCPC(){this.regPC++;}
void DECPC(){this.regPC--;}

void resetRegisters(){
  regPC = 0;//Program Counter
  registers[regA] = 0;registers[regF] = 0;
  registers[regB] = 0;registers[regC] = 0;
  registers[regD] = 0;registers[regE] = 0;
  registers[regH] = 0;registers[regL] = 0;
  registers[regI] = 0;
  registers[regX] = 0;registers[regY] = 0;
  flagC = false; flagZ = false;//Carry, Zero
  flagO = false; flagN = false;//Overflow, Negative
  flagS = false; flagP = false;//Sign, Parity
}


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