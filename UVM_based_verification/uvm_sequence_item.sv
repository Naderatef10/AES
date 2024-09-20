class AES_sequence_item extends uvm_sequence_item;
    `uvm_object_utils(AES_sequence_item)
    function new(string name = "AES_sequence_item");
        super.new(name);
    endfunction //new()
    logic [127:0] plain_text;
    logic [127:0] key;
    logic input_valid;
    logic rst;
    logic [127:0] cipher_text;
    logic output_valid;
endclass // extends superClass