## array-summation subroutine
## register use:
##	$a0: parameter: array addr; used as pointer to current element
##	$a1: parameter: points just after the array end
##	$a2: parameter: array size
##	$v0: accumulator and return value
##	$t2: temporary copy of current array element
##      $t3: loop index
##      $t6: offset
## Diep (Emma) Vu 14 Feb 2023


                             # REMOVE this comment and the next one
PR_INT = 1                   # (example of defining a constant)
        .data
output: .asciiz "Array sum: "
array:  .word -123, 548, 923, 431, 560, -348, 961
endarr:
        .text                   # start of code section
        .align 2                # align to start code on a word boundary
        .globl main             # make 'main' visible to the simulator
main:   
        

        la $a0, array        # a0 points into array
        la $a1, endarr       # a1 points to array end
        sub $a1, $a1, $a0
        sra $a1, $a1, 2      #a1 is asize, the size of array
        add $t3, $0, $0      # t3 is the current index array element
        
	addi $sp, $sp, -4    # push 
	sw $ra, 0($sp)       #   ret addr on stack
        jal arrsum
	lw $ra, 0($sp)       # pop
	addi $sp, $sp, 4     #   ret addr


        add $a0, $0, $v0     # copy sum into $a0
        add $t0, $0, $a0     #copy sum into $t0 as $a0 will be overwritten 

        li $v0, 4      # set syscall for printing string
        la $a0, output       # a0 points to output string
        syscall

        li $v0, 1
        la $a0, ($t0)
        syscall

        jr $ra                  


arrsum: 
        move $v0, $0         # v0 accumulates sum
        j done                  #initial jump before entering the loop for edge case array size = 0
sum:    
        sll $t6, $t3, 2               #$t6 = 4*i
        add $t6, $a0, $t6             #t6 = &a[i]
        lw $t2, 0($t6)       #    get next array element
        add $v0, $v0, $t2    #    add it in
        addi $t3, $t3, 1        #increment counter
done:   
        blt $t3, $a1, sum       #check if the counter less than size array, then enter the loop
        jr $ra
