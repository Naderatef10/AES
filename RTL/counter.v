/*counter is used to count the number of rounds during the operation of the AES 
in case of key size 128 bits there are 10 main rounds and one initial round
therefore the counter length is minimum 4 bits.
the counter is enabled using enable_counter signal from top level controller
soft_rst signal is used to reset the counter after completing the encryption process, it is generated from the top level controller
*/
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
        end /*if counter equals 11 then all the rounds are finished and we will not increment any more.*/
        else if (counter == 4'd11)begin
            counter <= counter;
        end

        else if (enable_counter)begin
            counter <= counter + 1'b1;
        end
        
end
    
endmodule