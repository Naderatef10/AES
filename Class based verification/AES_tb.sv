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
`include "transaction.sv"
`include "driver.sv"
`include "monitor.sv"
`include "sequencer.sv"
`include "env.sv"
`include "interface.sv"

module AES_tb ();

  int file_handle;
  int file_handle_keys;
  int file_handle_golden_model;
  logic [127:0] golden_output;

logic clk_tb;
logic rst_tb;
always #5 clk_tb = ~clk_tb;
assign intf1.clk = clk_tb;
assign intf1.rst = rst_tb;
AES_interface intf1 ();
env top_level_env;

AES DUT (
.plain_text(intf1.plain_text), 
.key(intf1.key),
.input_valid(intf1.input_valid),  
.clk(intf1.clk),
.rst(intf1.rst),
.cipher_text(intf1.cipher_text),
.output_valid(intf1.output_valid)

);
integer i;
initial begin
    i =0;
    file_handle = 0;
    file_handle_keys = 0;
    file_handle_golden_model = 0;
    clk_tb = 0;
    rst_tb = 0;
    #40; 
    rst_tb = 1;
    top_level_env = new();
    top_level_env.env_configure(intf1);
    file_handle = $fopen("test_cases.txt","w");
    file_handle_keys = $fopen("test_cases_keys.txt","w");
    file_handle_golden_model = $fopen("golden_model_output.txt","r");
    for(i=0;i<100;i=i+1)begin
        top_level_env.configure_sequence(1);
        $fdisplay(file_handle,"%X",intf1.plain_text);
        $fdisplay(file_handle_keys,"%X",intf1.key);
        $fscanf(file_handle_golden_model,"%x\n",golden_output);
        #11; // delay 1 cycle then deassert input_valid using sequence number 0
        top_level_env.configure_sequence(0);
        wait(intf1.output_valid == 1'b1);
        if(golden_output==intf1.cipher_text)begin
          $display("test_case_sucessful number: %d\n",i);
        end
        else begin
          $display("test_case_failed \n");
          $display("%X",golden_output);
          $display("%X",intf1.cipher_text);
          $stop();
        end
        #11; // wait one cycle for output valid to be deasserted
    end
    $display("end of test bench");
    $finish();

end



endmodule