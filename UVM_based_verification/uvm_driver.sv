class AES_driver  extends uvm_driver #(AES_sequence_item);
`uvm_component_utils(AES_driver)
virtual AES_interface local_interface;
AES_sequence_item seq_item_instant;
    function new(string name = "AES_driver",uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()
    
function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db # (virtual AES_interface)::get (this,"","local_interface",local_interface))begin
    `uvm_fatal(get_full_name(),"!error");
end
seq_item_instant = AES_sequence_item::type_id::create("seq_item_instant");
factory.print();
endfunction

function void connect_phase (uvm_phase phase);

super.connect_phase(phase);

endfunction

task run_phase(uvm_phase phase);

forever begin
    

seq_item_port.get_next_item(seq_item_instant);

    @(posedge local_interface.clk)begin    

    local_interface.rst = seq_item_instant.rst;
    local_interface.input_valid = seq_item_instant.input_valid;
    local_interface.plain_text = seq_item_instant.plain_text;
    
    end 

    @(posedge local_interface.clk)begin
    local_interface.input_valid = 0;
    end
#1 seq_item_port.item_done();

end

endtask



endclass // extends superClass
