class AES_test extends uvm_test;
AES_env env_instance; 
virtual AES_interface local_interface;
`uvm_component_utils(AES_test)
    function new(string name = "AES_test",uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()



function void build_phase(uvm_phase phase);
super.build_phase(phase);
env_instance = AES_env::type_id::create("env_instance",this);
if(!uvm_config_db # (virtual AES_interface) :: get (this,"","virtual_interface",local_interface))begin
    `uvm_fatel(get_full_name(),"!error")
end

uvm_config_db #(virtual AES_interface)::set (this,"AES_env","local_interface",local_interface);




endfunction
endclass // extends superClass