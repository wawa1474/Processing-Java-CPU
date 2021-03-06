char opcodeType;
char opcode;
char data;

int register;

void fetchOpcode(){
  opcode = char(workRAM.read(workRAM.pointer) >> 8);
  data = char(workRAM.read(workRAM.pointer) & 0xFF);
  //println("FO: " + hex(RAM_main.pointer) + " = " + hex(opcode));
  incPC();
}

void fetchData(){
  register = data;
  //print("FD: " + "reg = " + register);
  data = workRAM.read(workRAM.pointer);
  //println(", " + hex(RAM_main.pointer) + " = "  + hex(data));
  incPC();
  setRegister(data);
}

void storeData(){
  //print("SD: " + "Address = " + hex(mainRAM.contents[RAM_main.pointer]));
  workRAM.write(workRAM.pointer, workRAM.read(regWP + data));
  //println(", " + "Data = "  + hex(mainRAM.contents[regWP + data]));
  incPC();
}

void loadData(){
  //print("LD: " + "Address = " + hex(mainRAM.contents[regWP + (data & 0x0F)]));
  //print(", " + "'Data' = " + hex(data));
  //print(", " + "Data = "  + hex(mainRAM.contents[mainRAM.contents[regWP + (data & 0x0F)]]));
  //print(", " + "Register0 = "  + hex(((data >> 4) & 0x0F)));
  //println(", " + "Register1 = "  + hex(data & 0x0F));
  workRAM.write(regWP + ((data >> 4) & 0x0F), workRAM.read(workRAM.read(regWP + (data & 0x0F))));
  //incPC();
}

void storeRegister(){
  //print("SR: " + "Address = " + hex(mainRAM.contents[regWP + 0x0F]));
  workRAM.write(workRAM.read(regWP + 0x0F), workRAM.read(regWP + data));
  //println(", " + "Register = "  + hex(mainRAM.contents[regWP + data]));
}

void loadRegister(){//need to rewrit reto work
  //print("SR: " + "Address = " + hex(mainRAM.contents[regWP + 0x0F]));
  workRAM.write(workRAM.read(regWP + 0x0F), workRAM.read(regWP + data));
  //println(", " + "Register = "  + hex(mainRAM.contents[regWP + data]));
}

void fetchDataAddress(){
  register = 0;
  data = workRAM.read(workRAM.read(regWP + 0x0F));
  //println("FDA: " + hex(mainRAM.contents[regWP + 0x0F]) + " = "  + hex(data));
  setRegister(data);
}

void fetchAddress(){
  register = 0x0F;
  //print("Address: ");
  data = workRAM.read(workRAM.pointer);
  //println(hex(RAM_main.pointer) + " = "  + hex(data));
  incPC();
  setRegister(data);
}

char fetchRegister(){
  register = data;
  //println("FR: " + register);
  return workRAM.read(regWP + register);
}

void setRegister(char a){
  //print("SR: ");
  //print(hex(a));
  workRAM.write(regWP + register, a);
  //println("reg " + register + ": " + hex(mainRAM.contents[regWP + register]));
}

