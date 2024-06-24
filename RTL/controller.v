/*module controller implements the FSM used to control the operations of the AES modules
it generates all the control signals of the design
it is implemented as a 3 stage FSM (input logic), (sequential logic), (output logic)
*/
module controller (
    input wire clk,
    input wire rst,
    input wire input_valid, /*input to the top level module to indicate valid plain text*/
    input wire [3:0] round_counter, /*input from counter module which indicates the current round number*/

    output reg soft_rst, /*soft reset signal to reset the counter in the idle state to allow multiple encyrption process consecutively */
    output reg enable_mix_columns, /*enable mix_columns module*/
    output reg initial_round_flag, /*indicates initial round and it is used as a mux select in the top level of AES*/
    output reg valid_output,/*indicates the completion of the encryption process*/
    output reg enable_add_round_key,/*enables add_round_key module*/
    output reg enable_key_expansion,/*enables key_expansion*/
    output reg enable_shift_rows,/*enables shift_rows*/
    output reg enable_sub_bytes,/*enables sub_bytes*/
    output reg bypass,/*turns any module into buffer as some steps of the algorithms are not needed in the initial round and final round*/
    output reg enable_counter /*enables the round counter after each round is completed according to the FSM*/
);

reg [2:0] current_state, next_state;
reg valid_output_comb;
/*states of the FSM*/
localparam IDLE = 3'b000 ;      
localparam INITIAL_ROUND = 3'b001 ; 
localparam KEY_EXPANSION = 3'b010 ; 
localparam SUB_BYTES = 3'b011 ; 
localparam SHIFT_ROWS = 3'b100 ; 
localparam MIX_COLUMNS = 3'b101 ; 
localparam ADD_ROUND_KEY = 3'b110 ; 

/*Sequential logic of FSM*/

always @(posedge clk , negedge rst) begin
    
    if(!rst)begin
        current_state <= IDLE;
    end

    else begin
        current_state <= next_state;
    end

end

/*next state combinational logic*/

always @(*) begin

    case (current_state)
        IDLE:begin 
            /*next state is the initial round if input_valid is received in the top module and is asserted*/
            if(input_valid == 1)begin
                next_state = INITIAL_ROUND;
            end
            else begin
                next_state = IDLE;
            end
        end 
        /*after the initial_round perform key expansion at the beginning of each round*/
        INITIAL_ROUND:begin 
            next_state = KEY_EXPANSION;
        end 
        /*after key expansion perform sub bytes*/
        KEY_EXPANSION:begin 
            next_state = SUB_BYTES;
        end 
        /*after sub bytes perform shift_rows*/
        SUB_BYTES:begin
            next_state = SHIFT_ROWS; 
        end
        /*after shift_rows perform mix_columns*/
        SHIFT_ROWS:begin
            next_state = MIX_COLUMNS;
        end
        /*after mix_columns perform add_round_Key*/
        MIX_COLUMNS:begin
            next_state = ADD_ROUND_KEY;
        end 
        /*if counter is equal 10 which is the final round move to the IDLE state*/
        ADD_ROUND_KEY:begin
            if(round_counter == 10)begin
                next_state = IDLE;
            end
            /*if counter is less than 10 (still in the main rounds and didnt perform final round reperform the encryption process*/
            else begin
                next_state = KEY_EXPANSION;
            end
        end 
        default: next_state = IDLE;
        
    endcase

end

/*output_logic of the FSM*/

always @(*) begin
    /*avoiding unintentional latches*/
soft_rst = 0; 
enable_mix_columns = 0; 
initial_round_flag = 0; 
valid_output_comb = 0; 
enable_add_round_key = 0; 
enable_key_expansion = 0; 
enable_shift_rows = 0; 
enable_sub_bytes = 0; 
bypass = 0; 
enable_counter = 0; 
    case (current_state)
    IDLE:begin 
        soft_rst = 1; /*soft_rst asserted to enable consecutive blocks*/
        bypass = 1; /*bypass the inputs through the design*/
        initial_round_flag=1; /*make the muxs choose the inputs of the AES instead of the internally generated keys and bytes*/
    end 
    INITIAL_ROUND:begin 
        initial_round_flag = 1;
        bypass = 1;
        /*enable only the add_round_key as it is the only needed module in the AES*/
        enable_add_round_key = 1;
        enable_counter = 1;
    end 
    /*enable key expansion module*/
    KEY_EXPANSION:begin 
        enable_key_expansion = 1;
    end 
    /*enable sub bytes only*/
    SUB_BYTES:begin
         enable_sub_bytes = 1;
    end
    /*enable shift rows only*/
    SHIFT_ROWS:begin
        enable_shift_rows = 1;
    end
    MIX_COLUMNS:begin
        /*if it is the last round mix_columns is disabled*/
       if(round_counter == 10)begin
            enable_mix_columns = 0;
            bypass = 1;
            /*enable_mix_columns if it is any other round*/
       end else begin
            enable_mix_columns = 1;
            bypass = 0;
       end
    end 
    ADD_ROUND_KEY:begin
        /*if it is the last round generate the output valid the next clock cycle and perform only the add_round_key operation*/
        if(round_counter == 10)begin
            valid_output_comb = 1;
            enable_add_round_key = 1;
            enable_counter = 1;
       end else begin
        /*if it is not the last round deassert the valid_output*/
            valid_output_comb = 0;
            enable_add_round_key = 1;
            enable_counter = 1;
       end

    end 
    /*default case to avoid un intentional latches*/
    default: begin
        soft_rst = 0; 
        enable_mix_columns = 0; 
        initial_round_flag = 0; 
        valid_output_comb = 0; 
        enable_add_round_key = 0; 
        enable_key_expansion = 0; 
        enable_shift_rows = 0; 
        enable_sub_bytes = 0; 
        bypass = 0; 
        enable_counter = 0; 
    end
    
endcase

end
/*registering valid_output signal*/
always @(posedge clk , negedge rst) begin
    
    if(!rst)begin
        valid_output <= 0;
    end
    else begin
        valid_output <= valid_output_comb;
    end

end
    
endmodule