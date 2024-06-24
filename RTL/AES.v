/*Top level module of the AES*/
module AES (
    
    input wire [127:0] plain_text, /*input plain text to the AES module*/
    input wire [127:0] key,/*input initial key to the AES*/
    input wire input_valid, /*input valid if asserted indicates valid plain_text and key*/
    input wire clk,
    input wire rst,
    output wire [127:0] cipher_text, /*output cipher text valid only upon the assertion of the output_valid*/
    output wire output_valid /*output valid if asserted indicates the completion of the encryption process high only for 1 clock cycle*/

);
/********************************************************************* Intermediate signals *************************************************/

wire [7:0] B0_input;
wire [7:0] B1_input;
wire [7:0] B2_input; 
wire [7:0] B3_input;
wire [7:0] B4_input;
wire [7:0] B5_input;
wire [7:0] B6_input;
wire [7:0] B7_input;
wire [7:0] B8_input;
wire [7:0] B9_input;
wire [7:0] B10_input;
wire [7:0] B11_input;
wire [7:0] B12_input;
wire [7:0] B13_input;
wire [7:0] B14_input;
wire [7:0] B15_input;

wire [7:0] K0_input;
wire [7:0] K1_input;
wire [7:0] K2_input; 
wire [7:0] K3_input;
wire [7:0] K4_input;
wire [7:0] K5_input;
wire [7:0] K6_input;
wire [7:0] K7_input;
wire [7:0] K8_input;
wire [7:0] K9_input;
wire [7:0] K10_input;
wire [7:0] K11_input;
wire [7:0] K12_input;
wire [7:0] K13_input;
wire [7:0] K14_input;
wire [7:0] K15_input;




wire [7:0] B0_input_mix_columns;
wire [7:0] B1_input_mix_columns;
wire [7:0] B2_input_mix_columns; 
wire [7:0] B3_input_mix_columns;
wire [7:0] B4_input_mix_columns;
wire [7:0] B5_input_mix_columns;
wire [7:0] B6_input_mix_columns;
wire [7:0] B7_input_mix_columns;
wire [7:0] B8_input_mix_columns;
wire [7:0] B9_input_mix_columns;
wire [7:0] B10_input_mix_columns;
wire [7:0] B11_input_mix_columns;
wire [7:0] B12_input_mix_columns;
wire [7:0] B13_input_mix_columns;
wire [7:0] B14_input_mix_columns;
wire [7:0] B15_input_mix_columns;

wire [7:0] B0_output_mix_columns;
wire [7:0] B1_output_mix_columns;
wire [7:0] B2_output_mix_columns; 
wire [7:0] B3_output_mix_columns;
wire [7:0] B4_output_mix_columns;
wire [7:0] B5_output_mix_columns;
wire [7:0] B6_output_mix_columns;
wire [7:0] B7_output_mix_columns;
wire [7:0] B8_output_mix_columns;
wire [7:0] B9_output_mix_columns;
wire [7:0] B10_output_mix_columns;
wire [7:0] B11_output_mix_columns;
wire [7:0] B12_output_mix_columns;
wire [7:0] B13_output_mix_columns;
wire [7:0] B14_output_mix_columns;
wire [7:0] B15_output_mix_columns;


wire [7:0] B0_input_shift_rows;
wire [7:0] B1_input_shift_rows;
wire [7:0] B2_input_shift_rows; 
wire [7:0] B3_input_shift_rows;
wire [7:0] B4_input_shift_rows;
wire [7:0] B5_input_shift_rows;
wire [7:0] B6_input_shift_rows;
wire [7:0] B7_input_shift_rows;
wire [7:0] B8_input_shift_rows;
wire [7:0] B9_input_shift_rows;
wire [7:0] B10_input_shift_rows;
wire [7:0] B11_input_shift_rows;
wire [7:0] B12_input_shift_rows;
wire [7:0] B13_input_shift_rows;
wire [7:0] B14_input_shift_rows;
wire [7:0] B15_input_shift_rows;


