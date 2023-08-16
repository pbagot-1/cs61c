.import read_matrix.s
.import write_matrix.s
.import matmul.s
.import dot.s
.import relu.s
.import argmax.s
.import utils.s

.globl main

.text
main:
    # =====================================
    # COMMAND LINE ARGUMENTS
    # =====================================
    # Args:
    #   a0: int argc
    #   a1: char** argv
    #
    # Usage:
    #   main.s <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>

    # Exit if incorrect number of command line args
    addi t1, x0, 5
    bne a0, t1, error_with_args
  
    add s0, a0, x0
    add s1, a1, x0
    
	# =====================================
    # LOAD MATRICES
    # =====================================
    # Arguments:
    #   a0 is the pointer to string representing the filename
    #   a1 is a pointer to an integer, we will set it to the number of rows
    #   a2 is a pointer to an integer, we will set it to the number of columns
    # Returns:
    #   a0 is the pointer to the matrix in memory
    

    # Load pretrained m0
    addi a0, x0, 4
    jal malloc 
    add a1, a0, x0

    addi, sp, sp, -4
    sw a1, 0(sp)
    addi a0, x0, 4
    jal malloc 
    add a2, a0, x0
    lw a1, 0(sp)
    addi sp, sp, 4
    lw a0, 4(s1)
     
   #jal print_int
    jal read_matrix
    #jal print_int
       
    add s3, a0, x0
    
   #m0 rows and col numbs
   add s4, a1, x0
   add s5, a2, x0


    # Load pretrained m1
    addi a0, x0, 4
    jal malloc 
    add a1, a0, x0
    
    addi, sp, sp, -4
    sw a1, 0(sp)
    
    addi a0, x0, 4
    jal malloc 
    add a2, a0, x0
    
    lw a1, 0(sp)
    addi sp, sp, 4
        
    lw a0, 8(s1)
   

      #m1 rows and col numbs
    jal read_matrix
    add s6, a0, x0
    add s7, a1, x0
    add s8, a2, x0

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
   # add a0, s6, x0
   # addi a1, x0, 3
   # addi a2, x0, 3
   # jal print_int_array
   # jal exit




    # Load input matrix
    addi a0, x0, 4
    jal malloc 
    add a1, a0, x0
    addi, sp, sp, -4
    sw a1, 0(sp)
    
    addi a0, x0, 4
    jal malloc 
    add a2, a0, x0
        
    lw a1, 0(sp)
    addi sp, sp, 4
      
    lw a0, 12(s1)
   
    jal read_matrix
    
    add s9, a0, x0
   #input rows and col numbs

    add s10, a1, x0
    add s11, a2, x0

   


    # =====================================
    # RUN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input
    # 2. NONLINEAR LAYER: ReLU(m0 * input)
    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)
 
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
 
 # 1. LINEAR LAYER:    m0 * input  
  #malloc space for new matrix d
    add t4, x0, s4
    mul t4, t4, s11
    add t5, t4, x0
    slli t4, t4, 2
    add a0, t4, x0
    jal malloc
    add a6, a0, x0
     
     add a0, s3, x0
     add a1, x0, s4
     #jal print_int
     add a2, x0, s5
     #add a1, a2, x0
    # jal print_int
     add a3, s9, x0
     add a4, x0, s10
     add a5, x0, s11

     jal matmul
     
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
    #add a0, a6, x0
    #addi a1, x0, 3
    #addi a2, x0, 1
    #jal print_int_array
   # jal exit

    
    # add a6
        #jal exit
    #relu on d
    # 	a0 is the pointer to the array
    #	a1 is the # of elements in the array
    # Returns:
    #	None
    add a0, a6, x0
    add a1, t5, x0
    jal relu

    #malloc for last layer
    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)
    add t4, x0, s7
    mul t4, t4, s11
    add t5, t4, x0
    slli t4, t4, 2
    add a0, t4, x0
    jal malloc
    add a7, a0, x0

    
    # 	a0 is the pointer to the start of m0
#	a1 is the # of rows (height) of m0
#	a2 is the # of columns (width) of m0
#	a3 is the pointer to the start of m1
# 	a4 is the # of rows (height) of m1
#	a5 is the # of columns (width) of m1
#	a6 is the pointer to the the start of d
# Returns:
#	None, sets d = matmul(m0, m1)
    add a0, s6, x0
    add a1, x0, s7
    add a2, x0, s8
    add a3, a6, x0
    add a4, x0, s4
    add a5, x0, s11
    add a6, a7, x0
    
    jal matmul
    
    
    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix
    lw a0 16(s1) # Load pointer to output filename
    
    

# Arguments:
#   a0 is the pointer to string representing the filename
#   a1 is the pointer to the start of the matrix in memory
#   a2 is the number of rows in the matrix
#   a3 is the number of columns in the matrix
     add a1, a6, x0
     add a2, x0, s7
     add a3, x0, s11

     jal write_matrix

    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax
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
    add a2, x0, s7
    add a3, x0, s11
    mul t3, a2, a3
    add a0, a6, x0
    add a1, t3, x0
    jal argmax


    # Print classification

    add a1, a0, x0
    jal print_int


    # Print newline afterwards for clarity
    li a1 '\n'
    jal print_char

    jal exit
    
    error_with_args:
    li a1 3
    jal exit2
