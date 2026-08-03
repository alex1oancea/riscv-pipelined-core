module mainDecorder(
    input logic [6:0] op,
    output logic branch,
    output logic [1:0] resultSrc,
    output logic memWrite,
    output logic aluSrc,
    output logic jump,
    output logic [1:0] immSrc,
    output logic regWrite,
    output logic [1:0] aluOp
    );
    
    logic [10:0] controls;
    
    assign {regWrite, immSrc, aluSrc, memWrite, resultSrc, branch, aluOp, jump} = controls;
    
    always_comb begin
        case(op)  
            7'b0000011: controls = 11'b1_00_1_0_01_0_00_0;//lw
            7'b0100011: controls = 11'b0_01_1_1_00_0_00_0;//sw
            7'b0110011: controls = 11'b1_xx_0_0_00_0_10_0;//r-type
            7'b1100011: controls = 11'b0_10_0_0_00_1_01_0;//beq
            7'b0010011: controls = 11'b1_00_1_0_00_0_10_0;//i-type
            7'b1101111: controls = 11'b1_11_0_0_10_0_00_1;//jal
            default: controls = 11'bx;
        endcase
    end
    
endmodule
