%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Definitions of the script %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function output_cipher = AES() 
clc;
clear all;
input_block = rand(1,128)>.3; %generate input_block_for_AES.
key = rand(4,32)>.2; %initial value of key before expansion
Nr = 10; 
Nb = size(input_block,2)/32; %%%%% number of words %%%%%
state = zeros(32,Nb);
%%%%%%%%%%%%%%%%% Transforming 128 bits into 4 words each of 32 bits matrix %%%%%%%%%
j=0;
for i = 1:4 
    state(:,i)=input_block(1+j:32+j);
    j=j+32;
end 

hexa = binary_matrix_hexa(state');
hexa = hexa';
state = hexa_matrix_binary(hexa);
%%%%%%%%%%%%%%%%%%% intial round %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
    state = sub_byte(state);
    state =shift_rows(state);
    key=key_expansion(key,i+1);
    state = add_round_key(state,key);

output_cipher = binary_matrix_hexa(state);

 end 
