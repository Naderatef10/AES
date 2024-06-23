/*module mix_columns , used to perform mix_columns step in AES algorithm, the mix_column is excluded from the final_round and initial_round
the module is based on the 3 main functions:.
1)multiply_1
2)multiply_2
3)multiply_3
they are described in their declaration.
*/
module mix_columns (
input wire clk,
input wire rst, 
input wire enable_mix_columns, /*enable mix_columns generated from the top level_controller*/
input wire bypass, /*used to make mix_columns module operate as a buffer between input and output in case of initial_round and final_round*/
/*input bytes*/
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
/*output bytes*/
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

assign pre_fixed_reduction = 8'b00011011; /*extracted from fips standard*/ 

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

/*combinational signals outputs*/
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

/*the combinational operations*/
/*any addition is performed as Xor operation*/


/*multipling the first row of the pre_defined_matrix with the first column of the state matrix*/
assign B0_new_comb = multiply_2(B0) ^ multiply_3(B1) ^ multiply_1(B2) ^ multiply_1(B3);
/*multipling the second row of the pre_defined_matrix with the first column of the state matrix*/
assign B1_new_comb = multiply_1(B0) ^ multiply_2(B1) ^ multiply_3(B2) ^ multiply_1(B3);
/*multipling the third row of the pre_defined_matrix with the first column of the state matrix*/
assign B2_new_comb = multiply_1(B0) ^ multiply_1(B1) ^ multiply_2(B2) ^ multiply_3(B3);
/*multipling the fourth row of the pre_defined_matrix with the first column of the state matrix*/
assign B3_new_comb = multiply_3(B0) ^ multiply_1(B1) ^ multiply_1(B2) ^ multiply_2(B3);

/*multipling the first row of the pre_defined_matrix with the second column of the state matrix*/
assign B4_new_comb = multiply_2(B4) ^ multiply_3(B5) ^ multiply_1(B6) ^ multiply_1(B7);
/*multipling the second row of the pre_defined_matrix with the second column of the state matrix*/
assign B5_new_comb = multiply_1(B4) ^ multiply_2(B5) ^ multiply_3(B6) ^ multiply_1(B7);
/*multipling the third row of the pre_defined_matrix with the second column of the state matrix*/
assign B6_new_comb = multiply_1(B4) ^ multiply_1(B5) ^ multiply_2(B6) ^ multiply_3(B7);
/*multipling the fourth row of the pre_defined_matrix with the second column of the state matrix*/
assign B7_new_comb = multiply_3(B4) ^ multiply_1(B5) ^ multiply_1(B6) ^ multiply_2(B7);

/*multipling the first row of the pre_defined_matrix with the third column of the state matrix*/
assign B8_new_comb = multiply_2(B8) ^ multiply_3(B9) ^ multiply_1(B10) ^ multiply_1(B11);
/*multipling the second row of the pre_defined_matrix with the third column of the state matrix*/
assign B9_new_comb = multiply_1(B8) ^ multiply_2(B9) ^ multiply_3(B10) ^ multiply_1(B11);
/*multipling the third row of the pre_defined_matrix with the third column of the state matrix*/
assign B10_new_comb = multiply_1(B8) ^ multiply_1(B9) ^ multiply_2(B10) ^ multiply_3(B11);
/*multipling the fourth row of the pre_defined_matrix with the third column of the state matrix*/
assign B11_new_comb = multiply_3(B8) ^ multiply_1(B9) ^ multiply_1(B10) ^ multiply_2(B11);

/*multipling the first row of the pre_defined_matrix with the fourth column of the state matrix*/
assign B12_new_comb = multiply_2(B12) ^ multiply_3(B13) ^ multiply_1(B14) ^ multiply_1(B15);
/*multipling the second row of the pre_defined_matrix with the fourth column of the state matrix*/
assign B13_new_comb = multiply_1(B12) ^ multiply_2(B13) ^ multiply_3(B14) ^ multiply_1(B15);
/*multipling the third row of the pre_defined_matrix with the fourth column of the state matrix*/
assign B14_new_comb = multiply_1(B12) ^ multiply_1(B13) ^ multiply_2(B14) ^ multiply_3(B15);
/*multipling the fourth row of the pre_defined_matrix with the fourth column of the state matrix*/
assign B15_new_comb = multiply_3(B12) ^ multiply_1(B13) ^ multiply_1(B14) ^ multiply_2(B15);

/*registering the outputs bytes of the combinational logic*/
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
    end /*register the combinational logic if enable_mix_columns is high*/
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
    /*bypass is enabled in the initial round and the final round of the AES operation so the module acts as a buffer to avoid any change on
    the input bytes before reaching add_round_key module
    */
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
/*
pre_defined_matrix = [ 2   3   1   1;
                       1   2   3   1;
                       1   1   2   3;
                       3   1   1   2];

*/

/*the choice between multiply_3, multiply_2, multiply_1 functions is based on the pre_defined_matrix stated in the fips standard
if the multiplication is between a byte (text) and 3 numbers either 1,2,3 stated in the pre_defined_matrix we multiply each row with a column
to produce the new column of the state matrix then move to the next column in the old state matrix

*/
/*in case the byte is multiplied by 3 in the pre_defined_matrix the result is multiply_2 multiplied the byte it self*/
function [7:0] multiply_3 (input [7:0] byte);
     reg [7:0] result_multiply_2;
     begin
     
     multiply_3 = multiply_2(byte) ^ byte;

     end

endfunction

/*multiply by 2 depends on the MSb of the byte to be multiplied*/
function [7:0] multiply_2 (input [7:0] byte);
    
    begin 
        /*if the MSb is 1 then we will shift left by 1 then xor with the pre_fixed_reduction byte stated in the fips standard*/
    if (byte[7]) begin
        multiply_2 = (byte << 1) ^ pre_fixed_reduction;
    end
    else begin /*if the MSb is equal to zero we will just shift left*/
        multiply_2 = (byte << 1);
    end

    end 
    
endfunction
/*mutliply_1 return the byte as it is*/
function [7:0] multiply_1 (input [7:0] byte);
    
    begin
        
        multiply_1 = byte; 

    end

    
endfunction



endmodule