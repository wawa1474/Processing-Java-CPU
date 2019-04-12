char opcodeType;
char opcode;
char data;

int register;

void fetchOpcode(){
  opcode = char(workRAM.contents[workRAM.pointer] >> 8);
  data = char(workRAM.contents[workRAM.pointer] & 0xFF);
  //println("FO: " + hex(RAM_main.pointer) + " = " + hex(opcode));
  incPC();
}

void fetchData(){
  register = data;
  //print("FD: " + "reg = " + register);
  data = workRAM.contents[workRAM.pointer];
  //println(", " + hex(RAM_main.pointer) + " = "  + hex(data));
  incPC();
  setRegister(data);
}

void storeData(){
  //print("SD: " + "Address = " + hex(mainRAM.contents[RAM_main.pointer]));
  workRAM.contents[workRAM.pointer] = workRAM.contents[regWP + data];
  //println(", " + "Data = "  + hex(mainRAM.contents[regWP + data]));
  incPC();
}

void loadData(){
  //print("LD: " + "Address = " + hex(mainRAM.contents[regWP + (data & 0x0F)]));
  //print(", " + "'Data' = " + hex(data));
  //print(", " + "Data = "  + hex(mainRAM.contents[mainRAM.contents[regWP + (data & 0x0F)]]));
  //print(", " + "Register0 = "  + hex(((data >> 4) & 0x0F)));
  //println(", " + "Register1 = "  + hex(data & 0x0F));
  workRAM.contents[regWP + ((data >> 4) & 0x0F)] = workRAM.contents[workRAM.contents[regWP + (data & 0x0F)]];
  //incPC();
}

void storeRegister(){
  //print("SR: " + "Address = " + hex(mainRAM.contents[regWP + 0x0F]));
  workRAM.contents[workRAM.contents[regWP + 0x0F]] = workRAM.contents[regWP + data];
  //println(", " + "Register = "  + hex(mainRAM.contents[regWP + data]));
}

void loadRegister(){//need to rewrit reto work
  //print("SR: " + "Address = " + hex(mainRAM.contents[regWP + 0x0F]));
  workRAM.contents[workRAM.contents[regWP + 0x0F]] = workRAM.contents[regWP + data];
  //println(", " + "Register = "  + hex(mainRAM.contents[regWP + data]));
}

void fetchDataAddress(){
  register = 0;
  data = workRAM.contents[workRAM.contents[regWP + 0x0F]];
  //println("FDA: " + hex(mainRAM.contents[regWP + 0x0F]) + " = "  + hex(data));
  setRegister(data);
}

void fetchAddress(){
  register = 0x0F;
  //print("Address: ");
  data = workRAM.contents[workRAM.pointer];
  //println(hex(RAM_main.pointer) + " = "  + hex(data));
  incPC();
  setRegister(data);
}

char fetchRegister(){
  register = data;
  //println("FR: " + register);
  return workRAM.contents[regWP + register];
}

