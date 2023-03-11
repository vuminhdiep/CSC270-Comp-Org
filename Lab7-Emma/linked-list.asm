#  Linked structures in assembler       D. Hemmendinger  24 January 2009
#  Linked structures in assembler       J. Rieffel 15 February 2011 Diep (Emma) Vu
# (removed dependance on in-line constant definitions)
#  This program builds a heap as a singly-linked list of nodes that
#  are then used to build a singly-linked list of numbers.
#       mknodes: builds a linked list of free nodes from an 
#                 unstructured heap space. 
#       new:    (you complete it) returns a node from the free list
#       insert: (you write) inserts an integer into a linked list, in order.
#       print:  (you write) traverses a list and prints its contents neatly

## System calls
PR_INT = 1
PR_STR = 4

## Node structure
NEXT     = 0    ## offset to next pointer
DATA     = 4    ## offset to data
DATASIZE = 4
NODESIZE = 8    ##DATA + DATASIZE       bytes per node
NUMNODES = 15
HEAPSIZE = 120  ##NODESIZE*NUMNODES
NIL      = 0     ## for null pointer

        .data
#input: .word 5, 4, 3, 8, 2, 6, 7, 1, 9, 10, 11, 12, 13, 14, 15, 16 #cause the program to terminate because out of free nodes
input: .word 5, 4, 3, 8, 2, 6, 7, 1 # you add more numbers here  (no more than NUMNODES)
inp_end:
INSIZE = 1 #(inp_end - input)/4    # number of input array elements

heap:   .space  HEAPSIZE           # storage for nodes
spce:   .asciiz "  "
nofree: .asciiz "Out of free nodes; terminating program\n"

        .align 2
        .text
main:   
        addi $sp, $sp, -4
        sw $ra, 0($sp)
        li $s7, NIL             # global variable holding the NIL value
        la $a0, heap            # pass the heap address to mknodes
        li $a1, HEAPSIZE	      # and its size
        li $a2, NODESIZE 	      # and the size of a node
        jal mknodes

	# initially our linked list will be empty (nil)
	# lw, $a0, input
	# li, $a1, nil
	# move $a2, $v0  presuming $v0 contains a pointer to free after mknodes is called

        la $s0, input
        la $s1, inp_end

        lw $a0, 0($s0)          # load into $a0 the first index of the array for insertion
        move $a2, $v0           # $a2 is the free pointer
        move $a1, $s7           # $a1 is the list pointer

        jal insert              #insert first value into input

# Loop to insert all values in input as linkedlist

        add $s2, $0, 1         # initialize the counter
insert_loop:   
        sll $s3, $s2, 2
        add $s3, $s0, $s3
        lw $a0, 0($s3)          #load into $a0 the input want to insert
        move $a2, $v1           # $a2 = &v1
        move $a1, $v0           # $a1 = &v0
        beq $a0, $s7, done      #while the input is not NIL (not at the end of linkedlist)
        jal insert
        addi $s2, $s2, 1       # increment the counter
        j insert_loop

done:   
        move $a0, $v0           #save listptr to $a0
        jal print
        lw $ra, 0($sp)          #pop $ra off the stack
        addi $sp, $sp, 4        #restore stack
        jr $ra

# mknodes takes a heap address in a0, its byte-size in a1, and node size in a2
#  and partitions it into a singly-linked list of nodesize
# (NODESIZE-byte) nodes, pointed to by free.  
# NOTE:  the list is built with free pointing to the last node in the
#    heap area, which points to the previous one, etc.  The reason for
#    this construction is to be sure that you get nodes by calling
#    "new" rather than by rebuilding the heap yourself!  
# Register usage:
# inputs:
# $a0 contains a pointer to the heap
# $a1 contains the heapsize
# $a2 contains the nodesize

# used registers
# $t0: pointer to block that will become a node, the address
# $t1: pointer to previous block (will become next node)

# $v0: points to the first free node in the heap

mknodes:
        add $t0, $a0, $a1       # t0 starts by pointing to the last
        sub $t0, $t0, $a2       # node-sized block in the heap
        move  $v0, $t0          # set output v0 to point to that first node
mkloop: 
        sub $t1, $t0, $a2       # t1 points to previous node-sized block
        sw  $t1, NEXT($t0)      # link the t0->node to point to t1 node
        move $t0, $t1           # back up t0 by one node
        bne $t0, $a0, mkloop    # repeat if not at heap-start
        sw $s7, NEXT($t1)       # ground node (first block in heap)
        jr $ra


