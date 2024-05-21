function state_hexa = binary_matrix_hexa(input_state)
 j=1;
 state_hexa = strings(4, 4);
 first_byte = [];
 second_byte = [];
for i=1:4
     j=1;
    for byte=1:4 
     first_byte = input_state(i,j:j+4-1); %%%% extracting first byte %%%% 
     second_byte = input_state(i,j+4:j+8-1); %%%%%%%%%%% extracting second byte %%%%%%%%%
     Hexa_decimal = binaryVectorToHex( [first_byte second_byte] );
     state_hexa(i,byte)=Hexa_decimal;
     j=j+8;   
        
    end 
end 

end 





