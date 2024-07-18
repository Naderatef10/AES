class transaction;
   rand logic [127:0] plain_text;
   rand logic [127:0] key; 
   logic input_valid;
   logic [127:0] cipher_text;
   logic output_valid;
    function new();
        
    endfunction //new()
endclass //transaction