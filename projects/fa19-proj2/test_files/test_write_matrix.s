.import ../write_matrix.s
.import ../utils.s

.data
m0: .word 8, 2, 4, 1, 5, 6 # MAKE CHANGES HERE
file_path: .asciiz "test_output.bin"

.text
main:
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
    # Write the matrix to a file
   # addi t1, x0, 3
   # addi a0, x0, 4
   # jal malloc 
    addi a2, x0, 2
   # lw t1, 0(a2)
      
   # addi t1, x0, 3
    #addi a0, x0, 4
    #jal malloc 
   addi a3, x0, 3
   # lw t1, 0(a3)
    
    la a0, file_path
    la a1, m0

    jal write_matrix


    # Exit the program
    addi a0 x0 10
    ecall