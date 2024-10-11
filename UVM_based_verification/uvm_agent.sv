class AES_agent extends uvm_agent;
AES_driver driver_instance;
AES_sequencer sequencer_instance;
 virtual AES_interface local_interface;
AES_monitor monitor_instance;
`uvm_component_utils(AES_agent)
    function new(string name = "AES_agent",uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()

function void build_phase(uvm_phase phase);
super.build_phase(phase);
driver_instance = AES_driver::type_id::create("driver_instance",this);
sequencer_instance = AES_sequencer::type_id::create("sequencer_instance",this);
monitor_instance = AES_monitor::type_id::create("monitor_instance",this);
if(!uvm_config_db # (virtual AES_interface)::get (this,"","local_interface",local_interface))begin
    `uvm_fatel(get_full_name(),"!error")
end

uvm_config_db #(virtual AES_interface)::set (this,"AES_driver","local_interface",local_interface);
uvm_config_db #(virtual AES_interface)::set (this,"AES_monitor","local_interface",local_interface);
endfunction
endclass // extends superClass