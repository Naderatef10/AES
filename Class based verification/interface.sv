interface AES_interface #(type T = logic);
    
T [127:0] plain_text;
T [127:0] key;
T input_valid;
T clk;
T rst;
T [127:0] cipher_text;
T output_valid;


endinterface //interfacename