enum OPCODES {NOP, AND, LOAD, HALT, PRINT, PRNTA};
char opcode;
char data;

int register;

void fetchOpcode(){
  opcode = mainRAM.contents[regPC];
  println("FO: " + hex(regPC) + " = " + hex(opcode));
  INCPC();
}

void fetchData(){
  register = int(mainRAM.contents[regPC]);
  print("FD: " + hex(regPC) + " = " + registerNames[register]);
  INCPC();
  data = mainRAM.contents[regPC];
  print(", " + hex(regPC) + " = "  + hex(data));
  INCPC();
  data = char((data << 8) | mainRAM.contents[regPC]);
  println(", " + hex(regPC) + " = "  + hex(char(data & 0x00FF)));
  INCPC();
  setRegister(data);
}

void fetchDataAddress(){
  char tempx = char(registers[regX]);
  register = regA;
  data = mainRAM.contents[registers[regX]];
  print("FDA: " + hex(registers[regX]) + " = "  + hex(data));
  if(registers[regX] >= 65535){tempx = 0;}else{tempx++;}
  data = char((data << 8) | mainRAM.contents[tempx]);
  println(", " + hex(regPC) + " = "  + hex(char(data & 0x00FF)));
  setRegister(data);
}

void fetchAddress(){
  register = regX;
  print("Address: ");
  data = mainRAM.contents[regPC];
  print(hex(regPC) + " = "  + hex(data));
  INCPC();
  data = char((data << 8) | mainRAM.contents[regPC]);
  println(", " + hex(regPC) + " = "  + hex(char(data & 0x00FF)));
  INCPC();
  setRegister(data);
}

char fetchRegister(){
  register = int(mainRAM.contents[regPC]);
  println("FR: " + registerNames[register]);
  INCPC();
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