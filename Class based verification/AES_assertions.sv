module AES_assertions (
    input logic output_valid,
    input logic clk,
    input logic input_valid,
    input logic [3:0] round_counter,
    input logic enable_add_round_key,
    input logic enable_key_expansion,
    input logic enable_shift_rows,
    input logic enable_sub_bytes,
    input logic rst,
    input logic [2:0] current_state

);
localparam IDLE = 3'b000 ;      
localparam INITIAL_ROUND = 3'b001 ; 
localparam KEY_EXPANSION = 3'b010 ; 
localparam SUB_BYTES = 3'b011 ; 
localparam SHIFT_ROWS = 3'b100 ; 
localparam MIX_COLUMNS = 3'b101 ; 
localparam ADD_ROUND_KEY = 3'b110 ; 

sequence  sequence_fsm_transitions_IDLE;

(current_state==INITIAL_ROUND) ##1 (current_state == KEY_EXPANSION) ##1 (current_state == SUB_BYTES) ##1 (current_state == SHIFT_ROWS) ##1 (current_state==MIX_COLUMNS) ##1 (current_state== ADD_ROUND_KEY) && (round_counter == 10) ##1 (current_state== IDLE); 

endsequence 

sequence  sequence_fsm_transitions_KEY_EXPANSION;

(current_state == KEY_EXPANSION) ##1 (current_state == SUB_BYTES) ##1 (current_state == SHIFT_ROWS) ##1 (current_state==MIX_COLUMNS);

endsequence 

property FSM_transitions;

@(posedge clk) disable iff (!rst) sequence_fsm_transitions_KEY_EXPANSION; 

endproperty 

property AES_output_valid;

@(posedge clk) disable iff (!rst) (output_valid == 1 && current_state == IDLE);

endproperty

FSM_assertion : assert property (FSM_transitions); 

OUTPUT_VALID_Assertion: assert property (AES_output_valid);
    
endmodule