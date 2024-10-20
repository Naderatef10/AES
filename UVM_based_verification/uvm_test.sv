class AES_test extends uvm_test;
AES_env env_instance; 
virtual AES_interface local_interface;
AES_sequence sequence_instant;

`uvm_component_utils(AES_test)
    function new(string name = "AES_test",uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()

function void build_phase(uvm_phase phase);
super.build_phase(phase);
env_instance = AES_env::type_id::create("env_instance",this);
if(!uvm_config_db # (virtual AES_interface)::get (this,"","virtual_interface",local_interface))begin
    `uvm_fatal(get_full_name(),"!error");
end

uvm_config_db #(virtual AES_interface)::set(this,"env_instance","local_interface",local_interface);
sequence_instant = AES_sequence::type_id::create("sequence_instant");

endfunction

task run_phase(uvm_phase phase);

phase.raise_objection(this,"starting sequences");



sequence_instant.start(env_instance.agent_instance.sequencer_instance);



phase.drop_objection(this,"finishing sequences");


endtask


endclass // extends superClass