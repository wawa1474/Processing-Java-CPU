char XOR(char a, char b){//Exclusive OR
  return char(a^b);
}

char XNOR(char a, char b){//Exclusive Not OR
  //return char((a^b)^0xFF);
  return NOT(char(a^b));
}

char AND(char a, char b){//And
  return char(a&b);
}

char NAND(char a, char b){//Not AND
  //return char((a&b)^0xFF);
  return NOT(char(a&b));
}

char OR(char a, char b){//OR
  return char(a|b);
}

char NOR(char a, char b){//Not OR
  //return char((a|b)^0xFF);
  return NOT(char(a|b));
}

char NOT(char a){//NOT
  return char(a^0xFF);
}

char ADD(char a, char b){//ADDition
  return char(a+b);
}

char SUB(char a, char b){//SUBtraction
  return char(a-b);
}