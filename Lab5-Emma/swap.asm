#   swap.asm	Diep (Emma) Vu 9 Feb 2023
#   Elementary program to swap in-place two elements in an array.
#   Register use:
#	$t0: temporarry storage for the base address of the array
#       $t1, t2: temporary registers to store the address of elements at chosen indices
#	$t3, t4: temporary registers to store the value at chosen indices
#	$v0, $a0: hold parameters to syscall

        .data                                       # FYI: start of data section
ar:     .word    5, 17, -3, 22, 120, -1             # three initial integer values
index1: .word    1
index2: .word    4


        .text                   # FYI: start of code section
        .align 2                # FYI: align to start code on a word boundary
        .globl main             # FYI: make 'main' visible to the simulator
main:                           # main() {
        la $t0, ar              # $t0 = &ar[0]
        lw $t1, index1          # $t1 = index1
        sll $t1, $t1, 2         # multiply index1 by 4 to get the offset in bytes
        add $t1, $t1, $t0       # $t1 = index1 + &ar[0]

        lw $t2, index2          # $t2 = index2
        sll $t2, $t2, 2         # multiply index2 by 4 to get the offset in bytes
        add $t2, $t2, $t0       # $t2 = index2 + &ar[0]

        lw $t3, 0($t1)          # $t3 = $t1 = &ar[index1]
        lw $t4, 0($t2)          # $t4 = $t2 = &ar[index2]
        sw $t4, 0($t1)          # ar[index1] = $t4
        sw $t3, 0($t2)          # ar[index2] = $t3

        #addi $v0, $0, 1         #    $v0   = code for 'print-int'
        #add  $a0, $0, $t1       #    $a0   = accum
        #syscall                 #    syscall($v0=1) prints $a0
        jr $ra                  # return control to simulator
                                # }

