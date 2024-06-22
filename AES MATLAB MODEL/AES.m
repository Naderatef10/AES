%%%%%%%%%%%%%%%%% AES function 
%%%%%%%%%%%% inputs : 1)state matrix 4x32 bits
%                     2)key matrix 4x32 bits
%
% outputs -> output_cipher 4x4 hexadecimal matrix
% The AES function responsbile for 
function output_cipher = AES(state,key) 

Nr = 10; %%%%%%%%%% number of rounds required in AES-128 %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% intial round %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% in initial round sub_byte,shift_rows,mix_columns are excluded and add_round_key is performed on the initial key, no need for expansion
state = add_round_key(state,key);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Main rounds %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 for i = 1:Nr-1
    state = sub_byte(state);
    state = shift_rows(state);
    state = mix_columns(state);
    key = key_expansion(key,i);
    state =add_round_key(state,key); 
 end 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Final round %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %in final round no mix column operation is required.
    state = sub_byte(state);
    state =shift_rows(state);
    key=key_expansion(key,i+1);
    state = add_round_key(state,key);
%transforming the binary output to hexa decimal format for better debugging and visualization 
output_cipher = binary_matrix_hexa(state);

 end 
