interface AES_interface #(type T = logic) (input bit clk);
    
T [127:0] plain_text;
T [127:0] key;
T input_valid;
T rst;
T [127:0] cipher_text;
T output_valid;


endinterface //interfacename