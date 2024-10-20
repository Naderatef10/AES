class AES_env extends uvm_env;
 `uvm_component_utils(AES_env)
 AES_agent agent_instance;
 AES_scoreboard scoreboard_instance;
 virtual AES_interface local_interface;
 AES_subscriber subscriber_instance;
    function new(string name = "AES_env",uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()

function void build_phase(uvm_phase phase);
super.build_phase(phase);
agent_instance = AES_agent::type_id::create("agent_instance",this);
scoreboard_instance = AES_scoreboard::type_id::create("scoreboard_instance",this);
subscriber_instance = AES_subscriber::type_id::create("subscriber_instance",this);
if(!uvm_config_db # (virtual AES_interface)::get (this,"","local_interface",local_interface))begin
    `uvm_fatal(get_full_name(),"!error");
end

uvm_config_db #(virtual AES_interface)::set (this,"agent_instance","local_interface",local_interface);


endfunction

function  void connect_phase (uvm_phase phase);

super.connect_phase(phase);
agent_instance.agent_analysis_port.connect(subscriber_instance.analysis_export);
agent_instance.agent_analysis_port.connect(scoreboard_instance.scoreboard_analysis_export);
endfunction



endclass // extends superClass