wire [7:0] B0_add_round_key_out;
wire [7:0] B1_add_round_key_out;
wire [7:0] B2_add_round_key_out; 
wire [7:0] B3_add_round_key_out;
wire [7:0] B4_add_round_key_out;
wire [7:0] B5_add_round_key_out;
wire [7:0] B6_add_round_key_out;
wire [7:0] B7_add_round_key_out;
wire [7:0] B8_add_round_key_out;
wire [7:0] B9_add_round_key_out;
wire [7:0] B10_add_round_key_out;
wire [7:0] B11_add_round_key_out;
wire [7:0] B12_add_round_key_out;
wire [7:0] B13_add_round_key_out;
wire [7:0] B14_add_round_key_out;
wire [7:0] B15_add_round_key_out;


wire [7:0] K0_expansion_out;
wire [7:0] K1_expansion_out;
wire [7:0] K2_expansion_out;
wire [7:0] K3_expansion_out;
wire [7:0] K4_expansion_out;
wire [7:0] K5_expansion_out;
wire [7:0] K6_expansion_out;
wire [7:0] K7_expansion_out;
wire [7:0] K8_expansion_out;
wire [7:0] K9_expansion_out;
wire [7:0] K10_expansion_out;
wire [7:0] K11_expansion_out;
wire [7:0] K12_expansion_out;
wire [7:0] K13_expansion_out;
wire [7:0] K14_expansion_out;
wire [7:0] K15_expansion_out;



wire [127:0] mux_out_add_round_key;
wire [127:0] mix_columns_merged;
wire initial_round_flag;
wire enable_add_round_Key;
wire enable_mix_columns;
wire enable_shift_rows;
wire enable_sub_bytes;
wire bypass;
wire[127:0] output_mux_pre_expansion;
wire enable_counter_top;
wire soft_rst_top;
wire [3:0] round_counter_top;
wire enable_key_expansion;
wire [127:0] key_expansion_merged;

/*******************************************End of intermediate signals **********************************************************************/


/*mux before add_round_Key multiplixing between the 128 bits output of the mix_columns and the input plain text to the design
if the initial_round_flag is equal to 1 the plain text is used else 0 in the main rounds the outputs of the mix_column is feeded to the 
add_round key*/
mux_2x1 mux_pre_add_round (
.in1(mix_columns_merged),
.in2(plain_text),
.mux_sel(initial_round_flag),
.out(mux_out_add_round_key)
);


