/*merge_bytes module used to concatenate the 16 bytes into 128 byte text after the completiong of the encryption process
this is according to the Fips standard
*/
module merge_bytes (
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

    output wire [127:0] output_cipher
);
/*the first byte in the Fips standard is the MSB of the 128 bits*/
assign output_cipher = {B0,B1,B2,B3,B4,B5,B6,B7,B8,B9,B10,B11,B12,B13,B14,B15};
    
endmodule