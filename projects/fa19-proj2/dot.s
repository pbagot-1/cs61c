.globl dot
#.data
#m0: .word 1 2 3 # MAKE CHANGES HERE
#m1: .word 1 2 3 # MAKE CHANGES HERE
#m2: .word 3
#m3: .word 1 # MAKE CHANGES HERE
#m4: .word 1 # MAKE CHANGES HERE

.text
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
#main:
#la a0, m0
#la a1, m1 
#la a2 m2
#lw a2, 0(a2)
#la a3 m3
#lw a3, 0(a3)
#la a4 m4
#lw a4, 0(a4)
#jal dot
dot:

    addi sp, sp, -48
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

    add s1, x0, a0
    add s2, x0, a1
    add s3, x0, x0
    add s4, x0, x0
    addi s10, x0, 4
    addi s11 ,x0, 4
    mul s5, a3, s10
    mul s6, a4, s11
    
    add a0, x0, x0
    jal loop_start

loop_start:
    
    lw s7, 0(s1)
    lw s8, 0(s2)
    mul s9, s7, s8
    add a0, a0, s9
    add s1, s1, s5
    add s2, s2, s6
    addi s4, s4, 1
    
    bne s4, a2, loop_start
    jal loop_end











loop_end:


    # Epilogue
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
    addi sp, sp, 48
    
    jr ra

