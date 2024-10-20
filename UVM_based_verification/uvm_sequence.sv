class AES_sequence extends uvm_sequence;
    `uvm_object_utils(AES_sequence);
    AES_sequence_item seq_item_instant;
task pre_body();

seq_item_instant = AES_sequence_item::type_id::create("seq_item_instant");

endtask

function new(string name = "AES_sequence");
        
    super.new(name);

    endfunction //new()

task body ();


 start_item(seq_item_instant);

seq_item_instant.rst = 0;
seq_item_instant.input_valid = 0;


finish_item(seq_item_instant);


#20; // 5 cycles;

start_item(seq_item_instant);

seq_item_instant.rst = 1;
seq_item_instant.input_valid = 0;


finish_item(seq_item_instant);



for(int i = 0 ; i < 200 ; i++)begin

start_item(seq_item_instant);

seq_item_instant.input_valid = 1;
void'(seq_item_instant.randomize());

finish_item(seq_item_instant); 

start_item(seq_item_instant);

seq_item_instant.input_valid = 0;


finish_item(seq_item_instant); 



end






endtask 

endclass //AES_sequence extends uvm_sequence