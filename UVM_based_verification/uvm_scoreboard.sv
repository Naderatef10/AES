class AES_scoreboard extends uvm_scoreboard;
`uvm_component_utils(AES_scoreboard)
    function new(string name = "AES_scoreboard",uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()
function void build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction
endclass // extends superClass