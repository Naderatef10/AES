module key_expansion (
input wire clk,
input wire rst, 
input wire [3:0] round_number,
input wire bypass,
input wire enable_key_expansion,

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



output reg [7:0] K0_new,
output reg [7:0] K1_new,
output reg [7:0] K2_new,
output reg [7:0] K3_new,
output reg [7:0] K4_new,
output reg [7:0] K5_new,
output reg [7:0] K6_new,
output reg [7:0] K7_new,
output reg [7:0] K8_new,
output reg [7:0] K9_new,
output reg [7:0] K10_new,
output reg [7:0] K11_new,
output reg [7:0] K12_new,
output reg [7:0] K13_new,
output reg [7:0] K14_new,
output reg [7:0] K15_new
);


reg [15:0] R_conn;
wire [7:0] K_13_sub;
wire [7:0] K_14_sub;
wire [7:0] K_15_sub;
wire [7:0] K_12_sub;




reg [7:0] K0_new_comb;
reg [7:0] K1_new_comb;
reg [7:0] K2_new_comb;
reg [7:0] K3_new_comb;
reg [7:0] K4_new_comb;
reg [7:0] K5_new_comb;
reg [7:0] K6_new_comb;
reg [7:0] K7_new_comb;
reg [7:0] K8_new_comb;
reg [7:0] K9_new_comb;
reg [7:0] K10_new_comb;
reg [7:0] K11_new_comb;
reg [7:0] K12_new_comb;
reg [7:0] K13_new_comb;
reg [7:0] K14_new_comb;
reg [7:0] K15_new_comb;







sbox s1(K13,K_13_sub);
sbox s2(K14,K_14_sub);
sbox s3(K15,K_15_sub);
sbox s4(K12,K_12_sub);


always @(*) begin
    
    case (round_number)

        4'd1: R_conn = 16'h01;

        4'd2: R_conn = 16'h02;

        4'd3: R_conn = 16'h04;

        4'd4: R_conn = 16'h08;

        4'd5: R_conn = 16'h10;

        4'd6: R_conn = 16'h20;

        4'd7: R_conn = 16'h40;

        4'd8: R_conn = 16'h80;

        4'd9: R_conn = 16'h1B;

        4'd10: R_conn = 16'h36;
        default : R_conn = 0;
        
    endcase
end

always @(*) begin

    if(bypass)begin
            K0_new_comb= K0;
            K1_new_comb= K1;
            K2_new_comb= K2;
            K3_new_comb= K3;
            K4_new_comb= K4;
            K5_new_comb=K5;
            K6_new_comb=K6;
            K7_new_comb=K7;
            K8_new_comb=K8;
            K9_new_comb=K9;
            K10_new_comb=K10;
            K11_new_comb=K11;
            K12_new_comb=K12;
            K13_new_comb=K13;
            K14_new_comb=K14;
            K15_new_comb=K15;                 
    end
    else if (enable_key_expansion) begin
        
            K0_new_comb = (K0 ^ K_13_sub ^ R_conn);
            K1_new_comb =  (K1^K_14_sub);
            K2_new_comb = (K2^K_15_sub);
            K3_new_comb = (K3^K_12_sub);
            K4_new_comb = K4 ^ K0_new_comb;
            K5_new_comb = K5 ^ K1_new_comb;
            K6_new_comb = K6 ^ K2_new_comb;
            K7_new_comb = K7 ^ K3_new_comb;
            K8_new_comb = K8 ^ K4_new_comb;
            K9_new_comb = K9 ^ K5_new_comb;
            K10_new_comb = K10 ^K6_new_comb;
            K11_new_comb = K11 ^ K7_new_comb;
            K12_new_comb = K12 ^ K8_new_comb;
            K13_new_comb = K13 ^ K9_new_comb;
            K14_new_comb = K14 ^ K10_new_comb;
            K15_new_comb = K15 ^ K11_new_comb;

        
    end
    else begin
            K0_new_comb= K0;
            K1_new_comb= K1;
            K2_new_comb= K2;
            K3_new_comb= K3;
            K4_new_comb= K4;
            K5_new_comb=K5;
            K6_new_comb=K6;
            K7_new_comb=K7;
            K8_new_comb=K8;
            K9_new_comb=K9;
            K10_new_comb=K10;
            K11_new_comb=K11;
            K12_new_comb=K12;
            K13_new_comb=K13;
            K14_new_comb=K14;
            K15_new_comb=K15;
    end


end

always @(posedge clk , negedge rst) begin

        if(!rst)begin
            K0_new<=0;
            K1_new<=0;
            K2_new<=0;
            K3_new<=0;
            K4_new<=0;
            K5_new<=0;
            K6_new<=0;
            K7_new<=0;
            K8_new<=0;
            K9_new<=0;
            K10_new<=0;
            K11_new<=0;
            K12_new<=0;
            K13_new<=0;
            K14_new<=0;
            K15_new<=0;
        end
        else begin
            K0_new<=K0_new_comb;
            K1_new<=K1_new_comb;
            K2_new<=K2_new_comb;
            K3_new<=K3_new_comb;
            K4_new<=K4_new_comb;
            K5_new<=K5_new_comb;
            K6_new<=K6_new_comb;
            K7_new<=K7_new_comb;
            K8_new<=K8_new_comb;
            K9_new<=K9_new_comb;
            K10_new<=K10_new_comb;
            K11_new<=K11_new_comb;
            K12_new<=K12_new_comb;
            K13_new<=K13_new_comb;
            K14_new<=K14_new_comb;
            K15_new<=K15_new_comb;


        end



end








    
endmodule