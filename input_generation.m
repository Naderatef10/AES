function input_generation 
clc;
clear all;
input_block = rand(1,128)>.3; %generate input_block_for_AES.
key = rand(4,32)>.2; %initial value of key before expansion
Nr = 10; 
Nb = size(input_block,2)/32; %%%%% number of words %%%%%
state = zeros(32,Nb);

end 