module Memory(adr, WD, clk, WE, Memout);
    input [12:0] adr;
    input [15:0] WD;
    input clk, WE;
    
    output [15:0] Memout;


    //Memory
    reg [15:0] mem [8191:0];

    // Loigc


    assign Memout = (WE == 1'b1) ? 16'b0000000000000000 : mem[adr]; //Read

    always @(posedge clk )
    begin
        if (WE == 1'b1) 
        begin
            mem[adr] <= WD;
        end
        
    end

    initial begin
        mem[13'b0000000000000] = 25;
        mem[13'b0000000000001] = 20;
        mem[13'b0000000000010] = 30;
    end



endmodule