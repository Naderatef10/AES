class AES_monitor extends uvm_monitor;
`uvm_component_utils(AES_monitor)
    function new(string name = "AES_monitor",uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()

function void build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction
endclass // extends superClass