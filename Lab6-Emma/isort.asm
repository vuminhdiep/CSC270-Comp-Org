##   isort.asm
##   sort an array in the ascending order
##   Register use:
##	$a0: base addr of array
##	$a1: number of items in array (asize)
##   $t0, $t1, $t2: i, j, tmp
##   $t3, $t4: array[i], array[j]
##   $t6, $t7: offset into array and addr of array[i], array[j]
## Diep (Emma) Vu 14 Feb 2023


		        .data                	    # start of data section
message:        .asciiz "Here is the array before and after sorting: \n"
comma:          .asciiz ", "
newline:        .asciiz "\n"
array:		    .word -13, 5, -3, 20, 6
endarr:
                .text                   	# start of code section
                .align 2                	# align to start code on a word boundary
                .globl main             	# make 'main' visible to the simulator
main:
    li $v0, 4                               # syscall to print a string
    la $a0, message                         # load address of the message string
    syscall

	la $a0, array		                    # $a0 = &array[0]
	la $a1, endarr			                # $a1 = &endarr
	sub $a1 $a1 $a0                         # $a1 = 4 * len(array)
	srl $a1 $a1 2                           # $a1 = len(array)


	addi $sp, $sp, -8                       # push 
	sw $ra, 0($sp)                          # ret addr on stack
    sw $a0, 4($sp)                          # preserve $a0 in the stack
    jal print_array
    lw $a0, 4($sp)
    jal isort
    jal print_array
    lw $ra, 0($sp)                          # pop
	addi $sp, $sp, 8                        # ret addr
       
    jr $ra  



## Subroutine to print an array of integers
##   Register use:
##	$a0: base addr of array
##	$a1: number of items in array (asize)
print_array:
    add $t0, $0, $a0     # $t0 = &a0
    add $t1, $0, $a1     # $t1 = &a1
    la $t2, comma       # Load the address of the comma into $t2
    la $t3, newline     # Load the address of the newline into $t2

print_loop:
    
    lw $a0, ($t0)           # Load the current integer from the array into $a0
    li $v0, 1               # syscall to print an integer
    syscall                 
  
    addi $t0, $t0, 4        # Increment the pointer to the next integer in the array
    addi $t1, $t1, -1       # Decrement the loop counter
    beq $t1, $0, done

    la $a0, ($t2)           # Load the comma into $a0
    li $v0, 4               # syscall to print a string
    syscall

    j print_loop

done:
    la $a0, ($t3)       # Load the newline into $a0
    li $v0, 4            # syscall to print a string
    syscall
    jr $ra                  


##Subroutine to do insertion sort

isort:
        addi $t0 $0 1			# i = 1        

sort_loop:
    bge $t0, $a1, exit                  # exit when i >= asize
    sll $t6 $t0 2                       # $t6 = 4 * i
    add $t6 $a0 $t6                     # $t6 = &array[i]
    lw $t2, 0($t6)                      # tmp = *$t6 = array[i]
    addi $t1, $t0, -1		        # j = i - 1

inner_loop:
    blt $t1, $0, outer_loop             #exit when j is 0
    sll $t7 $t1 2                       # $t7 = 4 * j
    add $t7 $a0 $t7                     # $t7 = &array[j]
    lw $t4, 0($t7)                      # $t4 = *$t7 = array[j]
    ble $t4, $t2, outer_loop            # go to outer_loop when array[j-1] <= tmp
    sw $t4, 4($t7)                  
    addi $t1 $t1 -1                     # j--
    j inner_loop

outer_loop:
    sll $t7 $t1 2                       # $t7 = 4 * j
    add $t7 $a0 $t7                     # $t7 = &array[j]
    sw $t2, 4($t7)                      
    addi $t0 $t0 1                      # i++
    j sort_loop

exit:
    jr $ra
