void XOR(char a, char b){//Exclusive OR
  //println("XOR");
  RAM_work.contents[regWP] = char(a^b);
}

void XNOR(char a, char b){//Exclusive Not OR
  //println("XNOR");
  RAM_work.contents[regWP] = char((a^b)^0xFFFF);
}

void AND(char a, char b){//And
  //println("reg 1: " + hex(a) + " & reg " + register + ": " + hex(b));
  RAM_work.contents[regWP] = char(a&b);
}

void NAND(char a, char b){//Not AND
  //println("NAND");
  RAM_work.contents[regWP] = char((a&b)^0xFFFF);
}

void OR(char a, char b){//OR
  //println("OR");
  RAM_work.contents[regWP] = char(a|b);
}

void NOR(char a, char b){//Not OR
  //println("NOR");
  RAM_work.contents[regWP] = char((a|b)^0xFFFF);
}

void NOT(char a){
  //println("NOT");
  RAM_work.contents[regWP] = char(a^0xFFFF);
}

void INC(char reg){
  if(RAM_work.contents[regWP + reg] == 65535){
    regST |= 0x0001;
    //print("Carry!");
  }else{
    regST &= 0xFFFE;
  }
  RAM_work.contents[regWP + reg]++;
  if(RAM_work.contents[regWP + reg] == 0){
    regST |= 0x0002;
    //print("Zero!");
  }else{
    regST &= 0xFFFD;
  }
}

void DEC(char reg){
  if(RAM_work.contents[regWP + reg] == 0){
    regST |= 0x0004;
    //print("BORROW!");
  }else{
    regST &= 0xFFFB;
  }
  RAM_work.contents[regWP + reg]--;
  if(RAM_work.contents[regWP + reg] == 0){
    regST |= 0x0002;
    //print("Zero!");
  }else{
    regST &= 0xFFFD;
  }
}

void ADD(char a, char b){//ADDition
  //println("ADD");
  RAM_work.contents[regWP] = char(a+b);
  if(int(a + b) > 65535){
    regST |= 0x0001;
    //print("Carry!");
  }else{
    regST &= 0xFFFE;
  }
  if(RAM_work.contents[regWP] == 0){
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
  RAM_work.contents[regWP + (reg & 0x0F)] = char(RAM_work.contents[regWP + (reg & 0x0F)] + imm);
  if(int(char(RAM_work.contents[regWP + (reg & 0x0F)] + imm)) > 65535){
    regST |= 0x0001;
    //print("Carry!");
  }else{
    regST &= 0xFFFE;
  }
  if(RAM_work.contents[regWP + (reg & 0x0F)] == 0){
    regST |= 0x0002;
    //print("Zero!");
  }else{
    regST &= 0xFFFD;
  }
}

void SUB(char a, char b){//SUBtraction
  println("SUB");
  RAM_work.contents[regWP] = char(a-b);
  if(int(a - b) < 0){//A < B
    regST |= 0x0004;
    //print("BORROW!");
  }else{
    regST &= 0xFFFB;//A > B
  }
  if(RAM_work.contents[regWP] == 0){
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
  if((RAM_work.contents[word] & (0x01 << bit)) != 0){
    regST |= 0x0001;
    //print("Carry!");
  }else{
    regST &= 0xFFFE;
  }
}

void bitTestSet(int word, int bit){
  if((RAM_work.contents[word] & (0x01 << bit)) != 0){
    regST |= 0x0001;
    //print("Carry!");
  }else{
    regST &= 0xFFFE;
  }
  RAM_work.contents[word] |= (1 << bit);
}

void bitTestReset(int word, int bit){
  if((RAM_work.contents[word] & (0x01 << bit)) != 0){
    regST |= 0x0001;
    //print("Carry!");
  }else{
    regST &= 0xFFFE;
  }
  RAM_work.contents[word] &= ~(1 << bit);
}

void bitTestInvert(int word, int bit){
  if((RAM_work.contents[word] & (0x01 << bit)) != 0){
    regST |= 0x0001;
    //print("Carry!");
  }else{
    regST &= 0xFFFE;
  }
  RAM_work.contents[word] ^= (1 << bit);
}