void decodeOpcode(){
  //println("DO: " + opcodeDNames[opcode]);
  char tmp;
  switch(opcode){
    case SINGLES://0x00XX
      decodeSingles();
      break;
    
    case AND:
      instructionAND();
      break;
      
    case LOAD:
      fetchData();
      break;
    
    case PRINT:
      tmp = fetchRegister();
      //println("reg " + register + ":" + hex(tmp));
      break;
    
    case PRNTA:
      fetchAddress();
      fetchDataAddress();
      //println("Address: " + hex(mainRAM.contents[regWP + 0x0F]) + ", Data: " + hex(mainRAM.contents[regWP]));
      break;
    
    case ADD:
      ADD(workRAM.read(regWP + ((data >> 4) & 0x0F)), workRAM.read(regWP + (data & 0x0F)));
      break;
    
    case COPY:
      workRAM.write(regWP + (data & 0x0F), workRAM.read(regWP + ((data >> 4) & 0x0F)));
      //println("reg " + hex(((data >> 4) & 0x07)) + ": " + hex(mainRAM.contents[regWP + ((data >> 4) & 0x07)]) + " -> " + "reg " + hex(data& 0x07) + ": " + hex(mainRAM.contents[regWP + (data& 0x07)]));
      break;
    
    case INSC:
      instructionCount = data + 1;
      break;
    
    case INSM:
      instructionMultiplyer = data + 1;
      break;
    
    case INSD:
      instructionDelay = data;
      break;
    
    case COMPARE:
      COMPARE(workRAM.read(regWP + (data & 0x0F)), workRAM.read(regWP + ((data >> 4) & 0x0F)));
      break;
    
    case STORE:
      storeData();
      break;
    
    case STOREREG:
      storeRegister();
      break;
    
    case INC:
      INC(regWP + data);
      break;
    
    case DEC:
      DEC(regWP + data);
      break;
    
    case STOREPIX:
      videoRAM.contents[workRAM.read(regWP + 0x0F)] = workRAM.read(regWP + data);
      break;
    
    case ZERO:
      workRAM.write(regWP + (data & 0x0F), char(0));
      break;
    
    case LOADDATA:
      loadData();
      break;
    
    case ADDI:
      ADDI(data, workRAM.read(workRAM.pointer));
      incPC();
      break;
    
    case RGILOAD:
      workRAM.write(regWP, workRAM.read(regWP + (data & 0x0F)));
      INC(regWP + (data & 0x0F));
      break;
    
    case RIJUMP:
      workRAM.pointer = workRAM.read(workRAM.read(regWP + (data & 0x0F)));
      break;
    
    case PUSHREG:
      stackRAM.push(workRAM.read(regWP + (data & 0x0F)));
      break;
    
    case POPREG:
      workRAM.write(regWP + (data & 0x0F), stackRAM.pop());
      break;
    
    case COMPAREREGS:
      COMPARE(workRAM.read(regWP + ((data >> 8) & 0x0F)), workRAM.read(regWP + (data & 0x0F)));
      break;
    
    case INDSTOREPIX:
      videoRAM.contents[workRAM.read(regWP + 0x0F)] = workRAM.read(workRAM.read(regWP + data));
      break;
    
    case AIINDSTOREPIX:
      videoRAM.contents[workRAM.read(regWP + 0x0F)] = workRAM.read(workRAM.read(regWP + data));
      INC(regWP + data);
      break;
    
    case LOADREGINSC:
      workRAM.write(regWP + data, (char)instructionCount);
      break;
    
    case REGCOMPAREIMM:
      COMPARE(workRAM.read(regWP + data), workRAM.read(workRAM.pointer));
      incPC();
      break;
    
    case LOADSPRITE:
      logo = new sprite((int)workRAM.read(workRAM.pointer + 1), workRAM.read(workRAM.pointer) & 0x00FF, (workRAM.read(workRAM.pointer) >> 8) & 0x00FF, (int)data);
      incPC();
      incPC();
      break;
    
    case LOADINDA:
      videoRAM.indA = data;
      break;
  }
}

void instructionADD(){
      //print("reg " + hex(((data >> 4) & 0x07)) + ": " + hex(mainRAM.contents[regWP + ((data >> 4) & 0x07)]) + " + " + "reg " + hex((data & 0x07)) + ": " + hex(mainRAM.contents[regWP + (data & 0x07)]));
      
      //println(" = reg " + hex(0) + ": " + hex(mainRAM.contents[regWP]));
}

void instructionADDI(){
      //print("reg " + hex(((data >> 4) & 0x07)) + ": " + hex(mainRAM.contents[regWP + ((data >> 4) & 0x07)]) + " + " + "reg " + hex((data & 0x07)) + ": " + hex(mainRAM.contents[regWP + (data & 0x07)]));
      
      //println(" = reg " + hex(0) + ": " + hex(mainRAM.contents[regWP]));
      
}

void instructionAND(){
      //print(regA);
      AND(workRAM.read(regWP), fetchRegister());
      //println("regA: " + hex(regA) + " AND " + hex(returnRegister()));
}

