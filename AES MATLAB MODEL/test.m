%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% initilization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
fileID = fopen('test_cases.txt','r'); % creating file handle for plain text test cases from system verilog random stimulis
fileID_2 = fopen('test_cases_keys.txt','r');  % creating file handle for keys text test cases from system verilog random stimulis'
fileID_3 = fopen('golden_model_output.txt','w'); % creating file handle for the text file that will contain the golden model outputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Generating randomized input_key, input_cipher %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %[input_cipher , input_key] = input_generation(); %% random generation line
% input_cipher = binary_matrix_hexa(input_cipher); remove comment here if you are using random data
% input_key =  binary_matrix_hexa(input_key); %remove comment here if you are using random data from matlab

%%%%%%%%%%%%%%% reading plain text test cases that was generated from system verilog %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
test_cases_SV = textscan(fileID, '%s', 100, 'Delimiter', '\n');
test_cases_SV = test_cases_SV{1};
%%%%%%%%%%%%%%%%%%%% reading keys test cases that was generated from system verilog %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
test_cases_keys = textscan(fileID_2, '%s', 100, 'Delimiter', '\n');
test_cases_keys = test_cases_keys{1};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Applying AES_Algorithm %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:100
  input_cipher = hexMatrix(test_cases_SV(i)); 
  input_key = hexMatrix(test_cases_keys(i));
  output_cipher = AES(input_cipher,input_key);
  output_cipher = Matrix_to_hex_string(output_cipher);
  fprintf(fileID_3, '%s\n',output_cipher) ;
 
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%