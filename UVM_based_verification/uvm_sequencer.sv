class AES_sequencer  extends uvm_sequencer #(AES_sequence_item);

`uvm_component_utils(AES_sequencer)

    function new(string name = "AES_sequencer",uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()


endclass // extends superClass