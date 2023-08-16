.import ../read_matrix.s
.import ../utils.s

.data
file_path: .asciiz "./test_input.bin"
m0: .word -1 -1 -1
.text
main:
    # Read matrix into memory
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

#================================================================
# void* malloc(int a0)
# Allocates heap memory and return a pointer to it
# args:
#   a0 is the # of bytes to allocate heap memory for
# return:
#   a0 is the pointer to the allocated heap memory
#================================================================
addi a0, x0, 4
jal malloc 
add a1, a0, x0

addi a0, x0, 4
jal malloc 
add a2, a0, x0


la a0, file_path

jal read_matrix

    # Print out elements of matrix
    #================================================================
# void print_int_array(int* a0, int a1, int a2)
# Prints an integer array, with spaces between the elements
# args:
#   a0 is the pointer to the start of the array
#   a1 is the # of rows in the array
#   a2 is the # of columns in the array
# return:
#   void
#================================================================

   jal print_int_array

    # Terminate the program
    addi a0, x0, 10
    ecall