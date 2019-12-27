RAM workRAM;
int workRAMSize = 1 * mega_Word;//1 MB of ram?//65536

int videoRAMPlace = 65536;
int videoRAMSize = 65536;
int stackRAMPlace = videoRAMPlace + videoRAMSize;
int stackRAMSize = 65536;//?

int regSP = 0;

class RAM{//RAM
  char contents[];
  int pointer = 0;//memory pointer
  int indX = 0;//index register X
  int indY = 0;//index register Y
  int indA = 0;//index amount
  
  RAM(int size_){
    contents = new char[size_];
  }
  
  void push(int c_){
    contents[pointer] = char(c_);
    pointer++;
  }
  
  char pop(){
    pointer--;
    return contents[pointer];
  }
  
  void push(int c_, int pointer_){
    contents[pointer_] = char(c_);
    pointer_++;
  }
  
  char pop(int pointer_){
    pointer_--;
    return contents[pointer_];
  }
  
  void update(int c_, int pointer_){
    contents[pointer_] = char(c_);
  }
  
  char peek(int pointer_){
    return contents[pointer_];
  }
  
  //void roll(int amount_, int pointer_) {
  //  if (amount_ == 0){
  //    return;
  //  }

  //  int index = pointer_ - amount_ - 1;
  //  if (0 <= index && index < pointer_) {
  //      char newTop = splice(index, 1, pointer_)[0];
  //      push(newTop, pointer_);
  //  }// else
  //      //throw "Attempted to roll more elements than in stack " + position_ + ": " + name;
  //  //};
  //}
  
  //char[] splice(int position_, int amount_, int pointer_){
  //  char[] output = new char[amount_];
  //  for(int i = position_; i < position_ + amount_ && i < pointer_; i++){
  //    output[i - position_] = contents[i];
  //  }
  //  for(int i = position_; i < pointer_ - amount_; i++){
  //    contents[i] = contents[i + amount_];
  //  }
  //  pointer_ -= amount_ + 1;
  //  return output;
  //}
  
  void write(int addr_, char data_){
    contents[addr_] = data_;
  }
  
  char read(int addr_){
    return contents[addr_];
  }
}

//RAM_main.pointer - Program Counter
//RAM_stack.pointer - Stack Pointer
//RAM_video.pointer - ?

//16 byte aligned?
int regWP;//Workspace Pointer Register

int regAM;//Adressing Mode Register
/*
used to change what group of addressing modes are used
?are we using the more useful ones or the weird ones?
have some amount of addressing mode information be part of the opcodes
but keep it to a minimum number of bits (2-4?)
*/

final int regST = 15;//Status Register
/*
BIT    VALUE    HEX    INVERSE   MEANING
0      1        0001 - FFFE      Carry
1      2        0002 - FFFD      Zero
2      4        0004 - FFFB      Borrow
3      8        0008 - FFF7      Negative
4      16       0010 - FFEF      Sign
5      32       0020 - FFDF      Greater
6      64       0040 - FFBF      NONE
7      128      0080 - FF7F      NONE
8      256      0100 - FEFF      NONE
9      512      0200 - FDFF      NONE
a      1024     0400 - FBFF      NONE
b      2048     0800 - F7FF      NONE
c      4096     1000 - EFFF      NONE
d      8192     2000 - DFFF      NONE
e      16384    4000 - BFFF      NONE
f      32768    8000 - 7FFF      NONE
*/
final int FLAG_CARRY = 1;
final int FLAG_ZERO = 2;
final int FLAG_BORROW = 4;
final int FLAG_NEGATIVE = 8;
final int FLAG_SIGN = 16;
final int FLAG_GREATER = 16;

void updateFlag(int flag_, boolean value_){
  char tmp = workRAM.read(regWP + regST);
  if(value_){
    tmp |= flag_;
  }else{
    tmp &= ~flag_;
  }
  workRAM.write(regWP + regST, tmp);
}

boolean getFlag(int flag_){
  char tmp = workRAM.read(regWP + regST);
  return (tmp & flag_) != 0;
}

void clearFlags(){
  workRAM.write(regWP + regST, char(0)); 
}
  
void incPC(){workRAM.pointer++; if(workRAM.pointer >= workRAMSize){workRAM.pointer = 0;}}
void decPC(){if(workRAM.pointer <= 0){workRAM.pointer = workRAMSize;} workRAM.pointer--;}