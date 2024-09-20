class AES_driver  extends uvm_driver #(AES_sequence_item);
`uvm_component_utils(AES_driver)
    function new(string name = "AES_driver",uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()

function void build_phase(uvm_phase phase);
super.build_phase(phase);
factory.print();
endfunction
endclass // extends superClass
