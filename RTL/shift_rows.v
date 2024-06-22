module shift_rows (
    input wire clk,
    input wire rst, 
    input wire enable_shift_rows,
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

always @(posedge clk , negedge rst) begin
    
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
        else if (enable_shift_rows)begin
            
            /*****first row in the state matrix stays the same*********/


            B0_new <= B0;
            B4_new <= B4;
            B8_new <= B8;
            B12_new <= B12;

            /***************** second row (one cyclic shift right) *************/

            B1_new <= B5;
            B5_new <= B9;
            B9_new <= B13;
            B13_new <= B1;
            

            /********************** third row (2 cyclic shifts right) ******************/

            B2_new <= B10; 
            B6_new <= B14;
            B10_new <= B2;
            B14_new <= B6;

            /********************* fourth row (3 cyclic shifts right) ********************/

            B3_new <= B15;
            B7_new <= B3;
            B11_new <= B7;
            B15_new <= B11;

        end

        else if (bypass) begin
            
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