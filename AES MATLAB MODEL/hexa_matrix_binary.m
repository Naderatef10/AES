%function to transfor 4x4 hexadecimal matrix into 4x32 binary matrix
% input input_state matrix 4x4 hexadecimal matrix
% output 4x32 bits binary matrix
function state_binary = hexa_matrix_binary(input_state)
% input 4x4 hexa_decimal_matrix 
input_state = hex2dec(input_state); %transforming the hexadecimal matrix to decimal

state_binary = zeros(4,32);
j=1;
%loop on each row of bytes
for i = 1:4
    j=1;
    %looping on each byte in each word 
    for bytes = 1:4
        %%%%%% transforming each decimal byte to a binary vector and store it in the new matrix
        state_binary(i,j:j+8-1)=decimalToBinaryVector(input_state(i,bytes),8);
        j=j+8;
        %j counter indicates the start and end in the new state matrix to store the 32 bits of binary
    end   
end 

end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%