%to be implemented... this is the final function in the AES algorithm.
% key is 4x32 binary input
% output is 4x32 binary matrix
function key_output = key_expansion(key,round)
key = binary_matrix_hexa(key);
key = hex2dec(key); 
key_output = key;
R_conn = strings(4,1);
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
for i = 1:4 %looping on column words
    if(i==1)
        rotated_word = [ key(2:4,4) ; key(1,4)]; 
        sub_rotated_word = sub_word(rotated_word); %this step is the most cruical 
        xor_result_sub_word_original_word = bitxor(sub_rotated_word,key(:,i));
        key_output(:,i) = bitxor(xor_result_sub_word_original_word,hex2dec(R_conn));
    else
        key_output(:,i) = bitxor(key_output(:,i-1),key(:,i));
        
    end 







end 
key_output = compose("%X",key_output); 
key_output = hexa_matrix_binary(key_output);

end 