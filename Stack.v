module stack(clk, reset, push, pop, data_in,data_out);

    input clk,push,pop,reset;
    input [4:0] data_in;

    output [4:0] data_out;

    reg [4:0] mem;

    assign data_out = (!reset) ? 5'b00000 : (pop) ? mem : 5'b00000;

    always @(posedge clk ) begin

        if (push) begin

            mem <= data_in;
            
        end


        
    end

endmodule