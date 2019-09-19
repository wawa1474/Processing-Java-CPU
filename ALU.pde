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

//void SHIFTLEFTCARRY(char a_, char amount_){
//  updateFlag(FLAG_CARRY, (a_ & 0x8000) != 0);
//  workRAM.write(regWP, char(a_ << amount_));
//}

//void SHIFTRIGHTCARRY(char a_, char amount_){
//  updateFlag(FLAG_CARRY, (a_ & 0x01) != 0);
//  workRAM.write(regWP, char(a_ >> amount_));
//}

//void SHIFTLEFT(char a_, char amount_){
//  workRAM.write(regWP, char(a_ << amount_));
//}

//void SHIFTRIGHT(char a_, char amount_){
//  workRAM.write(regWP, char(a_ >> amount_));
//}

//void ROTATELEFTCARRY(char a_, char amount_){
//  int low = getFlag(FLAG_CARRY)?1:0;
//  updateFlag(FLAG_CARRY, (a_ & 0x8000) != 0);
//  workRAM.write(regWP, char((a_ << amount_) + low));
//}

//void ROTATERIGHTCARRY(char a_, char amount_){
//  int high = getFlag(FLAG_CARRY)?0x8000:0;
//  updateFlag(FLAG_CARRY, (a_ & 0x01) != 0);
//  workRAM.write(regWP, char((a_ >> amount_) + high));
//}

//void ROTATELEFT(char a_, char amount_){
//  int low = (a_ & 0x8000) != 0?1:0;
//  workRAM.write(regWP, char((a_ << amount_) + low));
//}

//void ROTATERIGHT(char a_, char amount_){
//  int high = (a_ & 0x01) != 0?0x8000:0;
//  workRAM.write(regWP, char((a_ >> amount_) + high));
//}

void SHIFTLEFTCARRY(char a_){
  updateFlag(FLAG_CARRY, (a_ & 0x8000) != 0);
  workRAM.write(regWP, char((a_ << 1) & 0xFFFE));
}

void SHIFTRIGHTCARRY(char a_){
  updateFlag(FLAG_CARRY, (a_ & 0x0001) != 0);
  workRAM.write(regWP, char(((a_ >> 1) & 0x7FFF)));
}

void SHIFTLEFTARITHMETIC(char a_){
  int low = a_ & 0x0001;
  workRAM.write(regWP, char(((a_ << 1) & 0xFFFE) | low));
}

void SHIFTRIGHTARITHMETIC(char a_){
  int high = a_ & 0x8000;
  workRAM.write(regWP, char(((a_ >> 1) & 0x7FFF) | high));
}

void SHIFTLEFT(char a_){
  workRAM.write(regWP, char((a_ << 1) & 0xFFFE));
}

void SHIFTRIGHT(char a_){
  workRAM.write(regWP, char(((a_ >> 1) & 0x7FFF)));
}

void ROTATELEFTCARRY(char a_){
  int low = getFlag(FLAG_CARRY)?1:0;
  updateFlag(FLAG_CARRY, (a_ & 0x8000) != 0);
  workRAM.write(regWP, char(((a_ << 1) & 0xFFFE) | low));
}

void ROTATERIGHTCARRY(char a_){
  int high = getFlag(FLAG_CARRY)?0x8000:0;
  updateFlag(FLAG_CARRY, (a_ & 0x0001) != 0);
  workRAM.write(regWP, char(((a_ >> 1) & 0x7FFF) | high));
}

void ROTATELEFT(char a_){
  int low = (a_ & 0x8000) != 0?1:0;
  workRAM.write(regWP, char(((a_ << 1) & 0xFFFE) | low));
}

void ROTATERIGHT(char a_){
  int high = (a_ & 0x0001) != 0?0x8000:0;
  workRAM.write(regWP, char(((a_ >> 1) & 0x7FFF) | high));
}

void INC(int addr_){
  char value = workRAM.read(addr_);
  boolean zero = (value == 65535);
  updateFlag(FLAG_CARRY, zero);
  updateFlag(FLAG_ZERO, zero);
  workRAM.write(addr_, char(value + 1));
}

void DEC(int addr_){
  char value = workRAM.read(addr_);
  boolean borrow = value == 0;
  updateFlag(FLAG_BORROW, borrow);
  workRAM.write(addr_, char(value - 1));
  boolean zero = (value == 0);
  updateFlag(FLAG_ZERO, zero);
}

void ADD(char a, char b){//ADDition
  //println("ADD");
  int tmp = a + b;
  workRAM.write(regWP, char(tmp & 0xFFFF));
  boolean carry = (tmp > 65535);
  updateFlag(FLAG_CARRY, carry);
  boolean zero = ((tmp & 0xFFFF) == 0);
  updateFlag(FLAG_ZERO, zero);
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
  int addr = regWP + (reg & 0x0F);
  int tmp = workRAM.read(addr) + imm;
  workRAM.write(addr, char(tmp & 0xFFFF));
  boolean carry = (tmp > 65535);
  updateFlag(FLAG_CARRY, carry);
  boolean zero = ((tmp & 0xFFFF) == 0);
  updateFlag(FLAG_ZERO, zero);
}

void SUB(char a, char b){//SUBtraction
  //println("SUB");
  int tmp = a - b;
  workRAM.write(regWP, char(tmp & 0xFFFF));
  boolean borrow = (tmp < 0);
  updateFlag(FLAG_BORROW, borrow);
  boolean zero = ((tmp & 0xFFFF) == 0);
  updateFlag(FLAG_ZERO, zero);
}

void COMPARE(char a, char b){//Compare
  int add = a + b;
  int sub = a - b;
  boolean carry = (add > 65535);//carry
  updateFlag(FLAG_CARRY, carry);
  boolean borrow = (sub < 0);//A < B, A > B
  updateFlag(FLAG_BORROW, borrow);
  boolean zero = (sub == 0);//A == B, A != B
  updateFlag(FLAG_ZERO, zero);
}

void bitTest(int word, int bit){
  boolean bitTest = ((workRAM.read(word) & (0x01 << bit)) != 0);//carry
  updateFlag(FLAG_CARRY, bitTest);
}

void bitTestSet(int word, int bit){
  int tmp = workRAM.read(word);
  boolean bitTest = ((tmp & (0x01 << bit)) != 0);//carry
  updateFlag(FLAG_CARRY, bitTest);
  workRAM.write(word, char(tmp | (1 << bit)));
}

void bitTestReset(int word, int bit){
  int tmp = workRAM.read(word);
  boolean bitTest = ((tmp & (0x01 << bit)) != 0);//carry
  updateFlag(FLAG_CARRY, bitTest);
  workRAM.write(word, char(tmp & (1 << bit)));
}

void bitTestInvert(int word, int bit){
  int tmp = workRAM.read(word);
  boolean bitTest = ((tmp & (0x01 << bit)) != 0);//carry
  updateFlag(FLAG_CARRY, bitTest);
  workRAM.write(word, char(tmp ^ (1 << bit)));
}