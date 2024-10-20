class AES_monitor extends uvm_monitor;

`uvm_component_utils(AES_monitor)
uvm_analysis_port #(AES_sequence_item) monitor_analysis_port;
virtual AES_interface monitor_interface;
AES_sequence_item item_1;

    function new(string name = "AES_monitor",uvm_component parent = null);
        super.new(name,parent);
    endfunction 

function void build_phase(uvm_phase phase);
super.build_phase(phase);
monitor_analysis_port = new("monitor_analysis_port",this);
if(!uvm_config_db # (virtual AES_interface)::get (this,"","local_interface",monitor_interface))begin
    `uvm_fatal(get_full_name(),"!error");
end
item_1 = AES_sequence_item::type_id::create("item_1"); 

endfunction

task run_phase(uvm_phase phase);
    
    super.run_phase(phase);

    forever begin
        
        @(posedge monitor_interface.output_valid)begin
            
            #1 
                item_1.cipher_text = monitor_interface.cipher_text;
                item_1.output_valid = monitor_interface.output_valid;
                item_1.rst = monitor_interface.rst;
                item_1.input_valid = monitor_interface.rst;                 
                monitor_analysis_port.write(item_1);

        end



    end

endtask //


endclass // extends superClass