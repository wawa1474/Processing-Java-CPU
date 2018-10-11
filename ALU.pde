void XOR(char a, char b){//Exclusive OR
  println("XOR");
  registers[regA] = char(a^b);
}

void XNOR(char a, char b){//Exclusive Not OR
  println("XNOR");
  registers[regA] = char((a^b)^0xFFFF);
}

void AND(char a, char b){//And
  println("regA: " + hex(a) + " & " + registerNames[register] + ": " + hex(b));
  registers[regA] = char(a&b);
}

void NAND(char a, char b){//Not AND
  println("NAND");
  registers[regA] = char((a&b)^0xFFFF);
}

void OR(char a, char b){//OR
  println("OR");
  registers[regA] = char(a|b);
}

void NOR(char a, char b){//Not OR
  println("NOR");
  registers[regA] = char((a|b)^0xFFFF);
}

void NOT(char a){
  println("NOT");
  registers[regA] = char(a^0xFFFF);
}

void ADD(char a, char b){//ADDition
  println("ADD");
  registers[regA] = char(a+b);
}

void SUB(char a, char b){//SUBtraction
  println("SUB");
  registers[regA] = char(a-b);
}