void jump(){
  workRAM.pointer = workRAM.read(workRAM.pointer);
}

void branch(){
  stackRAM.push(workRAM.pointer + 1);
  workRAM.pointer = workRAM.read(workRAM.pointer);
}

void decodeSingles(){
  //println("DS: " + opcodeSNames[data]);
  char tmp;
  switch(data){
    case NOP:
      break;
    
    case HALT:
      CPUHalt = true;
      break;
    
    case JUMPCARRY:
      if((regST & 0x0001) == 0x0001){
        //println("Carry: Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
        jump();
        break;
      }
      incPC();
      break;
    
    case JUMP:
      //println("Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
      jump();
      break;
    
    case JUMPNCARRY:
      if((regST & 0x0001) != 0x0001){
        //println("Not Carry: Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
        jump();
        break;
      }
      incPC();
      break;
    
    case COMPAREIMM:
      COMPARE(workRAM.read(regWP), workRAM.read(workRAM.pointer));
      incPC();
      break;
    
    case JUMPZERO:
      if((regST & 0x0002) == 0x0002){
        //println("Carry: Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
        jump();
        break;
      }
      incPC();
      break;
    
    case JUMPNZERO:
      if((regST & 0x0002) != 0x0002){
        //println("Not Carry: Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
        jump();
        break;
      }
      incPC();
      break;
    
    case JUMPBORROW:
      if((regST & 0x0004) == 0x0004){
        //println("Carry: Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
        jump();
        break;
      }
      incPC();
      break;
    
    case JUMPNBORROW:
      if((regST & 0x0004) != 0x0004){
        //println("Not Carry: Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
        jump();
        break;
      }
      incPC();
      break;
    
    case BRANCHCARRY:
      if((regST & 0x0001) == 0x0001){
        //println("Carry: Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
        branch();
        break;
      }
      incPC();
      break;
    
    case BRANCH:
      //println("Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
      branch();
      break;
    
    case BRANCHNCARRY:
      if((regST & 0x0001) != 0x0001){
        //println("Not Carry: Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
        branch();
        break;
      }
      incPC();
      break;
    
    case BRANCHZERO:
      if((regST & 0x0002) == 0x0002){
        //println("Carry: Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
        branch();
        break;
      }
      incPC();
      break;
    
    case BRANCHNZERO:
      if((regST & 0x0002) != 0x0002){
        //println("Not Carry: Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
        branch();
        break;
      }
      incPC();
      break;
    
    case BRANCHBORROW:
      if((regST & 0x0004) == 0x0004){
        //println("Carry: Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
        branch();
        break;
      }
      incPC();
      break;
    
    case BRANCHNBORROW:
      if((regST & 0x0004) != 0x0004){
        //println("Not Carry: Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
        branch();
        break;
      }
      incPC();
      break;
    
    case BRANCHRETURN:
      workRAM.pointer = stackRAM.pop();
      break;
    
    case KEYINPUT:
      if(keys[workRAM.read(workRAM.pointer)] == true){
        regST |= 0x0002;//set zero flag
        //println(int(mainRAM.contents[RAM_main.pointer]));
      }else{
        regST &= 0xFFFD;//clear zero flag
      }
      incPC();
      break;
    
    case INCINSC:
      instructionCount++;
      break;
    
    case INCINSM:
      instructionMultiplyer++;
      break;

    case SKIPZERO:
      if((regST & 0x0002) != 0x0002){
        //println("Not Carry: Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
        incPC();
      }
      break;
    
    case HARDRESET:
      hardReset();
      break;
    
    case INSCCOMPAREIMM:
      COMPARE((char)instructionCount, workRAM.read(workRAM.pointer));
      incPC();
      break;
    
    case INDXINC:
      videoRAM.indX += videoRAM.indA;
      break;
    
    case INDYINC:
      videoRAM.indY += videoRAM.indA;
      break;
    
    case DRAWSPRITE:
      logo.x = videoRAM.indX;
      logo.y = videoRAM.indY;
      logo.draw();
      break;
  }
}