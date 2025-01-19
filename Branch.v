module branch(A, B, pcflag, func, fcall, fcallend);
    input [15:0] A,B;
    input [2:0] func;

    output pcflag, fcall,fcallend;

    wire lt, gt, eq;
    assign lt = (A < B) ? 1'b1 : 1'b0;  
    assign gt = (A > B) ? 1'b1 : 1'b0;  
    assign eq = (A == B) ? 1'b1 : 1'b0; 

    assign pcflag = ((func == 3'b000) & (eq)) ? 1'b1:
                    ((func == 3'b001) & (~eq)) ? 1'b1:
                    ((func == 3'b010) & (lt)) ? 1'b1:
                    ((func == 3'b011) & ((lt) | (eq))) ? 1'b1:
                    ((func == 3'b100) & (gt)) ? 1'b1:
                    ((func == 3'b101) & ((gt) | (eq))) ? 1'b1: 1'b0;


    assign fcall = (func == 3'b110) ? 1'b1 : 1'b0;

    assign fcallend = (func == 3'b111) ? 1'b1 : 1'b0;


endmodule