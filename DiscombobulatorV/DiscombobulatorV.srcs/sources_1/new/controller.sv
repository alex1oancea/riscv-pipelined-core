module controller (
    input logic zero,
    input logic [6:0] op,
    input logic [2:0] funct3,
    input logic funct7b5,
    output logic pcSrc,
    output logic [1:0] resultSrc,
    output logic memWrite,
    output logic aluSrc,
    output logic [1:0] immSrc,
    output logic regWrite,
    output logic [2:0] aluControl
);

logic branchy, jumpy;
logic [1:0] aluOp;

mainDecorder mainDec(
    .op(op),
    .branch(branchy),
    .resultSrc(resultSrc),
    .memWrite(memWrite),
    .aluSrc(aluSrc),
    .jump(jumpy),
    .immSrc(immSrc),
    .regWrite(regWrite),
    .aluOp(aluOp)
    );

assign pcSrc = (branchy & zero) | jumpy;

aluDecoder aluDec(
    .op_b5(op[5]),
    .funct3(funct3),
    .funct7b5(funct7b5),
    .aluOp(aluOp),
    .aluControl(aluControl)
);

endmodule