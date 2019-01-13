/*
keyboard test 1
------------sudo code----------
f = 0
start:
if(key == m){
  for(f + 1 != 0; f++){
    pixel f
  }
  halt
}
jump :start

------------asm code------------
start:
if key m set zero flag
jump if not zero :start
zero reg[F]
loop:
pixel reg[F]
increment reg[F]
jump not carry :loop
halt

------------hex code--------------
1300 006D
0007 0000
100F
0F0F
0D0F
0004 0005
0001
*/



//fibonacci sequence
/*
--------SUDO CODE--------
load 0 1
copy 01
load 2 0
start:
print 0
add 21
jmp NC halt: 75,025
copy 12
copy 01
jmp start:
halt:
halt

--------HEX---------
0200 0001
0601
0202 0000
0300
0521
0002 000D
0612
0601
0003 0005
0001
*/

//fibonacci sequence 2
/*
--------SUDO CODE--------
load 0 1
copy 01
load 2 0
start:
print 0
add 21
copy 12
copy 01
jmp NC start: 75,025
halt

--------HEX---------
0200 0001
0601
0202 0000
0300
0521
0612
0601
0004 0005
0001
*/

//display test 1
/*
--------SUDO CODE--------
insc ff
insm 07
load 00 000f
load 01 0001
load 0f 000f
loop:
strr 00
inc 00
inc 0f
compare 0f 01
jmp NC loop
halt

--------HEX---------
07FF
0807
0200 000F
0201 0001
020F 000F
0C00
0D00
0D0F
0AF1
0004 0008
0001
*/




/*
display test 8
-------------------sudo code-------------
zero reg[F]
loop:
pixel reg[F]
increment reg[F]
jump not carry :loop
halt
------------------hex----------------
100F
0F0F
0D0F
0004 0001
0001
*/


/*
display image test 1
-------------sudo sudo code------------
f = 10,10
(0) = imagestart
c = imagestart + 64
loadb:
b = 8
for(b != 0; b--){
  load [(0)] -> e
  pixel e
  inc (0)
  inc f
  if((0) = c){halt}
}
f += 248
jump loadb
-------------sudo code----------
load reg[2] 248
load reg[F] 256 * 10 + 10
load reg[0] :imageStart
load reg[C] :imageStart + 64
loadB:
load reg[B] 8
loop:
load reg[E] mem[0]
pixel reg[E]
inc [0]
inc [F]
compare [0] [C]
jump equal :end
dec [B]
jump not zero :loop
copy 0 1
copy f 0
add 2 0
copy 0 f
copy 1 0
jump :loadB
end:
halt?

imageStart:
FF00 FF00 FF00 0000 FF00 0000 0000 0000
FF00 0000 FF00 0000 FF00 0000 0000 0000
FF00 0000 0000 0000 FF00 0000 0000 0000
FF00 FF00 FF00 FF00 FF00 0000 0000 0000
FF00 FF00 0000 0000 0000 0000 0000 0000
0000 FF00 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000

-------------------hex---------------
0202 00F8
020F 0A0A
0200 :imagestart
020C :imagestart + 64
loadB:
020B 0008
loop:
110E
0F0E
0D00
0D0F
0AC0
0006 :end
0E0B
0007 :loop
0601
06f0
05f0
060f
0610
0003 :loadB
end:
0001?
imageStart:
FF00 FF00 FF00 0000 FF00 0000 0000 0000
FF00 0000 FF00 0000 FF00 0000 0000 0000
FF00 0000 0000 0000 FF00 0000 0000 0000
FF00 FF00 FF00 FF00 FF00 0000 0000 0000
FF00 FF00 0000 0000 0000 0000 0000 0000
0000 FF00 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
*/


/*
display image test 2
-------------sudo sudo code------------
f = 10,10
(0) = imagestart
c = imagestart + 64
loadb:
b = 8
for(b != 0; b--){
  load [(0)] -> e
  pixel e
  inc (0)
  inc f
  if((0) = c){halt}
}
f += 248
jump loadb
-------------sudo code----------
load reg[F] 256 * 10 + 10
load reg[0] :imageStart
load reg[C] :imageStart + 64
loadB:
load reg[B] 8
loop:
load reg[E] mem[0]
pixel reg[E]
inc [0]
inc [F]
compare [0] [C]
jump equal :end
dec [B]
jump not zero :loop
addi f 248
jump :loadB
end:
halt?

imageStart:
FF00 FF00 FF00 0000 FF00 0000 0000 0000
FF00 0000 FF00 0000 FF00 0000 0000 0000
FF00 0000 0000 0000 FF00 0000 0000 0000
FF00 FF00 FF00 FF00 FF00 0000 0000 0000
FF00 FF00 0000 0000 0000 0000 0000 0000
0000 FF00 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000

-------------------hex---------------
020F 0A0A
0200 :imagestart
020C :imagestart + 64
loadB:
020B 0008
loop:
110E
0F0E
0D00
0D0F
0AC0
0006 :end
0E0B
0007 :loop
120f 00f8
0003 :loadB
end:
0001?
imageStart:
FF00 FF00 FF00 0000 FF00 0000 0000 0000
FF00 0000 FF00 0000 FF00 0000 0000 0000
FF00 0000 0000 0000 FF00 0000 0000 0000
FF00 FF00 FF00 FF00 FF00 0000 0000 0000
FF00 FF00 0000 0000 0000 0000 0000 0000
0000 FF00 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
*/


/*
display image test 3
-------------sudo sudo code------------
f = 0x00
start:
(0) = imagestart
c = imagestart + 64
while(true){
  b = 8
  for(b != 0; b--){
    load [(0)] -> e
    pixel e
    inc (0)
    inc f
    if((0) = c){
      f += 0x07 
      jump start
    }
  }
  f += 248
}
-------------sudo code----------
load reg[F] 256 * 10 + 10
start:
load reg[0] :imageStart
load reg[C] :imageStart + 64
loadB:
load reg[B] 8
loop:
load reg[E] mem[0]
pixel reg[E]
inc [0]
inc [F]
compare [0] [C]
jump equal :end
dec [B]
jump not zero :loop
addi f 248
jump :loadB
end:
addi f 7
jump :start

imageStart:
0000 0000 0000 0000 0000 0000 0000 0000
0000 FF00 FF00 FF00 0000 FF00 0000 0000
0000 FF00 0000 FF00 0000 FF00 0000 0000
0000 FF00 0000 0000 0000 FF00 0000 0000
0000 FF00 FF00 FF00 FF00 FF00 0000 0000
0000 FF00 FF00 0000 0000 0000 0000 0000
0000 0000 FF00 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000

-------------------hex---------------
020F 0000
start:
0200 :imagestart
020C :imagestart + 64
loadB:
020B 0008
loop:
110E
0F0E
0D00
0D0F
0AC0
0006 :end
0E0B
0007 :loop
120f 00f8
0003 :loadB
end:
120f 0007
0003 :start

imageStart:
FF00 FF00 FF00 0000 FF00 0000 0000 0000
FF00 0000 FF00 0000 FF00 0000 0000 0000
FF00 0000 0000 0000 FF00 0000 0000 0000
FF00 FF00 FF00 FF00 FF00 0000 0000 0000
FF00 FF00 0000 0000 0000 0000 0000 0000
0000 FF00 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
*/