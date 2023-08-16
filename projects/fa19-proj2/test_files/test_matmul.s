.import ../matmul.s
.import ../utils.s
.import ../dot.s

# static values for testing
.data
m0: .word 3 3 3 3 
m1: .word 3 3 3 3
d: .word 0 0 0 0 # allocate static space for output
# 	a0 is the pointer to the start of m0
#	a1 is the # of rows (height) of m0
#	a2 is the # of columns (width) of m0
#	a3 is the pointer to the start of m1
# 	a4 is the # of rows (height) of m1
#	a5 is the # of columns (width) of m1
#	a6 is the pointer to the the start of d
.text
main:
    # Load addresses of input matrices (which are in static memory), and set their dimensions
    la a0, m0
    la a3, m1
    la a6, d
    addi a1, x0, 2 
    addi a2, x0, 2
    addi a4, x0, 2 
    addi a5, x0, 2 


    # Call matrix multiply, m0 * m1
    jal ra matmul



    # Print the output (use print_int_array in utils.s)
    #   a0 is the pointer to the start of the array
    #   a1 is the # of rows in the array
    #   a2 is the # of columns in the array
    add a0, a6, x0
    addi a1, x0, 2 
    addi a2, x0, 2
    jal print_int_array



    # Exit the program
    jal exit