void XOR(char a, char b){//Exclusive OR
  println("XOR");
  regA = char(a^b);
}

void XNOR(char a, char b){//Exclusive Not OR
  println("XNOR");
  regA = char((a^b)^0xFFFF);
}

void AND(char a, char b){//And
  println("regA = " + hex(a) + " & " + register + ": " + hex(b));
  regA = char(a&b);
}

void NAND(char a, char b){//Not AND
  println("NAND");
  regA = char((a&b)^0xFFFF);
}

void OR(char a, char b){//OR
  println("OR");
  regA = char(a|b);
}

void NOR(char a, char b){//Not OR
  println("NOR");
  regA = char((a|b)^0xFFFF);
}

void NOT(char a){
  println("NOT");
  regA = char(a^0xFFFF);
}

void ADD(char a, char b){//ADDition
  println("ADD");
  regA = char(a+b);
}

void SUB(char a, char b){//SUBtraction
  println("SUB");
  regA = char(a-b);
}