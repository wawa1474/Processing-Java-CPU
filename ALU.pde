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

void ADD(char a, char b){//ADDition
  println("ADD");
  mainRAM.contents[regWP] = char(a+b);
}

void SUB(char a, char b){//SUBtraction
  println("SUB");
  mainRAM.contents[regWP] = char(a-b);
}