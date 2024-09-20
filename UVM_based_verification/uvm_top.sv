`include "uvm_macros.svh"
import uvm_pkg::*;

`include "../RTL/add_round_key.v"
`include "../RTL/mux_2x1.v"
`include "../RTL/sbox.v"
`include "../RTL/controller.v"
`include "../RTL/counter.v"
`include "../RTL/divide_bytes.v"
`include "../RTL/key_expansion.v"
`include "../RTL/merge_bytes.v"
`include "../RTL/mix_columns.v"
`include "../RTL/shift_rows.v"
`include "../RTL/sub_byte.v"
`include "../RTL/AES.v"

`include "uvm_sequence_item.sv"
`include "uvm_sequencer.sv"
`include "uvm_monitor.sv"
`include "uvm_driver.sv"
`include "uvm_agent.sv"
`include "uvm_scoreboard.sv"
`include "uvm_subscriber.sv"
`include "uvm_env.sv"
`include "uvm_test.sv"
`include "interface.sv"

module uvm_top();

logic clk_generator;

AES_interface AES_interface_instant (clk_generator);  
virtual AES_interface virtual_interface;

always #5 clk_generator = ~clk_generator;

initial begin
    clk_generator = 0;
end

initial begin

uvm_config_db #(virtual AES_interface)::set (null,"uvm_test_top","virtual_interface",AES_interface_instant);
run_test("AES_test");


end


endmodule 