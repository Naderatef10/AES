%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Definitions of the script %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
input_block = rand(1,128)>.3; %generate input_block_for_AES.
key = rand(32,4)>.2; %initial value of key before expansion
Nr = 10; 
Nb = size(input_block,2)/32; %%%%% number of words %%%%%
state = zeros(32,Nb);
%%%%%%%%%%%%%%%%% Transforming 128 bits into 4 words each of 32 bits matrix %%%%%%%%%
j=0;
for i = 1:4 
    state(:,i)=input_block(1+j:32+j);
    j=j+32;
end 

%%%%%%%%%%%%%%%%%%% intial round %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
state = add_round_key(state,key);

%%%%%%%%%%%%%%%%%%%%%%% Main rounds %%%%%%%%%%%%%%%%%%%%%%

for i = 1:Nr-1
    sub_byte(state);
    shift_rows(state);
    mix_columns(state);
    add_round_key(state,key);
end 

%%%%%%%%%%%%%%%%%%%%%% Final round


