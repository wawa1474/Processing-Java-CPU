//fibonacci sequence
/*
--------SUDO CODE--------
load 0 1
copy 01
load 2 0
start:
print 0
add 21
jumpover halt: 75,025
copy 12
copy 01
jump start:
halt:
halt

--------HEX---------
02000001
0601
02020000
0300
0521
0002000D
0612
0601
00030005
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
jumpnover start: 75,025
halt

--------HEX---------
02000001
0601
02020000
0300
0521
0612
0601
00040005
0001
*/