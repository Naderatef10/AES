class AES_agent extends uvm_agent;
AES_driver driver_instance;
AES_sequencer sequencer_instance;
virtual AES_interface local_interface;
AES_monitor monitor_instance;
uvm_analysis_port #(AES_sequence_item) agent_analysis_port;
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
    `uvm_fatal(get_full_name(),"!error");
end
agent_analysis_port = new ("agent_analysis_port",this);
uvm_config_db #(virtual AES_interface)::set (this,"driver_instance","local_interface",local_interface);
uvm_config_db #(virtual AES_interface)::set (this,"monitor_instance","local_interface",local_interface);
endfunction



function  void connect_phase (uvm_phase phase);

super.connect_phase(phase);
monitor_instance.monitor_analysis_port.connect(agent_analysis_port);
driver_instance.seq_item_port.connect(sequencer_instance.seq_item_export);
    
endfunction



endclass // extends superClass

