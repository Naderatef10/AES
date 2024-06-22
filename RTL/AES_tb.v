module AES_tb ();
reg [127:0] plain_text_tb;
reg [127:0] key_tb;
reg input_valid_tb;
reg clk_tb;
reg rst_tb;
wire [127:0] cipher_text_tb;
wire output_valid_tb;

always #5 clk_tb = ~clk_tb;

AES DUT(
.plain_text(plain_text_tb),
.key(key_tb),
.input_valid(input_valid_tb),
.clk(clk_tb),
.rst(rst_tb),
.cipher_text(cipher_text_tb),
.output_valid(output_valid_tb)

);


initial begin
    clk_tb = 0;
    rst_tb = 0;
    #40;
    rst_tb = 1;
    plain_text_tb = 'h3243f6a8885a308d313198a2e0370734;
    key_tb = 'h2b7e151628aed2a6abf7158809cf4f3c;
    #10;
    input_valid_tb = 1'b1;

    if(AES_tb.DUT.round_counter_top == 4'd10 && (AES_tb.DUT.Top_controller.current_state== 3'b101))begin
        $stop; 
    end

end
    
endmodule