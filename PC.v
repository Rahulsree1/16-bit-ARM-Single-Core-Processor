    module PC(clk,rst,pcN,pc);
        input [4:0] pcN;
        input clk, rst;

        output reg [4:0] pc;

        always @(posedge clk) 
        begin
            if (rst == 1'b0) 
            begin
                pc <= 5'b00000;            
            end
            else 
            begin
                pc <= pcN;    
            end
        end



    endmodule