/*input of add_round_key output of the mux before add_round_key the mux selects between the output of the mix_columns and the input plain text*/
divide_bytes divide_input(
.plain_text(mux_out_add_round_key),
.B0(B0_input),
.B1(B1_input),
.B2(B2_input),
.B3(B3_input),
.B4(B4_input),
.B5(B5_input),
.B6(B6_input),
.B7(B7_input),
.B8(B8_input),
.B9(B9_input),
.B10(B10_input),
.B11(B11_input),
.B12(B12_input),
.B13(B13_input),
.B14(B14_input),
.B15(B15_input)

);
/*add_round_key instant*/
add_round_key add_round_key_instant (
.clk(clk),
.rst(rst), 
.enable_add_round_Key(enable_add_round_Key),
.B0(B0_input),
.B1(B1_input),
.B2(B2_input),
.B3(B3_input),
.B4(B4_input),
.B5(B5_input),
.B6(B6_input),
.B7(B7_input),
.B8(B8_input),
.B9(B9_input),
.B10(B10_input),
.B11(B11_input),
.B12(B12_input),
.B13(B13_input),
.B14(B14_input),
.B15(B15_input),
.K0(K0_expansion_out),
.K1(K1_expansion_out),
.K2(K2_expansion_out),
.K3(K3_expansion_out),
.K4(K4_expansion_out),
.K5(K5_expansion_out),
.K6(K6_expansion_out),
.K7(K7_expansion_out),
.K8(K8_expansion_out),
.K9(K9_expansion_out),
.K10(K10_expansion_out),
.K11(K11_expansion_out),
.K12(K12_expansion_out),
.K13(K13_expansion_out),
.K14(K14_expansion_out),
.K15(K15_expansion_out),
.B0_new(B0_add_round_key_out),
.B1_new(B1_add_round_key_out),
.B2_new(B2_add_round_key_out),
.B3_new(B3_add_round_key_out),
.B4_new(B4_add_round_key_out),
.B5_new(B5_add_round_key_out),
.B6_new(B6_add_round_key_out),
.B7_new(B7_add_round_key_out),
.B8_new(B8_add_round_key_out),
.B9_new(B9_add_round_key_out),
.B10_new(B10_add_round_key_out),
.B11_new(B11_add_round_key_out),
.B12_new(B12_add_round_key_out),
.B13_new(B13_add_round_key_out),
.B14_new(B14_add_round_key_out),
.B15_new(B15_add_round_key_out)
);
/*merging the output bytes of the add_round_key into single 128 bits output to be considered as the output of the design*/
merge_bytes output_cipher_merge(
.B0(B0_add_round_key_out),
.B1(B1_add_round_key_out),
.B2(B2_add_round_key_out),
.B3(B3_add_round_key_out),
.B4(B4_add_round_key_out),
.B5(B5_add_round_key_out),
.B6(B6_add_round_key_out),
.B7(B7_add_round_key_out),
.B8(B8_add_round_key_out),
.B9(B9_add_round_key_out),
.B10(B10_add_round_key_out),
.B11(B11_add_round_key_out),
.B12(B12_add_round_key_out),
.B13(B13_add_round_key_out),
.B14(B14_add_round_key_out),
.B15(B15_add_round_key_out),
.output_cipher(cipher_text)


);

/*sub_bytes instant*/
sub_byte sub_byte_instance(
.clk(clk),
.rst(rst),
.bypass(bypass),
.enable_sub_byte(enable_sub_bytes),
.B0(B0_add_round_key_out),
.B1(B1_add_round_key_out),
.B2(B2_add_round_key_out),
.B3(B3_add_round_key_out),
.B4(B4_add_round_key_out),
.B5(B5_add_round_key_out),
.B6(B6_add_round_key_out),
.B7(B7_add_round_key_out),
.B8(B8_add_round_key_out),
.B9(B9_add_round_key_out),
.B10(B10_add_round_key_out),
.B11(B11_add_round_key_out),
.B12(B12_add_round_key_out),
.B13(B13_add_round_key_out),
.B14(B14_add_round_key_out),
.B15(B15_add_round_key_out),
.B0_new(B0_input_shift_rows),
.B1_new(B1_input_shift_rows),
.B2_new(B2_input_shift_rows),
.B3_new(B3_input_shift_rows),
.B4_new(B4_input_shift_rows),
.B5_new(B5_input_shift_rows),
.B6_new(B6_input_shift_rows),
.B7_new(B7_input_shift_rows),
.B8_new(B8_input_shift_rows),
.B9_new(B9_input_shift_rows),
.B10_new(B10_input_shift_rows),
.B11_new(B11_input_shift_rows),
.B12_new(B12_input_shift_rows),
.B13_new(B13_input_shift_rows),
.B14_new(B14_input_shift_rows),
.B15_new(B15_input_shift_rows)
);

