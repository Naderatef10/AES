module controller (
    input wire clk,
    input wire rst,
    input wire input_valid,
    input wire [3:0] round_counter,

    output reg soft_rst,
    output reg enable_mix_columns,
    output reg initial_round_flag,
    output reg valid_output,
    output reg enable_add_round_key,
    output reg enable_key_expansion,
    output reg enable_shift_rows,
    output reg enable_sub_bytes,
    output reg bypass,
    output reg enable_counter
);

reg [2:0] current_state, next_state;
reg valid_output_comb;
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
            if(input_valid == 1)begin
                next_state = INITIAL_ROUND;
            end
            else begin
                next_state = IDLE;
            end
        end 
        INITIAL_ROUND:begin 
            next_state = KEY_EXPANSION;
        end 
        KEY_EXPANSION:begin 
            next_state = SUB_BYTES;
        end 
        SUB_BYTES:begin
            next_state = SHIFT_ROWS; 
        end
        SHIFT_ROWS:begin
            next_state = MIX_COLUMNS;
        end
        MIX_COLUMNS:begin
            next_state = ADD_ROUND_KEY;
        end 
        ADD_ROUND_KEY:begin
            if(round_counter == 10)begin
                next_state = IDLE;
            end
            else begin
                next_state = KEY_EXPANSION;
            end
        end 
        default: next_state = IDLE;
        
    endcase

end

/*output_logic of the FSM*/

always @(*) begin
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
        soft_rst = 1;
        bypass = 1;
        initial_round_flag=1;
    end 
    INITIAL_ROUND:begin 
        initial_round_flag = 1;
        bypass = 1;
        enable_add_round_key = 1;
        enable_counter = 1;
    end 
    KEY_EXPANSION:begin 
        enable_key_expansion = 1;
    end 
    SUB_BYTES:begin
         enable_sub_bytes = 1;
    end
    SHIFT_ROWS:begin
        enable_shift_rows = 1;
    end
    MIX_COLUMNS:begin
       if(round_counter == 10)begin
            enable_mix_columns = 0;
            bypass = 1;
       end else begin
            enable_mix_columns = 1;
            bypass = 0;
       end
    end 
    ADD_ROUND_KEY:begin
        if(round_counter == 10)begin
            valid_output_comb = 1;
            enable_add_round_key = 1;
            enable_counter = 1;
       end else begin
            valid_output_comb = 0;
            enable_add_round_key = 1;
            enable_counter = 1;
       end

    end 
 
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

always @(posedge clk , negedge rst) begin
    
    if(!rst)begin
        valid_output <= 0;
    end
    else begin
        valid_output <= valid_output_comb;
    end

end
    
endmodule