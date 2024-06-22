module mux_2x1 (
    input wire [127:0] in1,
    input wire [127:0] in2,
    input wire mux_sel,
    output reg [127:0] out
);
    
    always @(*) begin
        
        case (mux_sel)
            1'b0: out = in1;
            
            1'b1: out = in2;
        endcase


    end


endmodule