/*shift_rows instant*/
shift_rows shift_rows_instant(
.clk(clk),
.rst(rst),
.bypass(bypass),
.enable_shift_rows(enable_shift_rows),
.B0_new(B0_input_mix_columns),
.B1_new(B1_input_mix_columns),
.B2_new(B2_input_mix_columns),
.B3_new(B3_input_mix_columns),
.B4_new(B4_input_mix_columns),
.B5_new(B5_input_mix_columns),
.B6_new(B6_input_mix_columns),
.B7_new(B7_input_mix_columns),
.B8_new(B8_input_mix_columns),
.B9_new(B9_input_mix_columns),
.B10_new(B10_input_mix_columns),
.B11_new(B11_input_mix_columns),
.B12_new(B12_input_mix_columns),
.B13_new(B13_input_mix_columns),
.B14_new(B14_input_mix_columns),
.B15_new(B15_input_mix_columns),
.B0(B0_input_shift_rows),
.B1(B1_input_shift_rows),
.B2(B2_input_shift_rows),
.B3(B3_input_shift_rows),
.B4(B4_input_shift_rows),
.B5(B5_input_shift_rows),
.B6(B6_input_shift_rows),
.B7(B7_input_shift_rows),
.B8(B8_input_shift_rows),
.B9(B9_input_shift_rows),
.B10(B10_input_shift_rows),
.B11(B11_input_shift_rows),
.B12(B12_input_shift_rows),
.B13(B13_input_shift_rows),
.B14(B14_input_shift_rows),
.B15(B15_input_shift_rows)

);

/*mix_columns instant*/
mix_columns mix_columns_instant(
.clk(clk),
.rst(rst),
.bypass(bypass),
.enable_mix_columns(enable_mix_columns),
.B0(B0_input_mix_columns),
.B1(B1_input_mix_columns),
.B2(B2_input_mix_columns),
.B3(B3_input_mix_columns),
.B4(B4_input_mix_columns),
.B5(B5_input_mix_columns),
.B6(B6_input_mix_columns),
.B7(B7_input_mix_columns),
.B8(B8_input_mix_columns),
.B9(B9_input_mix_columns),
.B10(B10_input_mix_columns),
.B11(B11_input_mix_columns),
.B12(B12_input_mix_columns),
.B13(B13_input_mix_columns),
.B14(B14_input_mix_columns),
.B15(B15_input_mix_columns),
.B0_new(B0_output_mix_columns),
.B1_new(B1_output_mix_columns),
.B2_new(B2_output_mix_columns),
.B3_new(B3_output_mix_columns),
.B4_new(B4_output_mix_columns),
.B5_new(B5_output_mix_columns),
.B6_new(B6_output_mix_columns),
.B7_new(B7_output_mix_columns),
.B8_new(B8_output_mix_columns),
.B9_new(B9_output_mix_columns),
.B10_new(B10_output_mix_columns),
.B11_new(B11_output_mix_columns),
.B12_new(B12_output_mix_columns),
.B13_new(B13_output_mix_columns),
.B14_new(B14_output_mix_columns),
.B15_new(B15_output_mix_columns)

);
/*merging the output bytes of the mix_columns to 128 bits to be muxed with the input plain text (original text) during the initial round
if the initial_round_flag is equal to 1 input text will be used else if it is zero the output of the mix_columns will be used */
merge_bytes merge_bytes_post_mix_columns(
.B0(B0_output_mix_columns),
.B1(B1_output_mix_columns),
.B2(B2_output_mix_columns),
.B3(B3_output_mix_columns),
.B4(B4_output_mix_columns),
.B5(B5_output_mix_columns),
.B6(B6_output_mix_columns),
.B7(B7_output_mix_columns),
.B8(B8_output_mix_columns),
.B9(B9_output_mix_columns),
.B10(B10_output_mix_columns),
.B11(B11_output_mix_columns),
.B12(B12_output_mix_columns),
.B13(B13_output_mix_columns),
.B14(B14_output_mix_columns),
.B15(B15_output_mix_columns),
.output_cipher(mix_columns_merged)

);


