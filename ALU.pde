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
  setFlag(FLAG_CARRY, (a_ & 0x8000) != 0);
  workRAM.write(regWP, char((a_ << 1) & 0xFFFE));
}

void SHIFTRIGHTCARRY(char a_){
  setFlag(FLAG_CARRY, (a_ & 0x0001) != 0);
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
  setFlag(FLAG_CARRY, (a_ & 0x8000) != 0);
  workRAM.write(regWP, char(((a_ << 1) & 0xFFFE) | low));
}

void ROTATERIGHTCARRY(char a_){
  int high = getFlag(FLAG_CARRY)?0x8000:0;
  setFlag(FLAG_CARRY, (a_ & 0x0001) != 0);
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
  setFlag(FLAG_CARRY, zero);
  setFlag(FLAG_ZERO, zero);
  workRAM.write(addr_, char(value + 1));
}

void DEC(int addr_){
  char value = workRAM.read(addr_);
  boolean borrow = value == 0;
  setFlag(FLAG_BORROW, borrow);
  workRAM.write(addr_, char(value - 1));
  boolean zero = (value == 0);
  setFlag(FLAG_ZERO, zero);
}

void ADD(char a, char b){//ADDition
  //println("ADD");
  int tmp = a + b;
  workRAM.write(regWP, char(tmp & 0xFFFF));
  boolean carry = (tmp > 65535);
  setFlag(FLAG_CARRY, carry);
  boolean zero = ((tmp & 0xFFFF) == 0);
  setFlag(FLAG_ZERO, zero);
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
  setFlag(FLAG_CARRY, carry);
  boolean zero = ((tmp & 0xFFFF) == 0);
  setFlag(FLAG_ZERO, zero);
}

void SUB(char a, char b){//SUBtraction
  //println("SUB");
  int tmp = a - b;
  workRAM.write(regWP, char(tmp & 0xFFFF));
  boolean borrow = (tmp < 0);
  setFlag(FLAG_BORROW, borrow);
  boolean zero = ((tmp & 0xFFFF) == 0);
  setFlag(FLAG_ZERO, zero);
}

void COMPARE(char a, char b){//Compare
  int add = a + b;
  int sub = a - b;
  boolean carry = (add > 65535);//carry
  setFlag(FLAG_CARRY, carry);
  boolean borrow = (sub < 0);//A < B, A > B
  setFlag(FLAG_BORROW, borrow);
  boolean zero = (sub == 0);//A == B, A != B
  setFlag(FLAG_ZERO, zero);
}

void bitTest(int word, int bit){
  boolean bitTest = ((workRAM.read(word) & (0x01 << bit)) != 0);//carry
  setFlag(FLAG_CARRY, bitTest);
}

void bitTestSet(int word, int bit){
  int tmp = workRAM.read(word);
  boolean bitTest = ((tmp & (0x01 << bit)) != 0);//carry
  setFlag(FLAG_CARRY, bitTest);
  workRAM.write(word, char(tmp | (1 << bit)));
}

void bitTestReset(int word, int bit){
  int tmp = workRAM.read(word);
  boolean bitTest = ((tmp & (0x01 << bit)) != 0);//carry
  setFlag(FLAG_CARRY, bitTest);
  workRAM.write(word, char(tmp & (1 << bit)));
}

void bitTestInvert(int word, int bit){
  int tmp = workRAM.read(word);
  boolean bitTest = ((tmp & (0x01 << bit)) != 0);//carry
  setFlag(FLAG_CARRY, bitTest);
  workRAM.write(word, char(tmp ^ (1 << bit)));
}

final int ALU_ADD = 0;
final int ALU_ADC = 1;
final int ALU_SUB = 2;
final int ALU_SBC = 3;
final int ALU_NEG = 4;
final int ALU_PASS = 5;
final int ALU_AND = 6;
final int ALU_OR = 7;
final int ALU_XOR = 8;
final int ALU_NOT = 9;
final int ALU_NAND = 10;
final int ALU_NOR = 11;
final int ALU_XNOR = 12;
final int ALU_INC = 13;
final int ALU_DEC = 14;
final int ALU_ASL = 15;
final int ALU_ASR = 16;
final int ALU_LSL = 17;
final int ALU_LSR = 18;
final int ALU_ONE = 19;
final int ALU_ZERO = 20;
final int ALU_RTL = 21;
final int ALU_RTR = 22;
final int ALU_RCL = 23;
final int ALU_RCR = 24;
final int ALU_CMP = 25;
final int ALU_BTT = 26;
final int ALU_BTS = 27;
final int ALU_BTR = 28;
final int ALU_BTI = 29;
//final int ALU_BCP = 30;
final int ALU_BST = 31;


