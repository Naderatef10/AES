function state_binary = hexa_matrix_binary(input_state)
% input 4x4 hexa_decimal_matrix 
input_state = hex2dec(input_state);
state_binary = zeros(4,32);
j=1;
for i = 1:4
    j=1;
    for bytes = 1:4
        state_binary(i,j:j+8-1)=decimalToBinaryVector(input_state(i,bytes),8);
        j=j+8;
        
    end   
end 

end 