/*merging output bytes into a single 128 bit signal key_expansion_merged to be an input to the mux before key expansion module
to be muxed according to initial_round_flag*/
merge_bytes merge_bytes_pre_key_expansion(
.B0(K0_expansion_out),
.B1(K1_expansion_out),
.B2(K2_expansion_out),
.B3(K3_expansion_out),
.B4(K4_expansion_out),
.B5(K5_expansion_out),
.B6(K6_expansion_out),
.B7(K7_expansion_out),
.B8(K8_expansion_out),
.B9(K9_expansion_out),
.B10(K10_expansion_out),
.B11(K11_expansion_out),
.B12(K12_expansion_out),
.B13(K13_expansion_out),
.B14(K14_expansion_out),
.B15(K15_expansion_out),
.output_cipher(key_expansion_merged)

);


/*when initial round is activated enter the original key when 1 the input key will be used else when 0 the output of the previous round will be used*/
mux_2x1 pre_key_expansion_instant(
.in1(key_expansion_merged), /*key expansion merged is the output of the key expansion module but after merging the 16 bytes into single 128 bit signal*/
.in2(key),
.mux_sel(initial_round_flag),
.out(output_mux_pre_expansion) /*output of the mux to be later divided using the divide_input_pre_key_expansion instance to divide into 16 bytes 
for key expansion module to operate correctly*/


);

/*dividing the output of the mux before the key expansion module from 128 bits to 16 bytes for proper operations of the modules*/
divide_bytes divide_input_pre_key_expansion(
.plain_text(output_mux_pre_expansion),
.B0(K0_input),
.B1(K1_input),
.B2(K2_input),
.B3(K3_input),
.B4(K4_input),
.B5(K5_input),
.B6(K6_input),
.B7(K7_input),
.B8(K8_input),
.B9(K9_input),
.B10(K10_input),
.B11(K11_input),
.B12(K12_input),
.B13(K13_input),
.B14(K14_input),
.B15(K15_input)

);

/*key expansion instance*/
key_expansion key_expansion_instant(
.clk(clk),
.rst(rst), 
.round_number(round_counter_top),
.bypass(bypass),
.enable_key_expansion(enable_key_expansion),
.K0(K0_input),
.K1(K1_input),
.K2(K2_input),
.K3(K3_input),
.K4(K4_input),
.K5(K5_input),
.K6(K6_input),
.K7(K7_input),
.K8(K8_input),
.K9(K9_input),
.K10(K10_input),
.K11(K11_input),
.K12(K12_input),
.K13(K13_input),
.K14(K14_input),
.K15(K15_input),
.K0_new(K0_expansion_out),
.K1_new(K1_expansion_out),
.K2_new(K2_expansion_out),
.K3_new(K3_expansion_out),
.K4_new(K4_expansion_out),
.K5_new(K5_expansion_out),
.K6_new(K6_expansion_out),
.K7_new(K7_expansion_out),
.K8_new(K8_expansion_out),
.K9_new(K9_expansion_out),
.K10_new(K10_expansion_out),
.K11_new(K11_expansion_out),
.K12_new(K12_expansion_out),
.K13_new(K13_expansion_out),
.K14_new(K14_expansion_out),
.K15_new(K15_expansion_out)

);

/*round_counter*/
counter round_counter_instant(
.clk(clk),
.rst(rst),
.enable_counter(enable_counter_top),
.soft_rst(soft_rst_top), 
.counter(round_counter_top) 


);


/*FSM controller*/
controller Top_controller (

.clk(clk),
.rst(rst),
.input_valid(input_valid),
.round_counter( round_counter_top),
.soft_rst(soft_rst_top),
.enable_mix_columns(enable_mix_columns),
.initial_round_flag(initial_round_flag),
.valid_output(output_valid),
.enable_add_round_key(enable_add_round_Key),
.enable_key_expansion(enable_key_expansion),
.enable_shift_rows(enable_shift_rows),
.enable_sub_bytes(enable_sub_bytes),
.bypass(bypass),
.enable_counter(enable_counter_top)


);


endmodule