void ALU(int dataBus_, int secondary_, int output_, int function_, boolean invertOutput_){
  int tmpOutput = 0;
  boolean carry = false;
  boolean zero = false;
  boolean borrow = false;
  boolean sign = false;
  boolean greater = false;
  
  output_ = 0;
  
  invertOutput_ = ((function_ < ALU_XOR) && isEven(function_))?true:false;
  
  switch(function_){
    case ALU_ONE:
    case ALU_ZERO: break;
    
    case ALU_NOT:
    case ALU_PASS:output_ = dataBus_; break;
    
    case ALU_NAND:
    case ALU_AND: output_ = dataBus_ & secondary_; break;
    
    case ALU_NOR:
    case ALU_OR:  output_ = dataBus_ | secondary_; break;
    
    case ALU_XNOR:
    case ALU_XOR: output_ = dataBus_ ^ secondary_; break;
    
    case ALU_ADC: output_ = getFlag(FLAG_CARRY)?1:0;
    case ALU_ADD: output_ += dataBus_ + secondary_; break;
    
    case ALU_SBC: output_ = getFlag(FLAG_CARRY)?-1:0;
    case ALU_SUB: output_ += dataBus_ - secondary_; break;
    
    case ALU_INC: output_ = dataBus_ + 1; break;
    case ALU_DEC: output_ = dataBus_ - 1; break;
    
    case ALU_ASL: output_ = dataBus_ << 1; break;
    case ALU_ASR: output_ = dataBus_ >> 1 | (((dataBus_ & 0x8000) != 0)?0x8000:0); break;
    
    case ALU_LSL: output_ = dataBus_ << 1; break;
    case ALU_LSR: output_ = dataBus_ >> 1; break;

    case ALU_RTL: output_ = dataBus_ << 1 | (((dataBus_ & 0x8000) != 0)?0x1:0); break;
    case ALU_RTR: output_ = dataBus_ >> 1 | (((dataBus_ & 0x1) != 0)?0x8000:0); break;
    
    case ALU_RCL: output_ = dataBus_ << 1 | ((getFlag(FLAG_CARRY))?0x1:0); setFlag(FLAG_CARRY, (dataBus_ & 0x8000) != 0); break;
    case ALU_RCR: output_ = dataBus_ >> 1 | ((getFlag(FLAG_CARRY))?0x8000:0); setFlag(FLAG_CARRY, (dataBus_ & 0x1) != 0); break;
    
    case ALU_BTT: setFlag(FLAG_CARRY, (dataBus_ & (1 << secondary_)) != 0); break;
    case ALU_BTS: output_ = dataBus_ |  (1 << secondary_); setFlag(FLAG_CARRY, (dataBus_ & (1 << secondary_)) != 0); break;
    case ALU_BTR: output_ = dataBus_ & ~(1 << secondary_); setFlag(FLAG_CARRY, (dataBus_ & (1 << secondary_)) != 0); break;
    case ALU_BTI: output_ = dataBus_ ^ ~(1 << secondary_); setFlag(FLAG_CARRY, (dataBus_ & (1 << secondary_)) != 0); break;
    
    case ALU_BST: output_ = dataBus_ & ~(1 << secondary_); output_ |= (getFlag(FLAG_CARRY)?1:0) << secondary_; break;
    
    case ALU_NEG: output_ = 0 - dataBus_; break;
    
    case ALU_CMP:
  }
  
  if(invertOutput_ == true){
    output_ = ~output_;
  }
  
  carry = ((tmpOutput & 0xFFFF0000) != 0);
  zero = ((tmpOutput & 0x0000FFFF) == 0);
  if(function_ == ALU_SUB || function_ == ALU_SBC){borrow = ((dataBus_ - secondary_) < 0);}
  sign = ((tmpOutput & 0x00008000) != 0);
  greater = (dataBus_ > secondary_);
  updateFlags(carry, zero, borrow, sign, greater);
}

boolean isEven(int n){
  return n % 2 == 0;
}