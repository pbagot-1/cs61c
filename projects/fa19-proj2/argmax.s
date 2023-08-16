.globl argmax

#.data
#v0: .word 2 -42 2 2 -5 2 50 1000 2 # MAKE CHANGES HERE

.text
#main:
    # Load address of v0
   # la s0 v0
    
    # Set length of v0
  # addi s1 x0 9 # MAKE CHANGES HERE

    # Call argmax
  #  mv a0 s0
  #  mv a1 s1
   # jal ra argmax
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 is the pointer to the start of the vector
#	a1 is the # of elements in the vector
# Returns:
#	a0 is the first index of the largest element
# =================================================================
argmax:

    # Prologue
    addi sp, sp, -28
    sw s1, 0(sp)
    sw s2, 4(sp)
    sw s3, 8(sp)
    sw s4, 12(sp)
    sw s5, 16(sp)
    sw ra, 20(sp)
    sw s0, 24(sp)


loop_start:
    lw s0, 0(a0)
    add s1, x0, x0
    add s4, x0, x0
    add s5, x0, x0
    j loop_continue


loop_continue:
    add s3, a0, s1
    lw s2, 0(s3)
    
    #addi sp, sp, -4
    #sw a1, 0(sp)
    
   # mv a1, s3
    bgt s2, s0, newmax
    cont:
    #lw a1, 0(sp)
   # addi sp, sp, 4
    
    addi s1, s1, 4
    addi s4, s4, 1
    bne a1, s4, loop_continue
    j loop_end

newmax:
    add s0, s2, x0     
    add s5, s4, x0
    j cont

loop_end:
    
    add a0, s5, x0

    # Epilogue
    lw s0, 24(sp)
    lw ra, 20(sp)
    lw s5, 16(sp)
    lw s4, 12(sp)
    lw s3, 8(sp)
    lw s2, 4(sp)
    lw s1, 0(sp)
    addi sp, sp, 28
    
	jr ra
