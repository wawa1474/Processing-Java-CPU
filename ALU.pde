void XOR(char a, char b){//Exclusive OR
  //println("XOR");
  workRAM.contents[regWP] = char(a^b);
}

void XNOR(char a, char b){//Exclusive Not OR
  //println("XNOR");
  workRAM.contents[regWP] = char((a^b)^0xFFFF);
}

void AND(char a, char b){//And
  //println("reg 1: " + hex(a) + " & reg " + register + ": " + hex(b));
  workRAM.contents[regWP] = char(a&b);
}

void NAND(char a, char b){//Not AND
  //println("NAND");
  workRAM.contents[regWP] = char((a&b)^0xFFFF);
}

void OR(char a, char b){//OR
  //println("OR");
  workRAM.contents[regWP] = char(a|b);
}

void NOR(char a, char b){//Not OR
  //println("NOR");
  workRAM.contents[regWP] = char((a|b)^0xFFFF);
}

void NOT(char a){
  //println("NOT");
  workRAM.contents[regWP] = char(a^0xFFFF);
}

void INC(char reg){
  if(workRAM.contents[regWP + reg] == 65535){
    regST |= 0x0001;
    //print("Carry!");
  }else{
    regST &= 0xFFFE;
  }
  workRAM.contents[regWP + reg]++;
  if(workRAM.contents[regWP + reg] == 0){
    regST |= 0x0002;
    //print("Zero!");
  }else{
    regST &= 0xFFFD;
  }
}

void DEC(char reg){
  if(workRAM.contents[regWP + reg] == 0){
    regST |= 0x0004;
    //print("BORROW!");
  }else{
    regST &= 0xFFFB;
  }
  workRAM.contents[regWP + reg]--;
  if(workRAM.contents[regWP + reg] == 0){
    regST |= 0x0002;
    //print("Zero!");
  }else{
    regST &= 0xFFFD;
  }
}

void ADD(char a, char b){//ADDition
  //println("ADD");
  workRAM.contents[regWP] = char(a+b);
  if(int(a + b) > 65535){
    regST |= 0x0001;
    //print("Carry!");
  }else{
    regST &= 0xFFFE;
  }
  if(workRAM.contents[regWP] == 0){
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
  workRAM.contents[regWP + (reg & 0x0F)] = char(workRAM.contents[regWP + (reg & 0x0F)] + imm);
  if(int(char(workRAM.contents[regWP + (reg & 0x0F)] + imm)) > 65535){
    regST |= 0x0001;
    //print("Carry!");
  }else{
    regST &= 0xFFFE;
  }
  if(workRAM.contents[regWP + (reg & 0x0F)] == 0){
    regST |= 0x0002;
    //print("Zero!");
  }else{
    regST &= 0xFFFD;
  }
}

void SUB(char a, char b){//SUBtraction
  println("SUB");
  workRAM.contents[regWP] = char(a-b);
  if(int(a - b) < 0){//A < B
    regST |= 0x0004;
    //print("BORROW!");
  }else{
    regST &= 0xFFFB;//A > B
  }
  if(workRAM.contents[regWP] == 0){
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
  if((workRAM.contents[word] & (0x01 << bit)) != 0){
    regST |= 0x0001;
    //print("Carry!");
  }else{
    regST &= 0xFFFE;
  }
}

void bitTestSet(int word, int bit){
  if((workRAM.contents[word] & (0x01 << bit)) != 0){
    regST |= 0x0001;
    //print("Carry!");
  }else{
    regST &= 0xFFFE;
  }
  workRAM.contents[word] |= (1 << bit);
}

void bitTestReset(int word, int bit){
  if((workRAM.contents[word] & (0x01 << bit)) != 0){
    regST |= 0x0001;
    //print("Carry!");
  }else{
    regST &= 0xFFFE;
  }
  workRAM.contents[word] &= ~(1 << bit);
}

void bitTestInvert(int word, int bit){
  if((workRAM.contents[word] & (0x01 << bit)) != 0){
    regST |= 0x0001;
    //print("Carry!");
  }else{
    regST &= 0xFFFE;
  }
  workRAM.contents[word] ^= (1 << bit);
}