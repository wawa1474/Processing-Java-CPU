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