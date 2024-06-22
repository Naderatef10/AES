%inputs -> None
%outputs -> input_cipher, initial input_key (matrices) 4x32 bits
%This function is used to generate the inputs of the AES algorithm ( the input cipher key, the input cipher text) these inputs are randomized by the function 
% and then passed to the AES function
function [input_cipher , input_key] = input_generation()   

input_cipher = rand(1,128)>.3; % Generate 128 bits input_cipher text (binary) 
input_key = rand(4,32)>.2; % Generate input key matrix 4 words each 32 bits.
Nr = 10; % Number of rounds for AES-128 (key of 128 bits) Number of rounds is function in the length of AES
Nb = size(input_cipher,2)/32; % Number of words in input block 128bits divided by (word length :32)-> which is standardized in AES
state = zeros(32,Nb);%initialize the state matrix as 32x4 bits words each column is a word
j=0;
for i = 1:4 
    state(:,i)=input_cipher(1+j:32+j); %fill each column with 32 bits of words
    j=j+32;
end 
hexa = binary_matrix_hexa(state'); %transform the binary state matrix (transposed) because binary_matrix_hexa takes 4x32 bits matrix to hexa decimal for visability 
hexa = hexa'; %transpose the hexadecimal matrix because the input_cipher was filled per column not per row to be matching the fips standard
state = hexa_matrix_binary(hexa); %transform the state matrix to binary again for proper operation of the AES function 
input_cipher = state; 
end 