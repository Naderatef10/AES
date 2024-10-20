class AES_subscriber extends uvm_subscriber #(AES_sequence_item);
`uvm_component_utils(AES_subscriber)
// uvm_analysis_imp is already implemented in uvm_subscriber;
AES_sequence_item subscriber_sequence_item;


covergroup  cover_1();

input_valid_cover:coverpoint subscriber_sequence_item.input_valid { bins bin1[]= {0,1};}
output_valid_cover: coverpoint  subscriber_sequence_item.output_valid {bins bin2[]= {0,1};}
rst_cover:coverpoint subscriber_sequence_item.rst {bins bin3[]= {0,1};
bins bins4 = (0 => 1);
bins bins5 = (1 => 0);

}
endgroup 

function new(string name = "AES_subscriber",uvm_component parent = null);
super.new(name,parent);
cover_1 = new();
endfunction //new()


function void build_phase(uvm_phase phase);
super.build_phase(phase);
subscriber_sequence_item = AES_sequence_item::type_id::create("subscriber_sequence_item");
endfunction

function void write (AES_sequence_item t);  // interface implementation of write function for analysis port (subscriber implementation)

subscriber_sequence_item = t;
cover_1.sample();


endfunction 

endclass // extends superClass