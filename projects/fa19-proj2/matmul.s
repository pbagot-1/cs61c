.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
#   If the dimensions don't match, exit with exit code 2
# Arguments:
# 	a0 is the pointer to the start of m0
#	a1 is the # of rows (height) of m0
#	a2 is the # of columns (width) of m0
#	a3 is the pointer to the start of m1
# 	a4 is the # of rows (height) of m1
#	a5 is the # of columns (width) of m1
#	a6 is the pointer to the the start of d
# Returns:
#	None, sets d = matmul(m0, m1)
# =======================================================
matmul:

    # Error if mismatched dimensions
    bne a2, a4, mismatched_dimensions

    # Prologue
    addi sp, sp, -52
    sw s1, 0(sp)
    sw s2, 4(sp)
    sw s3, 8(sp)
    sw s4, 12(sp)
    sw s5, 16(sp)
    sw s6, 20(sp)
    sw s7, 24(sp)
    sw s8, 28(sp)
    sw s9, 32(sp)
    sw s10, 36(sp)
    sw s11, 40(sp)
    sw ra, 44(sp)
    sw s0, 48(sp)
    
    #hold a6
    add s9, a6, x0
    #hold a5
    add s7, a5, x0
    #hold a2
    add s6, a2, x0
    addi s1, x0, 4
    # for gettin to the next row
    mul s2, s1, a2
    
    #hold a1
    add s3, a1, x0
    
    #hold a3
    add s4, a3, x0
    
    addi t1, x0, -1 
    mul t2, s2, t1
    #hold a0
    add s5, a0, t2
    
    addi s0, x0, -1
    add s8, x0, x0
outer_loop_start:
   
   add s5, s5, s2
   addi s0, s0, 1
   beq s0, s3, outer_loop_end 
   j inner_loop_start




inner_loop_start:
   add a0, s5, x0
   add a1, s4, x0
   add a2, s6, x0
   #!
   addi sp, sp, -4
   sw a3, 0(sp)
   addi a3, x0, 1
   add a4, s7, x0    
   jal dot
   #!
   lw a3, 0(sp)
   addi sp, sp, 4
   sw a0, 0(a6)
   addi a6, a6, 4
   addi s8, s8, 1
   beq s8, s7, inner_loop_end
   addi s4, s4, 4
   jal inner_loop_start

# Arguments:
#   a0 is the pointer to the start of v0
#   a1 is the pointer to the start of v1
#   a2 is the length of the vectors
#   a3 is the stride of v0
#   a4 is the stride of v1
# Returns:
#   a0 is the dot product of v0 and v1



inner_loop_end:
     add s8, x0, x0
     add s4, a3, x0
     jal outer_loop_start


outer_loop_end:

    add a6, s9, x0
    # Epilogue
    lw s0, 48(sp)
    lw ra, 44(sp)
    lw s11, 40(sp)
    lw s10, 36(sp)
    lw s9, 32(sp)
    lw s8, 28(sp)
    lw s7, 24(sp)
    lw s6, 20(sp)
    lw s5, 16(sp)
    lw s4, 12(sp)
    lw s3, 8(sp)
    lw s2, 4(sp)
    lw s1, 0(sp)
    addi sp, sp, 52
    
    jr ra


mismatched_dimensions:
    li a1 2
    jal exit2
    
    
    
    #from dot
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 is the pointer to the start of v0
#   a1 is the pointer to the start of v1
#   a2 is the length of the vectors
#   a3 is the stride of v0
#   a4 is the stride of v1
# Returns:
#   a0 is the dot product of v0 and v1
# =======================================================
