void XOR(char a, char b){//Exclusive OR
  println("XOR");
  mainRAM.contents[regWP] = char(a^b);
}

void XNOR(char a, char b){//Exclusive Not OR
  println("XNOR");
  mainRAM.contents[regWP] = char((a^b)^0xFFFF);
}

void AND(char a, char b){//And
  println("reg 1: " + hex(a) + " & reg " + register + ": " + hex(b));
  mainRAM.contents[regWP] = char(a&b);
}

void NAND(char a, char b){//Not AND
  println("NAND");
  mainRAM.contents[regWP] = char((a&b)^0xFFFF);
}

void OR(char a, char b){//OR
  println("OR");
  mainRAM.contents[regWP] = char(a|b);
}

void NOR(char a, char b){//Not OR
  println("NOR");
  mainRAM.contents[regWP] = char((a|b)^0xFFFF);
}

void NOT(char a){
  println("NOT");
  mainRAM.contents[regWP] = char(a^0xFFFF);
}

void INC(char reg){
  mainRAM.contents[regWP + reg]++;
}

void ADD(char a, char b){//ADDition
  //println("ADD");
  mainRAM.contents[regWP] = char(a+b);
  if(int(a + b) > 65535){
    regST |= 0x0001;
    //print("Carry!");
  }else{
    regST &= 0xFFFE;
  }
  if(mainRAM.contents[regWP] == 0){
    regST |= 0x0002;
    //print("Zero!");
  }else{
    regST &= 0xFFFD;
  }
}

void SUB(char a, char b){//SUBtraction
  println("SUB");
  mainRAM.contents[regWP] = char(a-b);
  if(int(a - b) < 0){
    regST |= 0x0004;
    //print("Negative!");
  }else{
    regST &= 0xFFFB;
  }
  if(mainRAM.contents[regWP] == 0){
    regST |= 0x0002;
    //print("Zero!");
  }else{
    regST &= 0xFFFD;
  }
}

void COMPARE(char a, char b){//Compare
  if(int(a + b) > 65535){
    regST |= 0x0001;
    //print("Carry!");
  }else{
    regST &= 0xFFFE;
  }
  if(int(a - b) < 0){
    regST |= 0x0004;
    //print("Negative!");
  }else{
    regST &= 0xFFFB;
  }
  if(int(a - b) == 0){
    regST |= 0x0002;
    //print("Zero!");
  }else{
    regST &= 0xFFFD;
  }
}