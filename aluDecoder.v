module aluDecode(func, aluop, aluC);
    input [2:0] func;
    input [1:0] aluop;

    output [2:0] aluC;


    assign aluC = (aluop == 2'b00) ? 3'b000 :
                  (aluop == 2'b01) ? 3'b001 :
                  (aluop == 2'b10) ? func : 3'b000;

endmodule