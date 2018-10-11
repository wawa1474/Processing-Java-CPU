enum OPCODES {NOP, AND, LOAD, HALT, PRINT, PRNTA};
char opcode;
char data;

int register;

void fetchOpcode(){
  opcode = char(mainRAM.contents[regPC] >> 8);
  data = char(mainRAM.contents[regPC] & 0xFF);
  println("FO: " + hex(regPC) + " = " + hex(opcode));
  INCPC();
}

void fetchData(){
  register = data;
  print("FD: " + "REG = " + registerNames[register]);
  data = mainRAM.contents[regPC];
  println(", " + hex(regPC) + " = "  + hex(data));
  INCPC();
  setRegister(data);
}

void fetchDataAddress(){
  register = regA;
  data = mainRAM.contents[registers[regX]];
  println("FDA: " + hex(registers[regX]) + " = "  + hex(data));
  setRegister(data);
}

void fetchAddress(){
  register = regX;
  print("Address: ");
  data = mainRAM.contents[regPC];
  println(hex(regPC) + " = "  + hex(data));
  INCPC();
  setRegister(data);
}

char fetchRegister(){
  register = data;
  println("FR: " + registerNames[register]);
  return registers[register];
}

void setRegister(char a){
  print("SR: ");
  //print(hex(a));
  registers[register] = a;
  println(registerNames[register] + ": " + hex(registers[register]));
}

void decodeOpcode(){
  OPCODES decode = OPCODES.values()[opcode];
  println("DO: " + decode);
  char tmp;
  switch(decode){
    case NOP:
      break;
    
    case AND:
      //print(regA);
      AND(registers[regA], fetchRegister());
      //println("regA: " + hex(regA) + " AND " + hex(returnRegister()));
      break;
      
    case LOAD:
      fetchData();
      break;
    
    case HALT:
      CPUHalt = true;
      break;
    
    case PRINT:
      tmp = fetchRegister();
      println(registerNames[register] + ":" + hex(tmp));
      break;
    
    case PRNTA:
      fetchAddress();
      fetchDataAddress();
      println("Address: " + hex(registers[regX]) + ", Data: " + hex(registers[regA]));
      break;
  }
}