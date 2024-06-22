add_round_key.m -> performs add_round operation of the AES algorithm
binary_matrix_hexa.m -> transforms 4x32 binary matrix to 4x4 hexadecimal matrix
hexa_matrix_binary.m -> transforms 4x4 hexa matrix to 4x32 binary matrix. 
key_expansion.m -> used to produce the required key for encryption process each round
input_generation.m -> used to randomize and generate the input matrices (cipher text, key) for AES algorithm
shift_rows.m -> used to perform shift_rows operation which is part of the main pillars of the AES algorithm
mix_columns.m -> used to perform mix_columns operation 
sub_byte.m -> used to perform byte substitutions using S-box table from fips standard
sub_word.m -> used to perform byte subsitutions on a word instead of a matrix
AES.m -> the main code of the AES that formulates the main encryption process
test.m -> used to test the AES algorithm.


------> to operate and produce a result run test.m 