class AES_scoreboard extends uvm_scoreboard;
`uvm_component_utils(AES_scoreboard)
uvm_analysis_export #(AES_sequence_item) scoreboard_analysis_export;
uvm_tlm_analysis_fifo #(AES_sequence_item) scoreboard_fifo;

function new(string name = "AES_scoreboard",uvm_component parent = null);
        super.new(name,parent);
endfunction //new()

function void build_phase(uvm_phase phase);
super.build_phase(phase);

scoreboard_analysis_export = new("scoreboard_analysis_export",this);
scoreboard_fifo = new("scoreboard_fifo",this);

endfunction

function void connect_phase (uvm_phase phase);

super.connect_phase(phase);

scoreboard_analysis_export.connect(scoreboard_fifo.analysis_export);


endfunction 


endclass // extends superClass