.globl write_matrix

.text
# ==============================================================================
# FUNCTION: Writes a matrix of integers into a binary file
#   If any file operation fails or doesn't write the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes of the file will be two 4 byte ints representing the
#   numbers of rows and columns respectively. Every 4 bytes thereafter is an
#   element of the matrix in row-major order.
# Arguments:
#   a0 is the pointer to string representing the filename
#   a1 is the pointer to the start of the matrix in memory
#   a2 is the number of rows in the matrix
#   a3 is the number of columns in the matrix
# Returns:
#   None
# ==============================================================================
write_matrix:

    # Prologue
    addi sp, sp, -20
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw ra, 16(sp)
    
    add s0, a0, x0
    add s1, a1, x0
    add s2, a2, x0
    add s3, a3, x0
    #addi a0, x0, 8

    add a1, s0, x0
    addi a2, x0, 1
    #arg a1 filename arg a2 perm ret a0 fil desc
    jal fopen
    addi t6, x0, -1
    beq a0, t6, eof_or_error
    add t1, a0, x0
    
    addi a0, x0, 4
    jal malloc
    add t3, a0, x0
    sw s2, 0(t3)
    
    addi a0, x0, 4
    jal malloc
    add t4, a0, x0
    sw s3, 0(t4)
    
        #write numbers row in matrix
    add a1, t1, x0
    add a2, t3, x0
    #mul t2, s2, s3
    addi a3, x0, 1
    addi a4, x0, 4    
    jal fwrite
   bne a0, a3, eof_or_error
   
            #write numbers col in matrix
    add a1, t1, x0
    add a2, t4, x0
    #mul t2, s2, s3
    addi a3, x0, 1
    addi a4, x0, 4    
    jal fwrite
   bne a0, a3, eof_or_error
   
        #write numbers in matrix
    add a1, t1, x0
    add a2, s1, x0
    mul t2, s2, s3
    add a3, x0, t2
    addi a4, x0, 4    
    jal fwrite
   bne a0, a3, eof_or_error
   
   
   
    
    #arg a1 file desc ret a0 success
    jal fclose
    bne a0, x0, eof_or_error


   # add a0, a2, x0
   # lw a1, 0(s1)
   # lw a2, 0(s2)
    # Epilogue
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw ra, 16(sp)
    addi sp, sp, 20 

    ret

eof_or_error:
    li a1 1
    jal exit2
    