.globl relu
#.data 
#m0: .word 1 -2 3 -4 5 -6 7 -8 9 # MAKE CHANGES HERE
.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 is the pointer to the array
#	a1 is the # of elements in the array
# Returns:
#	None
# ==============================================================================

relu:
    # Prologue
    addi sp, sp, -20
    sw s1, 0(sp)
    sw s2, 4(sp)
    sw s3, 8(sp)
    sw s4, 12(sp)
    sw ra, 16(sp)



loop_start:
    #add s0, a0, x0
    add s1, x0, x0
    addi s4, x0, 0
    
loop_continue:
   
    add s3, a0, s1
    lw s2, 0(s3)

    
    blt s2, x0, settozero
    cont:

    
    addi s1, s1, 4
    addi s4, s4, 1
    bne a1, s4, loop_continue
    j loop_end

settozero:
    sw x0, 0(s3)
    j cont

loop_end:
    

    # Epilogue
    lw ra, 16(sp)
    lw s4, 12(sp)
    lw s3, 8(sp)
    lw s2, 4(sp)
    lw s1, 0(sp)
    addi sp, sp, 20
    
	jr ra
