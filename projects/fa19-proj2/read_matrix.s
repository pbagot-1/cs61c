.globl read_matrix
#.import utils.s
.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#   If any file operation fails or doesn't read the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 is the pointer to string representing the filename
#   a1 is a pointer to an integer, we will set it to the number of rows
#   a2 is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 is the pointer to the matrix in memory
# ==============================================================================
read_matrix:

    # Prologue
    addi sp, sp, -16 
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw ra, 12(sp)
    
    add s0, a0, x0
    add s1, a1, x0
    #jal print_int
    add s2, a2, x0
    addi a0, x0, 8

    #arg a0 number bytes ret a0 location
    jal malloc 
        
    add a1, s0, x0
    #read only
    add a2, x0, x0
    
    #t0 holds malloc loc
    add t0, a0, x0

    #arg a1 filename arg a2 perm ret a0 fil desc
    jal fopen

    addi t1, x0, -1
    beq a0, t1, eof_or_error
    
    add t1, a0, x0
    add a1, a0, x0
    add a2, t0, x0
    addi a3, x0, 8

    #arg a1 file desc arg a2 ptr to buffer arg a3 number bytes to read ret a0 bytes read
    jal fread
    #addi a2, a2, -8
    addi a3, x0, 8
   bne a0, a3, eof_or_error
    
    #store values of rows, columns
   # sw s1, 0(a2)
   # sw s2, 4(a2)
   # 
       
    lw a0, 0(a2)
    lw a1, 4(a2)
    #add a1, s1, x0
    #jal print_int
    #jal exit
    sw a0, 0(s1)
     #jal exit
    sw a1, 0(s2)
    #jal exit
    #jal print_int
    mul a0, a0, a1
    addi a1, x0, 4
    mul a0, a0, a1
    add t2, a0, x0

    #arg a0 number bytes ret a0 location
    jal malloc 
       
    add a2, a0, x0
    add a1, t1, x0
    add a3, t2, x0
   
    #arg a1 file desc arg a2 ptr to buffer arg a3 number bytes to read ret a0 bytes read
    jal fread
      
    bne a0, t2, eof_or_error
    

    #arg a1 file desc ret a0 success
    jal fclose
    
    bne a0, x0, eof_or_error


    add a0, a2, x0
    lw a1, 0(s1)
    lw a2, 0(s2)
    # Epilogue
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw ra, 12(sp)
    addi sp, sp, 16 

    ret

eof_or_error:
    li a1 1
    jal exit2
    