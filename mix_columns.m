function state = mix_columns(input_state)
%converting input binary matrix to hexadecimal%
%%%%%%%%%%%% mix_columns takes input matrix as hexadecimal %%%%%%%%%%%%%%
%%%%%%%%%%%%%% mix columns
input_state = binary_matrix_hexa(input_state);
input_state = hex2dec(input_state);

Pre_fixed_reduction = [0 0 0 1 1 0 1 1]; 
pre_defined_matrix = [ 2   3   1   1;
                       1   2   3   1;
                       1   1   2   3;
                       3   1   1   2];
column = 1;
result = zeros(1,4);
%%%%%%%%%%% looping on columns of the state matrix for matrix multiplications and rows of predefined matrix for multiply%%%%%%%%%%%%%%%%
    for column = 1:4 %%%%%%%% looping on columns of the input state
            for row=1:4  %%%%%%%%%%%%% looping on rows of the predefined matrix 
                    for element = 1:4  %%%%%% looping on each byte in the predefined matrix to apply galoa field operations
                            if pre_defined_matrix(row,element) == 1
                                result(element) = input_state(element,column); %%%%% same as the input number %%%%
                            elseif pre_defined_matrix(row,element) == 2
                    %%%%%%%%% 2 cases for the MSb of the binary equivelant of the input_state element%%
                                extracted_binary = decimalToBinaryVector(input_state(element,column),8);
                                if(extracted_binary(1) == 1) %%% if MSB is 1 shift left and xor using the pre_fixed_reduction
                                    extracted_binary = bitxor([extracted_binary(2:8) 0 ] ,Pre_fixed_reduction);     
                                else 
                                    extracted_binary = [extracted_binary(2:8) 0 ]; %if MSB is 0 shift left only
                                end 
                                result(element) = binaryVectorToDecimal(extracted_binary);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
                            elseif pre_defined_matrix(row,element) == 3
                    %%%%%%%%%%%%%%% multiply by 2 case then multiply by 1 then xor between them %%%%%% 
                               extracted_binary = decimalToBinaryVector(input_state(element,column),8);
                               if(extracted_binary(1) == 1) %%% if MSB is 1 shift left and xor using the pre_fixed_reduction
                                    extracted_binary = bitxor([extracted_binary(2:8) 0 ] ,Pre_fixed_reduction);     
                               else 
                                    extracted_binary = [extracted_binary(2:8) 0 ]; %if MSB is 0 shift left only
                               end  
                               dec2hex(input_state(element,column));
                               extracted_binary_2 = decimalToBinaryVector(input_state(element,column),8);
                               result(element) = binaryVectorToDecimal(bitxor(extracted_binary,extracted_binary_2)); %final result in case of 3 xor between operation on 3 and operation on 2
                            end     
                        
                    end 
                    state(row,column) = bitxor(bitxor(result(1),result(2)),bitxor(result(3),result(4))); %xoring between the 4 bytes of the column and row multiplication
            end 

    end
    
 state = compose("%X",state);   
 state = hexa_matrix_binary(state);
end 