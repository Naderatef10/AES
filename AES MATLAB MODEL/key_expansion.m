%to be implemented... this is the final function in the AES algorithm.
% key is 4x32 binary input
% output is 4x32 binary matrix
function key_output = key_expansion(key,round)
key = binary_matrix_hexa(key); %%%%%% transforming the key to hexadecimal
key = hex2dec(key); % transforming the key to decimal
key_output = key; % initializing the output of the function
R_conn = strings(4,1); % initializing R_conn which is a constant word depending on the round number used in the key expanison operation

%switch case on the round number to choose the suitable R_conn vector to generate the new key
% this look up table is extracted from the fips standard.
switch round 
    case 1
        R_conn = ["01";"00";"00";"0"];
    case 2
        R_conn = ["02";"00";"00";"0"];
    case 3
        R_conn = ["04";"00";"00";"0"];
    case 4
        R_conn = ["08";"00";"00";"0"];
    case 5
        R_conn = ["10";"00";"00";"0"];
    case 6
        R_conn = ["20";"00";"00";"0"];
    case 7
        R_conn = ["40";"00";"00";"0"];
    case 8
        R_conn = ["80";"00";"00";"0"];
    case 9
        R_conn = ["1B";"00";"00";"0"];
    case 10
        R_conn = ["36";"00";"00";"0"];
end 
for i = 1:4 %%%%%% looping on column words
    if(i==1) %%%% first column word %%%
        rotated_word = [ key(2:4,4) ; key(1,4)];  %%%%%% rotating the last column initial byte to be in the bottom of the byte 
        sub_rotated_word = sub_word(rotated_word); %Perform byte subsitutuion using S-Box on the rotated vector
        xor_result_sub_word_original_word = bitxor(sub_rotated_word,key(:,i)); % performing bitwise xor between the first word and the vector produced from sbox
        key_output(:,i) = bitxor(xor_result_sub_word_original_word,hex2dec(R_conn)); %performing xor between the xor_result_sub_word_original_word and the Rconn
    else
        key_output(:,i) = bitxor(key_output(:,i-1),key(:,i)); %%% for any other column xor the old word with the new word in the previous column output.
        
    end 

end 
key_output = compose("%X",key_output); %%%%% transforming from decimal to hexadecimal 4x4 matrix 
key_output = hexa_matrix_binary(key_output); %transforming from hexadecimal to binary to 

end 