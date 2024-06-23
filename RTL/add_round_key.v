/*module add_round_key used to implement add_round_key step in the AES algorithm*/
module add_round_key (

    input wire clk,
    input wire rst, 
    input wire enable_add_round_Key, /*used to enable the block, generated from the top level controller*/

/*input 16 bytes from state matrix (text bytes)*/
    input wire [7:0] B0,
    input wire [7:0] B1,
    input wire [7:0] B2,
    input wire [7:0] B3,
    input wire [7:0] B4,
    input wire [7:0] B5,
    input wire [7:0] B6,
    input wire [7:0] B7,
    input wire [7:0] B8,
    input wire [7:0] B9,
    input wire [7:0] B10,
    input wire [7:0] B11,
    input wire [7:0] B12,
    input wire [7:0] B13,
    input wire [7:0] B14,
    input wire [7:0] B15,
/*input 16 bytes keys*/
    input wire [7:0] K0,
    input wire [7:0] K1,
    input wire [7:0] K2,
    input wire [7:0] K3,
    input wire [7:0] K4,
    input wire [7:0] K5,
    input wire [7:0] K6,
    input wire [7:0] K7,
    input wire [7:0] K8,
    input wire [7:0] K9,
    input wire [7:0] K10,
    input wire [7:0] K11,
    input wire [7:0] K12,
    input wire [7:0] K13,
    input wire [7:0] K14,
    input wire [7:0] K15,

    output reg [7:0] B0_new,
    output reg [7:0] B1_new,
    output reg [7:0] B2_new,
    output reg [7:0] B3_new,
    output reg [7:0] B4_new,
    output reg [7:0] B5_new,
    output reg [7:0] B6_new,
    output reg [7:0] B7_new,
    output reg [7:0] B8_new,
    output reg [7:0] B9_new,
    output reg [7:0] B10_new,
    output reg [7:0] B11_new,
    output reg [7:0] B12_new,
    output reg [7:0] B13_new,
    output reg [7:0] B14_new,
    output reg [7:0] B15_new
    
);

    always @(posedge clk ,negedge rst) begin
        if(!rst)begin

            B0_new <= 0;
            B1_new <= 0;
            B2_new <= 0;
            B3_new <= 0;
            B4_new <= 0;
            B5_new <= 0;
            B6_new <= 0;
            B7_new <= 0;
            B8_new <= 0;
            B9_new <= 0;
            B10_new <= 0;
            B11_new <= 0;
            B12_new <= 0;
            B13_new <= 0;
            B14_new <= 0;
            B15_new <= 0;
            
        end
        /*if enabled perfrom simple xor operations*/
        else if (enable_add_round_Key)begin
            
            B0_new <= B0 ^ K0;
            B1_new <= B1 ^ K1;
            B2_new <= B2 ^ K2;
            B3_new <= B3 ^ K3;
            B4_new <= B4 ^ K4;
            B5_new <= B5 ^ K5;
            B6_new <= B6 ^ K6;
            B7_new <= B7 ^ K7;
            B8_new <= B8 ^ K8;
            B9_new <= B9 ^ K9;
            B10_new <= B10 ^ K10;
            B11_new <= B11 ^ K11;
            B12_new <= B12 ^ K12;
            B13_new <= B13 ^ K13;
            B14_new <= B14 ^ K14;
            B15_new <= B15 ^ K15;
   
        end
    end



    
endmodule