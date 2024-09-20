class AES_subscriber extends uvm_subscriber #(AES_sequence_item);
`uvm_component_utils(AES_subscriber)
    function new(string name = "AES_subscriber",uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()

function void build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction

function void write (AES_sequence_item t); 



endfunction 

endclass // extends superClass