# Removes a node from free (passed in via $a0), returning a pointer to the node
# in $v0,
# and a pointer to the new free in $v1
#  ( returns NIL if none available)
# inputs:
#    $a0: points to the first "free" node in the heap
# outputs:
#    $v0: the node we have "created" (pulled off the stack from free)
#    $v1: the new value of free (we don't want to clobber $a0 when we change
#         free, right? right?)

new:    #if $a0 is NIL, move $v0, $s7 and move $v1, $s7
        bne $a0, $s7, is_free    #check if free list is empty
        move $v0, $s7           # $v0: NIl
        move $v1, $s7           # $v1: NIL
        j new_done

is_free: 
        move $v0, $a0           #$v0: $a0 (new node address)
        lw $v1, NEXT($a0)       #address of next node (must be free)
new_done:
        jr $ra



#insert behaves as described in the lab text
# inputs:
#	 $a0: should contain N
#	 $a1: should contain a pointer to our linked list (listptr)
#	 $a2: should contain a pointer to free
#
# outputs:
# 	$v0 should contain the new pointer to our linked list
#	$v1 should contain the new pointer to free

insert: 
        addi $sp, $sp, -8       # allocate space on the stack
        sw $ra, 0($sp)
        sw $a0, 4($sp)          # push $a0 onto the stack
        move $a0, $a2           # $a0 = &a2
        jal new                 # $v0 = tmmptr 
        lw $a0, 4($sp)          # restore $a0 to the stack

        beq $v0, $s7, out_of_nodes      #check if next == NIL
        move $t0, $v0                   #$t0 = tmpptr (tmmptr = new node)
        sw $a0, DATA($t0)               #tmptr.data = N
        beq $a1, $s7, if_body           #check if listptr == NIL
        lw $t1, DATA($a1)               #$t1 = listptr.data
        ble $t1, $a0, else              #OR check if N < listptr.data

if_body:   
        sw $a1, NEXT($t0)               #tmptr.next = listptr
        move $a1, $t0                   #listptr = tmptr
        j insert_done               

else:   move $t2, $a1                   #$t2: curptr = listptr

while:  
        lw $t3, NEXT($t2)               #$t3 = curptr.next
        beq $t3, $s7, while_done        #if curptr.next == NIL exit loop
        lw $t4, DATA($t3)               #$t4 = curptr.next.data
        blt $a0, $t4, while_done        #AND if N < nextptr.data exit loop
        move $t2, $t3                   #curptr = curptr.next
        j while                 

while_done: 
        lw $t5, NEXT($t2)               #$t5 = curptr.next
        sw $t5, NEXT($t0)               #tmptr.next = curptr.next
        sw $t0, NEXT($t2)               #curptr.next = tmptr

insert_done:
        move $v0, $a1                   # $v0 = &a1 (return listptr)
        lw $ra, 0($sp)                  # pop $ra off the stack
        addi $sp, $sp, 8                #restore stack
        jr $ra                  

out_of_nodes: 
        move $t0, $a0                   # $t0 = &a0 because $a0 will be overwritten later
        move $t1, $v0                   # $t1 = $v0 because $v0 will be overwritten later

        li $v0, PR_STR                  #load to print string
        la $a0, nofree                  #print error message
        syscall

        move $a0, $t0                   #restore $a0
        move $v0, $t1                   #restore $a1
        j insert_done


#print out the linkedlist
#$a0: listptr
## C code: 
# void print(Node *listptr) {
#     Node *current_node = listptr;
#    	while (current_node != NULL) {
#         printf(current_node.data);
#         current_node = current_node.next;
#     }
# }

print:
        move $t0, $a0                   # $t0 = &a0
print_loop:
        beq $t0, $s7, print_done        #if t0 == NIL exit loop
        lw $t1, DATA($t0)               #t1 = t0.data
        move $a0, $t1                   # Load the current integer from the linked list into $a0
        li $v0, PR_INT                  # syscall to print an integer
        syscall                 

        li $v0, PR_STR                  #load to print string
        la $a0, spce                    # syscall to print space between each node
        syscall
    
        lw $t0, NEXT($t0)               #t0 = t0.next
        j print_loop
       
print_done:
        jr $ra