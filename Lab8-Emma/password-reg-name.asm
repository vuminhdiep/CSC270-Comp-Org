main:
    lw $a0, 0x0 ($sp)
    addiu $a1, $sp, 0x4
    addiu $a2, $a1, 0x4
    sll $v0, $a0, 2
    addu $a2, $a2, $v0
    jal 0x400024 #label1
    sll $0, $0, 0
    ori $v0, $0, 0xa
    syscall

[00400024] label1: addi $sp, $sp, -0x4 #label 1
    sw $ra, 0x0($sp)
    lui $at, 0x1001($0)
    ori $a0, $at, 0x4
    addi $v0, $0, 0x4
    syscall #welcome

[0040003c] loop: jal 0x4000a0 #jal label2
lui $at, 0x1001($0)
ori $s1, $at, 0x60
lw $s1, 0x0($s1) #honeypotpasswor
lui $at, 0x1001($0)
ori $s3, $at, 0x90 #txsegjti
lui $at, 0x1001($0)
ori $a0, $at, 0x9c #terp
lw $s2, 0xc($a0) #a8
addu $a0, $0, $s3 #a0 = txsegjti
lui $a1, 0x1001($0)
jal 0x4000f0 #jal label3
bne $0, $v0, 0x6 #v0 = 0 or 1
lui $at, 0x1001($0)
ori $a0, $at, 0xc8
addi $v0, $0, 0x4
syscall
j 0x40003c #j loop
lui $at, 0x1001($0)

ori $a0, $at, 0xd4
addi $v0, $0, 0x4
syscall
lw $ra, 0x0($sp)
addi $sp, $sp, 0x4
jr $ra

[004000a0] label2: 
addi $sp, $sp, -0x4 
sw $a0, 0x0($sp)

lui $at, 0x1001($0)
ori $a0, $at, 0x34
addi $v0, $0, 0x4
syscall #please...

lui $a0, 0x1001($0)
addi $a1, $0, 0xc
addi $v0, $0, 0x8 #password has 8 characters
syscall #where to insert

lui $at, 0x1001($0)
ori $a0, $at, 0x54
addi $v0, $0, 0x4
syscall #I read...

lui $a0, 0x1001($0)
addi $v0, $0, 0x4
syscall
lw $a0, 0x0($sp)
addi $sp, $sp, 0x4
jr $ra

#Check password
[004000f0] label3: addi $sp, $sp, -0x8 
sw $a0, 0x0($sp)
sw $a1, 0x4($sp)
ori $t0, $0, 0x0
ori $t1, $0, 0x8
ori $v0, $0, 0x1
add $t3, $a1, $t1

[0040010c] branch1: slt $at, $a1, $t3 #branch1 if value at a1 less than password length
beq $0, $at, 0x9
lb $t1, 0x0($a0) #t1 = each character in txsegjti
lb $t2, 0x0($a1) #
addi $t2, $t2, 0x1 #t2 = t2 + 1
bne $t2, $t1, 0x4 #compare t1 to t2+1
addi $a0, $a0, 0x1
addi $a1, $a1, 0x1
j 0x40010c #branch1
ori $v0, $0, 0x0
lw $a0, 0x0($sp)
lw $a1, 0x4($sp)
addi $sp, $sp, 0x8
jr $ra

.text
#0x4000a0 #label3
#0x40003c #label2
#0x400024 #label1
#0x4000f0 [004000f0]
#0x40010c

#find a0 and a1
#password has 8 characters