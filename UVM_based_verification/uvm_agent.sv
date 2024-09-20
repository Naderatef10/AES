class AES_agent extends uvm_agent;
AES_driver driver_instance;
AES_sequencer sequencer_instance;
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
endfunction
endclass // extends superClass