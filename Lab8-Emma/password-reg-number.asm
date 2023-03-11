[00400000] lw      $4,0($29) #00400000 #stack pointer
[00400004] addiu   $5,$29,4 #$sp + 4
[00400008] addiu   $6,$5,4 #$sp + 4 + 4
[0040000c] sll     $2,$4,0x2 #register $2 has addr 10000040
[00400010] addu    $6,$6,$2
[00400014] jal     0x400024 #jump and link to instruction at addr 00400024
[00400018] sll     $0,$0,0x0
[0040001c] ori     $2,$0,0xa #$2 has addr 10000a
[00400020] syscall 0x0
[00400024] addi    $29,$29,-4 #00400024 #start the stack
[00400028] sw      $31,0($29) #store $ra in $sp
[0040002c] lui     $1,0x1001 #$1 has value in addr 0x10010000
[00400030] ori     $4,$1,0x4 #put 10010004 in register $4
[00400034] addi    $2,$0,4
[00400038] syscall 0x0
[0040003c] jal     0x4000a0 ##label 2 jump and link to instruction at addr 0x4000a0, 0x40003c
[00400040] lui     $1,0x1001 #$1 has addr 0x1001
[00400044] ori     $17,$1,0x60 #put 10010060 in register $17  h o n e y p o t p a s s w o r //addr: 00400044
[00400048] lw      $17,0($17)
[0040004c] lui     $1,0x1001
[00400050] ori     $19,$1,0x90 #put 10010090 in register $19 t x s e g j t i     t e r p 
[00400054] lui     $1,0x1001
[00400058] ori     $4,$1,0x9c #put 1001009c in register $4 t x s e g j t i     t e r p 
[0040005c] lw      $18,12($4) #$18 is 12 bytes from $4
[00400060] addu    $4,$0,$19
[00400064] lui     $5,0x1001
[00400068] jal     0x4000f0 #jump and link to instruction at addr 0x4000f0
[0040006c] bne     $2,$0,0x400088 #compare to instruction at addr 0x400088
[00400070] lui     $1,0x1001
[00400074] ori     $4,$1,0xc8 #put 100100c8 in register $1 t s 4 u c 3
[00400078] addi    $2,$0,4
[0040007c] syscall 0x0
[00400080] j       0x40003c #jump to instruction at addr 0x40003c
[00400084] lui     $1,0x1001
[00400088] ori     $4,$1,0xd4 #instruction at addr 00400088 #put instruction 100100d4 at register $4 :n   w e l c o m e !  
[0040008c] addi    $2,$0,4
[00400090] syscall 0x0
[00400094] lw      $31,0($29)
[00400098] addi    $29,$29,4
[0040009c] jr      $31
[004000a0] addi    $29,$29,-4 #0x4000a0
[004000a4] sw      $4,0($29)
[004000a8] lui     $1,0x1001
[004000ac] ori     $4,$1,0x34 #put 10010034 in register $1: P l e a s e e n t e r 
[004000b0] addi    $2,$0,4
[004000b4] syscall 0x0
[004000b8] lui     $4,0x1001
[004000bc] addi    $5,$0,12 #1000012
[004000c0] addi    $2,$0,8
[004000c4] syscall 0x0
[004000c8] lui     $1,0x1001
[004000cc] ori     $4,$1,0x54 #put 10010054 in register $4: I r e a d :
[004000d0] addi    $2,$0,4
[004000d4] syscall 0x0
[004000d8] lui     $4,0x1001
[004000dc] addi    $2,$0,4
[004000e0] syscall 0x0
[004000e4] lw      $4,0($29)
[004000e8] addi    $29,$29,4
[004000ec] jr      $31
[004000f0] addi    $29,$29,-8  #004000f0
[004000f4] sw      $4,0($29) #put 10010054 in memory
[004000f8] sw      $5,4($29) #add
[004000fc] ori     $8,$0,0x0 #put 1000000 in register $8  
[00400100] ori     $9,$0,0x8 #put 1000080 in register $9 e s s f o o r o o t 
[00400104] ori     $2,$0,0x1 #put 1000010 in register $2 h e G l o b a l F o u n d r
[00400108] add     $11,$5,$9
[0040010c] slt     $1,$5,$11 #instruction at addr 0x40010c
[00400110] beq     $1,$0,0x400138 #compare to instruction at addr 0x400138
[00400114] lb      $9,0($4) #register $9 have the addr of register $4
[00400118] lb      $10,0($5) #register $10 have the addr of register $5
[0040011c] addi    $10,$10,1
[00400120] bne     $9,$10,0x400134 #compare to instruction at addr 0x400134
[00400124] addi    $4,$4,1
[00400128] addi    $5,$5,1
[0040012c] j       0x40010c #jump to instruction at addr 0x40010c
[00400130] ori     $2,$0,0x0
[00400134] lw      $4,0($29) #instruction at addr 0x400134
[00400138] lw      $5,4($29) #instruction at addr 0x400138 
[0040013c] addi    $29,$29,8
[00400140] jr      $31

#0x4000a0
#0x40003c
#0x400024
#0x4000f0
#0x40010c