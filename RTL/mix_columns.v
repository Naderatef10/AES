module mix_columns (
input wire clk,
input wire rst, 
input wire enable_mix_columns,
input wire bypass,
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
    
wire [7:0] pre_fixed_reduction;

assign pre_fixed_reduction = 8'b00011011;

/*
pre_defined_matrix = [ 2   3   1   1;
                       1   2   3   1;
                       1   1   2   3;
                       3   1   1   2];

*/
/*
state matrix = [b0 b4 b8 b12 
                b1 b5 b9 b13
                b2 b6 b10 b14
                b3 b7 b11 b15
                ]

we need to multiply the pre_defined_matrix with the state matrix

*/
wire [7:0] B0_new_comb;
wire [7:0] B1_new_comb;
wire [7:0] B2_new_comb;
wire [7:0] B3_new_comb;
wire [7:0] B4_new_comb;
wire [7:0] B5_new_comb;
wire [7:0] B6_new_comb;
wire [7:0] B7_new_comb;
wire [7:0] B8_new_comb;
wire [7:0] B9_new_comb;
wire [7:0] B10_new_comb;
wire [7:0] B11_new_comb;
wire [7:0] B12_new_comb;
wire [7:0] B13_new_comb;
wire [7:0] B14_new_comb;
wire [7:0] B15_new_comb;

assign B0_new_comb = multiply_2(B0) ^ multiply_3(B1) ^ multiply_1(B2) ^ multiply_1(B3);
assign B1_new_comb = multiply_1(B0) ^ multiply_2(B1) ^ multiply_3(B2) ^ multiply_1(B3);
assign B2_new_comb = multiply_1(B0) ^ multiply_1(B1) ^ multiply_2(B2) ^ multiply_3(B3);
assign B3_new_comb = multiply_3(B0) ^ multiply_1(B1) ^ multiply_1(B2) ^ multiply_2(B3);


assign B4_new_comb = multiply_2(B4) ^ multiply_3(B5) ^ multiply_1(B6) ^ multiply_1(B7);
assign B5_new_comb = multiply_1(B4) ^ multiply_2(B5) ^ multiply_3(B6) ^ multiply_1(B7);
assign B6_new_comb = multiply_1(B4) ^ multiply_1(B5) ^ multiply_2(B6) ^ multiply_3(B7);
assign B7_new_comb = multiply_3(B4) ^ multiply_1(B5) ^ multiply_1(B6) ^ multiply_2(B7);


assign B8_new_comb = multiply_2(B8) ^ multiply_3(B9) ^ multiply_1(B10) ^ multiply_1(B11);
assign B9_new_comb = multiply_1(B8) ^ multiply_2(B9) ^ multiply_3(B10) ^ multiply_1(B11);
assign B10_new_comb = multiply_1(B8) ^ multiply_1(B9) ^ multiply_2(B10) ^ multiply_3(B11);
assign B11_new_comb = multiply_3(B8) ^ multiply_1(B9) ^ multiply_1(B10) ^ multiply_2(B11);


assign B12_new_comb = multiply_2(B12) ^ multiply_3(B13) ^ multiply_1(B14) ^ multiply_1(B15);
assign B13_new_comb = multiply_1(B12) ^ multiply_2(B13) ^ multiply_3(B14) ^ multiply_1(B15);
assign B14_new_comb = multiply_1(B12) ^ multiply_1(B13) ^ multiply_2(B14) ^ multiply_3(B15);
assign B15_new_comb = multiply_3(B12) ^ multiply_1(B13) ^ multiply_1(B14) ^ multiply_2(B15);


always @(posedge clk , negedge rst) begin
    
    if(!rst)begin
        B0_new <=0;
        B1_new <=0;
        B2_new <=0;
        B3_new <=0;
        B4_new <=0;
        B5_new <=0;
        B6_new <=0;
        B7_new <=0;
        B8_new <=0;
        B9_new <=0;
        B10_new <=0;
        B11_new <=0;
        B12_new <=0;
        B13_new <=0;
        B14_new <=0;
        B15_new <=0;
    end
    else if(enable_mix_columns)begin
        B0_new <= B0_new_comb;
        B1_new <= B1_new_comb;
        B2_new <= B2_new_comb;
        B3_new <= B3_new_comb;
        B4_new <= B4_new_comb;
        B5_new <= B5_new_comb;
        B6_new <= B6_new_comb;
        B7_new <= B7_new_comb;
        B8_new <= B8_new_comb;
        B9_new <= B9_new_comb;
        B10_new<= B10_new_comb;
        B11_new<= B11_new_comb;
        B12_new<= B12_new_comb;
        B13_new<= B13_new_comb;
        B14_new<= B14_new_comb;
        B15_new<= B15_new_comb;
    end

    else if(bypass)begin
        

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
        B10_new<= B10;
        B11_new<= B11;
        B12_new<= B12;
        B13_new<= B13;
        B14_new<= B14;
        B15_new<= B15;

    end

end


function [7:0] multiply_3 (input [7:0] byte);
     reg [7:0] result_multiply_2;
     begin
     
     multiply_3 = multiply_2(byte) ^ byte;

     end

endfunction


function [7:0] multiply_2 (input [7:0] byte);
    
    begin 
    if (byte[7]) begin
        multiply_2 = (byte << 1) ^ pre_fixed_reduction;
    end
    else begin
        multiply_2 = (byte << 1);
    end

    end 
    
endfunction

function [7:0] multiply_1 (input [7:0] byte);
    
    begin
        
        multiply_1 = byte; 

    end

    
endfunction



endmodule