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

final int ALU_ADD = 0;
final int ALU_ADC = 1;
final int ALU_SUB = 2;
final int ALU_SBC = 3;
final int ALU_INV = 4;
final int ALU_AND = 5;
final int ALU_OR = 6;
final int ALU_XOR = 7;
final int ALU_NOT = 8;
final int ALU_NAND = 9;
final int ALU_NOR = 10;
final int ALU_XNOR = 11;
final int ALU_INC = 12;
final int ALU_DEC = 13;
final int ALU_ASL = 14;
final int ALU_ASR = 15;
final int ALU_LSL = 16;
final int ALU_LSR = 17;
final int ALU_CSL = 18;
final int ALU_CSR = 19;
final int ALU_RTL = 20;
final int ALU_RTR = 21;
final int ALU_RCL = 22;
final int ALU_RCR = 23;
final int ALU_CMP = 24;
final int ALU_BTT = 25;
final int ALU_BTS = 26;
final int ALU_BTR = 27;
final int ALU_BTI = 28;
final int ALU_BCP = 29;
final int ALU_BST = 30;


void ALU(int dataBus_, int secondary_, int output_, int function_){
  int tmpOutput = 0;
  boolean carry = false;
  boolean zero = false;
  boolean borrow = false;
  boolean sign = false;
  boolean greater = false;
  switch(function_){
    case ALU_ADD:
    case ALU_ADC:
    case ALU_SUB:
    case ALU_SBC:
    case ALU_INV:
    case ALU_AND:
    case ALU_OR:
    case ALU_XOR:
    case ALU_NOT:
    case ALU_NAND:
    case ALU_NOR:
    case ALU_XNOR:
    case ALU_INC:
    case ALU_DEC:
    case ALU_ASL:
    case ALU_ASR:
    case ALU_LSL:
    case ALU_LSR:
    case ALU_CSL:
    case ALU_CSR:
    case ALU_RTL:
    case ALU_RTR:
    case ALU_RCL:
    case ALU_RCR:
    case ALU_CMP:
    case ALU_BTT:
    case ALU_BTS:
    case ALU_BTR:
    case ALU_BTI:
    case ALU_BCP:
    case ALU_BST:
  }
  
  carry = ((tmpOutput & 0xFFFF0000) != 0);
  zero = ((tmpOutput & 0x0000FFFF) == 0);
  if(function_ == ALU_SUB || function_ == ALU_SBC){borrow = ((dataBus_ - secondary_) < 0);}
  sign = ((tmpOutput & 0x00008000) != 0);
  greater = (dataBus_ > secondary_);
  updateFlags(carry, zero, borrow, sign, greater);
}