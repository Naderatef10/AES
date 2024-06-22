module divide_bytes (
    input wire [127:0] plain_text,
    output wire [7:0] B0,
    output wire [7:0] B1,
    output wire [7:0] B2,
    output wire [7:0] B3,
    output wire [7:0] B4,
    output wire [7:0] B5,
    output wire [7:0] B6,
    output wire [7:0] B7,
    output wire [7:0] B8,
    output wire [7:0] B9,
    output wire [7:0] B10,
    output wire [7:0] B11,
    output wire [7:0] B12,
    output wire [7:0] B13,
    output wire [7:0] B14,
    output wire [7:0] B15
);

assign B15 = plain_text[7:0];
assign B14 = plain_text[15:8];
assign B13 = plain_text[23:16];
assign B12 = plain_text[31:24];
assign B11 = plain_text[39:32];
assign B10 = plain_text[47:40];
assign B9 = plain_text[55:48];
assign B8 = plain_text[63:56];
assign B7 = plain_text[71:64];
assign B6 = plain_text[79:72];
assign B5 = plain_text[87:80];
assign B4 = plain_text[95:88];
assign B3 = plain_text[103:96];
assign B2 = plain_text[111:104];
assign B1 = plain_text[119:112];
assign B0 = plain_text[127:120];
    
endmodule