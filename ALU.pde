void XOR(char a, char b){//Exclusive OR
  //println("XOR");
  workRAM.write(regWP, char(a^b));
}

void XNOR(char a, char b){//Exclusive Not OR
  //println("XNOR");
  workRAM.write(regWP, char((a^b)^0xFFFF));
}

void AND(char a, char b){//And
  //println("reg 1: " + hex(a) + " & reg " + register + ": " + hex(b));
  workRAM.write(regWP, char(a&b));
}

void NAND(char a, char b){//Not AND
  //println("NAND");
  workRAM.write(regWP, char((a&b)^0xFFFF));
}

void OR(char a, char b){//OR
  //println("OR");
  workRAM.write(regWP, char(a|b));
}

void NOR(char a, char b){//Not OR
  //println("NOR");
  workRAM.write(regWP, char((a|b)^0xFFFF));
}

void NOT(char a){
  //println("NOT");
  workRAM.write(regWP, char(a^0xFFFF));
}

void INC(int addr_){
  if(workRAM.read(addr_) == 65535){
    regST |= 0x0001;
    //print("Carry!");
  }else{
    regST &= 0xFFFE;
  }
  workRAM.write(addr_, char(workRAM.read(addr_) + 1));
  if(workRAM.read(addr_) == 0){
    regST |= 0x0002;
    //print("Zero!");
  }else{
    regST &= 0xFFFD;
  }
}

void DEC(int addr_){
  if(workRAM.read(addr_) == 0){
    regST |= 0x0004;
    //print("BORROW!");
  }else{
    regST &= 0xFFFB;
  }
  workRAM.write(addr_, char(workRAM.read(addr_) - 1));
  if(workRAM.read(addr_) == 0){
    regST |= 0x0002;
    //print("Zero!");
  }else{
    regST &= 0xFFFD;
  }
}

void ADD(char a, char b){//ADDition
  //println("ADD");
  workRAM.write(regWP, char(a+b));
  if(int(a + b) > 65535){
    regST |= 0x0001;
    //print("Carry!");
  }else{
    regST &= 0xFFFE;
  }
  if(workRAM.read(regWP) == 0){
    regST |= 0x0002;
    //print("Zero!");
  }else{
    regST &= 0xFFFD;
  }
}

//void ADD(char out, char a, char b){//ADDition
//  //println("ADD");
//  int temp = a+b;
//  mainRAM.contents[out] = (char)temp;
//  if(temp > 65535){
//    regST |= 0x0001;
//    //print("Carry!");
//  }else{
//    regST &= 0xFFFE;
//  }
//  if((temp & 0xFFFF) == 0){
//    regST |= 0x0002;
//    //print("Zero!");
//  }else{
//    regST &= 0xFFFD;
//  }
//}

void ADDI(char reg, char imm){//ADDition
  //println("ADD");
  workRAM.write(regWP + (reg & 0x0F), char(workRAM.read(regWP + (reg & 0x0F)) + imm));
  if(int(workRAM.read(regWP + (reg & 0x0F)) + imm) > 65535){
    regST |= 0x0001;
    //print("Carry!");
  }else{
    regST &= 0xFFFE;
  }
  if(workRAM.read(regWP + (reg & 0x0F)) == 0){
    regST |= 0x0002;
    //print("Zero!");
  }else{
    regST &= 0xFFFD;
  }
}

void SUB(char a, char b){//SUBtraction
  println("SUB");
  workRAM.write(regWP, char(a-b));
  if(int(a - b) < 0){//A < B
    regST |= 0x0004;
    //print("BORROW!");
  }else{
    regST &= 0xFFFB;//A > B
  }
  if(workRAM.read(regWP) == 0){
    regST |= 0x0002;//A == B
    //print("Zero!");
  }else{
    regST &= 0xFFFD;//A != B
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
    regST |= 0x0004;//A < B
    //print("BORROW!");
  }else{
    regST &= 0xFFFB;//A > B
  }
  if(int(a - b) == 0){
    regST |= 0x0002;//A == B
    //print("Zero!");
  }else{
    regST &= 0xFFFD;//A != B
  }
}

void bitTest(int word, int bit){
  if((workRAM.read(word) & (0x01 << bit)) != 0){
    regST |= 0x0001;
    //print("Carry!");
  }else{
    regST &= 0xFFFE;
  }
}

void bitTestSet(int word, int bit){
  if((workRAM.read(word) & (0x01 << bit)) != 0){
    regST |= 0x0001;
    //print("Carry!");
  }else{
    regST &= 0xFFFE;
  }
  workRAM.write(word, char(workRAM.read(word) | (1 << bit)));
}

void bitTestReset(int word, int bit){
  if((workRAM.read(word) & (0x01 << bit)) != 0){
    regST |= 0x0001;
    //print("Carry!");
  }else{
    regST &= 0xFFFE;
  }
  workRAM.write(word, char(workRAM.read(word) & (1 << bit)));
}

void bitTestInvert(int word, int bit){
  if((workRAM.read(word) & (0x01 << bit)) != 0){
    regST |= 0x0001;
    //print("Carry!");
  }else{
    regST &= 0xFFFE;
  }
  workRAM.write(word, char(workRAM.read(word) ^ (1 << bit)));
}