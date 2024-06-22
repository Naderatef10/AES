module counter (
    input wire clk,rst,
    input wire enable_counter,
    input wire soft_rst, 

    output reg [3:0] counter 

);

always @(posedge clk , negedge rst) begin

        if(!rst)begin
            counter <= 0;
        end
        else if (soft_rst)begin
            counter <= 0;
        end
        else if (counter == 4'd11)begin
            counter <= counter;
        end

        else if (enable_counter)begin
            counter <= counter + 1'b1;
        end
        
end
    
endmodule