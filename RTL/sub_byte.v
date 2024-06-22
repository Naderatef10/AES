module sub_byte (

input wire clk,rst,
input wire bypass,
input wire enable_sub_byte,
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

wire [7:0] s_box_b0;
wire [7:0] s_box_b1;
wire [7:0] s_box_b2;
wire [7:0] s_box_b3;
wire [7:0] s_box_b4;
wire [7:0] s_box_b5;
wire [7:0] s_box_b6;
wire [7:0] s_box_b7;
wire [7:0] s_box_b8;
wire [7:0] s_box_b9;
wire [7:0] s_box_b10;
wire [7:0] s_box_b11;
wire [7:0] s_box_b12;
wire [7:0] s_box_b13;
wire [7:0] s_box_b14;
wire [7:0] s_box_b15;


sbox byte_0 (B0,s_box_b0);
sbox byte_1 (B1,s_box_b1);
sbox byte_2 (B2,s_box_b2);
sbox byte_3 (B3,s_box_b3);
sbox byte_4 (B4,s_box_b4);
sbox byte_5 (B5,s_box_b5);
sbox byte_6 (B6,s_box_b6);
sbox byte_7 (B7,s_box_b7);
sbox byte_8 (B8,s_box_b8);
sbox byte_9 (B9,s_box_b9);
sbox byte_10 (B10,s_box_b10);
sbox byte_11 (B11,s_box_b11);
sbox byte_12 (B12,s_box_b12);
sbox byte_13 (B13,s_box_b13);
sbox byte_14 (B14,s_box_b14);
sbox byte_15 (B15,s_box_b15);


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
        else if (enable_sub_byte)begin
            
            B0_new <= s_box_b0;
            B1_new <= s_box_b1;
            B2_new <= s_box_b2;
            B3_new <= s_box_b3;
            B4_new <= s_box_b4;
            B5_new <= s_box_b5;
            B6_new <= s_box_b6;
            B7_new <= s_box_b7;
            B8_new <= s_box_b8;
            B9_new <= s_box_b9;
            B10_new <=s_box_b10;
            B11_new <=s_box_b11;
            B12_new <=s_box_b12;
            B13_new <=s_box_b13;
            B14_new <=s_box_b14;
            B15_new <=s_box_b15;
   
        end

        else if (bypass)begin
    
            B0_new <= B0; 
            B1_new <= B1; 
            B2_new <= B2; 
            B3_new <= B3; 
            B4_new <= B4; 
            B5_new <= B5; 
            B6_new <= B6; 
            B7_new <= B7; 
            B8_new <= B8; 
            B9_new <= B9; 
            B10_new <=B10;
            B11_new <=B11;
            B12_new <=B12;
            B13_new <=B13;
            B14_new <=B14;
            B15_new <=B15;
        end
    end
    
endmodule