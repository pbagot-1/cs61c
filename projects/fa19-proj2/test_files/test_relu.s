.import ../relu.s
.import ../utils.s

# Set vector values for testing
.data 
m0: .word -1 -1 -2 -1 -6

 # MAKE CHANGES HERE


.text
# main function for testing
main:
    # Load address of m0
     addi a0, x0, 16
    jal malloc
    sw x0, 0(a0)
    sw x0, 4(a0)
    sw x0, 8(a0)
    sw x0, 12(a0)
    add s0, x0, a0

    # Set dimensions of m0
    li s1 1 # MAKE CHANGES HERE
    li s2 4 # MAKE CHANGES HERE

        mv a1, s1
    jal print_int
    mv a1, s2
    jal print_int
    
    # Print m0 before running relu
    mv a0 s0
    mv a1 s1
    mv a2 s2
    jal print_int_array

    # Print newline
    li a1 '\n'
    jal print_char

    
    #cehck err
    mv a1, sp
    jal print_int
     li a1 '\n'
    jal print_char
        mv a1, s1
    jal print_int
     li a1 '\n'
    jal print_char
        mv a1, s2
    jal print_int
     li a1 '\n'
    jal print_char
        mv a1, s3
    jal print_int
     li a1 '\n'
    jal print_char
    mv a1, s4
    jal print_int
    
    # Call relu function
    mv a0 s0
    mul a1 s1 s2 # Convert dimensions to total number of elements
    jal ra relu

      #cehck err
    mv a1, sp
    jal print_int
     li a1 '\n'
    jal print_char
        mv a1, s1
    jal print_int
     li a1 '\n'
    jal print_char
        mv a1, s2
    jal print_int
     li a1 '\n'
    jal print_char
        mv a1, s3
    jal print_int
     li a1 '\n'
    jal print_char
    mv a1, s4
    jal print_int
        # Print newline
    li a1 '\n'
    jal print_char
    
    mv a1, s1
    jal print_int
    mv a1, s2
    jal print_int
    
        # Print newline
    li a1 '\n'
    jal print_char
    

    # Print m0 after running relu
    #li s1 4
    mv a0 s0
    mv a1 s1
    mv a2 s2
    jal print_int_array

    # Exit
    jal exit
