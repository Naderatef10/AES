class AES_test extends uvm_test;
AES_env env_instance; 
`uvm_component_utils(AES_test)
    function new(string name = "AES_test",uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()

function void build_phase(uvm_phase phase);
super.build_phase(phase);
env_instance = AES_env::type_id::create("env_instance",this);
endfunction
endclass // extends superClass