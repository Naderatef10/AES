function state = mix_columns(input_state)
%converting input binary matrix to hexadecimal%

%%%%%%%%%%%%%% mix columns
input_state = hex2dec(binary_matrix_hexa(input_state));

Pre_fixed_reduction = [0 0 0 1 1 0 1 1]; 
pre_defined_matrix = [ 2   3   1   1;
                       1   2   3   2;
                       1   1   2   3;
                       3   1   1   2];
column = 1;     
for row=1:4
        for element = 1:4
            if pre_defined_matrix(row,element) == 1
                result = decimalToBinaryVector(input_state(element,column)); %%%%% same as the input number %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                    
            elseif pre_defined_matrix(row,element) == 2
                    %%%%%%%%% 2 cases for the MSb of the binary equivelant of the input_state element%%
                
               extracted_binary = decimalToBinaryVector(input_state(element,column),8)
               if(extracted_binary(1) == 0)
                   extracted_binary = [extracted_binary(2:8) 0 ] ^ Pre_fixed_reduction;     
               else 
                   extracted_binary = [extracted_binary(2:8) 0 ];
               end 
               result = extracted_binary;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
            elseif pre_defined_matrix(row,element) == 3
                    %%%%%%%%%%%%%%% multiply by 2 case then multiply by 1 then xor between them %%%%%% 
               extracted_binary = decimalToBinaryVector(input_state(element,column),8)
               if(extracted_binary(1) == 0)
                   extracted_binary = [extracted_binary(2:8) 0 ] ^ Pre_fixed_reduction;     
               else 
                   extracted_binary = [extracted_binary(2:8) 0 ];
               end 
               
               extracted_binary_2 = decimalToBinaryVector(input_state(element,column));
               result = extracted_binary ^ extracted_binary_2; %final result in case of 3
            end 
            
            %%%%%%%%%%%%%%%%%%% output result calculations %%%%%%%%%%%%  
            final_result = result ^ final_result;
            state(row,column) = final_result;
        end 
        column = column+1;
end 


end 