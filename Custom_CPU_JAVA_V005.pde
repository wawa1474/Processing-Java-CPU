RAM mainRAM;
int RAMSize = 65536;
int STKSize = 256;

boolean CPUHalt = false;

void setup(){
  size(960, 540);
  hardReset();
  print("bootCode: ");
  for(int i = 0; i < programLength; i++){
    print(hex(mainRAM.contents[i]));
    if(i < programLength - 1){print(", ");}
  }
  println();println();
  
  push(char(255));
  println(pop() & 0xFF);
  println();
}

void draw(){
  fetchOpcode();
  decodeOpcode();
  if(CPUHalt == true){noLoop();}
}