void setRegister(char a){
  //print("SR: ");
  //print(hex(a));
  workRAM.contents[regWP + register] = a;
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
      ADD(workRAM.contents[regWP + ((data >> 4) & 0x0F)], workRAM.contents[regWP + (data & 0x0F)]);
      break;
    
    case COPY:
      workRAM.contents[regWP + (data & 0x0F)] = workRAM.contents[regWP + ((data >> 4) & 0x0F)];
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
      COMPARE(workRAM.contents[regWP + (data & 0x0F)], workRAM.contents[regWP + ((data >> 4) & 0x0F)]);
      break;
    
    case STORE:
      storeData();
      break;
    
    case STOREREG:
      storeRegister();
      break;
    
    case INC:
      INC(data);
      break;
    
    case DEC:
      DEC(data);
      break;
    
    case STOREPIX:
      videoRAM.contents[workRAM.contents[regWP + 0x0F]] = workRAM.contents[regWP + data];
      break;
    
    case ZERO:
      workRAM.contents[regWP + (data & 0x0F)] = 0;
      break;
    
    case LOADDATA:
      loadData();
      break;
    
    case ADDI:
      ADDI(data, workRAM.contents[workRAM.pointer]);
      incPC();
      break;
    
    case RGILOAD:
      workRAM.contents[regWP] = workRAM.contents[regWP + (data & 0x0F)];
      workRAM.contents[regWP + (data & 0x0F)]++;
      break;
    
    case RIJUMP:
      workRAM.pointer = workRAM.contents[workRAM.contents[regWP + (data & 0x0F)]];
      break;
    
    case PUSHREG:
      stackRAM.push(workRAM.contents[regWP + (data & 0x0F)]);
      break;
    
    case POPREG:
      workRAM.contents[regWP + (data & 0x0F)] = stackRAM.pop();
      break;
    
    case COMPAREREGS:
      COMPARE(workRAM.contents[regWP + ((data >> 8) & 0x0F)], workRAM.contents[regWP + (data & 0x0F)]);
      break;
    
    case INDSTOREPIX:
      videoRAM.contents[workRAM.contents[regWP + 0x0F]] = workRAM.contents[workRAM.contents[regWP + data]];
      break;
    
    case AIINDSTOREPIX:
      videoRAM.contents[workRAM.contents[regWP + 0x0F]] = workRAM.contents[workRAM.contents[regWP + data]];
      workRAM.contents[regWP + data]++;
      break;
    
    case LOADREGINSC:
      workRAM.contents[regWP + data] = (char)instructionCount;
      break;
    
    case REGCOMPAREIMM:
      COMPARE(workRAM.contents[regWP + data], workRAM.contents[workRAM.pointer]);
      incPC();
      break;
    
    case LOADSPRITE:
      logo = new sprite((int)workRAM.contents[workRAM.pointer + 1], workRAM.contents[workRAM.pointer] & 0x00FF, (workRAM.contents[workRAM.pointer] >> 8) & 0x00FF, (int)data);
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
      AND(workRAM.contents[regWP], fetchRegister());
      //println("regA: " + hex(regA) + " AND " + hex(returnRegister()));
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
        workRAM.pointer = workRAM.contents[workRAM.pointer];
        break;
      }
      incPC();
      break;
    
    case JUMP:
      //println("Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
      workRAM.pointer = workRAM.contents[workRAM.pointer];
      break;
    
    case JUMPNCARRY:
      if((regST & 0x0001) != 0x0001){
        //println("Not Carry: Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
        workRAM.pointer = workRAM.contents[workRAM.pointer];
        break;
      }
      incPC();
      break;
    
    case COMPAREIMM:
      COMPARE(workRAM.contents[regWP], workRAM.contents[workRAM.pointer]);
      incPC();
      break;
    
    case JUMPZERO:
      if((regST & 0x0002) == 0x0002){
        //println("Carry: Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
        workRAM.pointer = workRAM.contents[workRAM.pointer];
        break;
      }
      incPC();
      break;
    
    case JUMPNZERO:
      if((regST & 0x0002) != 0x0002){
        //println("Not Carry: Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
        workRAM.pointer = workRAM.contents[workRAM.pointer];
        break;
      }
      incPC();
      break;
    
    case JUMPBORROW:
      if((regST & 0x0004) == 0x0004){
        //println("Carry: Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
        workRAM.pointer = workRAM.contents[workRAM.pointer];
        break;
      }
      incPC();
      break;
    
    case JUMPNBORROW:
      if((regST & 0x0004) != 0x0004){
        //println("Not Carry: Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
        workRAM.pointer = workRAM.contents[workRAM.pointer];
        break;
      }
      incPC();
      break;
    
    case BRANCHCARRY:
      if((regST & 0x0001) == 0x0001){
        //println("Carry: Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
        stackRAM.push(workRAM.pointer + 1);
        workRAM.pointer = workRAM.contents[workRAM.pointer];
        break;
      }
      incPC();
      break;
    
    case BRANCH:
      //println("Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
      stackRAM.push(workRAM.pointer);
      workRAM.pointer = workRAM.contents[workRAM.pointer];
      break;
    
    case BRANCHNCARRY:
      if((regST & 0x0001) != 0x0001){
        //println("Not Carry: Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
        stackRAM.push(workRAM.pointer + 1);
        workRAM.pointer = workRAM.contents[workRAM.pointer];
        break;
      }
      incPC();
      break;
    
    case BRANCHZERO:
      if((regST & 0x0002) == 0x0002){
        //println("Carry: Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
        stackRAM.push(workRAM.pointer + 1);
        workRAM.pointer = workRAM.contents[workRAM.pointer];
        break;
      }
      incPC();
      break;
    
    case BRANCHNZERO:
      if((regST & 0x0002) != 0x0002){
        //println("Not Carry: Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
        stackRAM.push(workRAM.pointer + 1);
        workRAM.pointer = workRAM.contents[workRAM.pointer];
        break;
      }
      incPC();
      break;
    
    case BRANCHBORROW:
      if((regST & 0x0004) == 0x0004){
        //println("Carry: Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
        stackRAM.push(workRAM.pointer + 1);
        workRAM.pointer = workRAM.contents[workRAM.pointer];
        break;
      }
      incPC();
      break;
    
    case BRANCHNBORROW:
      if((regST & 0x0004) != 0x0004){
        //println("Not Carry: Jump -> " + hex(mainRAM.contents[RAM_main.pointer]));
        stackRAM.push(workRAM.pointer + 1);
        workRAM.pointer = workRAM.contents[workRAM.pointer];
        break;
      }
      incPC();
      break;
    
    case BRANCHRETURN:
      workRAM.pointer = stackRAM.pop();
      break;
    
    case KEYINPUT:
      if(keys[workRAM.contents[workRAM.pointer]] == true){
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
      COMPARE((char)instructionCount, workRAM.contents[workRAM.pointer]);
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