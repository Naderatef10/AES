class AES_subscriber extends uvm_subscriber #(AES_sequence_item);
`uvm_component_utils(AES_subscriber)
// uvm_analysis_imp is already implemented in uvm_subscriber;
AES_sequence_item subscriber_sequence_item;
    function new(string name = "AES_subscriber",uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()

function void build_phase(uvm_phase phase);
super.build_phase(phase);
subscriber_sequence_item = AES_sequence_item::type_id::create("subscriber_sequence_item");
endfunction

function void write (AES_sequence_item t); 




endfunction 

endclass // extends superClass