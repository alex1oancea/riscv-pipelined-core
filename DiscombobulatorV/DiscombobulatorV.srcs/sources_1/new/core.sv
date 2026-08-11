module core(
    input logic clk,
    input logic reset,
    output logic [31:0] pc,
    input logic [31:0] instr,
    output logic memWrite,
    output logic [31:0] aluResult, writeData,
    input logic [31:0] readData
    );

logic aluSrcD, regWriteD, jumpD, branchD, memWriteD;
logic [1:0] resultSrcD, immSrcD;
logic [2:0] aluControlD;
logic [31:0] instrD;

controller Cntrl (
    .op(instrD[6:0]),
    .funct3(instrD[14:12]),
    .funct7b5(instrD[30]),
    .resultSrc(resultSrcD),
    .memWrite(memWriteD),
    .aluSrc(aluSrcD),
    .immSrc(immSrcD),
    .regWrite(regWriteD),
    .aluControl(aluControlD),
    .branch(branchD),
    .jump(jumpD)
);    
    
datapath Data(
    .clk(clk), .reset(reset),
    .resultSrcD(resultSrcD),
    .aluSrcD(aluSrcD),
    .regWriteD(regWriteD),
    .memWriteD(memWriteD),
    .immSrcD(immSrcD),
    .aluControlD(aluControlD),
    .branchD(branchD),
    .jumpD(jumpD),
    .pcF(pc),
    .instrF(instr),
    .aluResultM(aluResult), .writeDataM(writeData),
    .memWriteM(memWrite),
    .readDataM(readData),
    .instrD(instrD)
);

   
endmodule
