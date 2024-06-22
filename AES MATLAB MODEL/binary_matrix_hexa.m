% function to transform 4x32 binary matrix into 4x4 hexadecimal matrix
% input is 4x32 binary matrix 
% output hexadecimal matrix 4x4
function state_hexa = binary_matrix_hexa(input_state)
 j=1;
 state_hexa = strings(4, 4); %declaring the hexadecimal matrix
 first_byte = []; % used to extract the first 4 bits in the byte
 second_byte = []; %used to extract the second 4 bits in the byte
 %looping on each word
for i=1:4
     j=1;
     %looping on each byte in the word
    for byte=1:4 
        %extracting each hexadecimal character in the byte in the 2 variables first_byte, second_byte
     first_byte = input_state(i,j:j+4-1); %%%% extracting first 4 bits %%%% 
     second_byte = input_state(i,j+4:j+8-1); %%%%%%%%%%% extracting second 4 bits %%%%%%%%%
     %convert from binary to hexadecimal the 2 binaryvectors after performing concatenation operation
     Hexa_decimal = binaryVectorToHex( [first_byte second_byte] );
     %store the hexadecimal character in the proper word using i counter and in the proper column using byte index
     state_hexa(i,byte)=Hexa_decimal;
     %increment j by 8 to access the next 8 bits to transform them to hexadecimal base.
     j=j+8;   
        
    end 
end 

end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



