module core(
    input logic clk,
    input logic reset,
    output logic [31:0] pc,
    input logic [31:0] instr,
    output logic memWrite,
    output logic [31:0] aluResult, writeData,
    input logic [31:0] readData
    );

logic aluSrc, regWrite, jump, zero, pcSrc;
logic [1:0] resultSrc, immSrc;
logic [2:0] aluControl;

controller Cntrl (
    .zero(zero),
    .op(instr[6:0]),
    .funct3(instr[14:12]),
    .funct7b5(instr[30]),
    .pcSrc(pcSrc),
    .resultSrc(resultSrc),
    .memWrite(memWrite),
    .aluSrc(aluSrc),
    .immSrc(immSrc),
    .regWrite(regWrite),
    .aluControl(aluControl)
);    
    
datapath Data(
    .clk(clk), .reset(reset),
    .resultSrc(resultSrc),
    .pcSrc(pcSrc), .aluSrc(aluSrc),
    .regWrite(regWrite),
    .immSrc(immSrc),
    .aluControl(aluControl),
    .zero(zero),
    .pc(pc),
    .instr(instr),
    .aluResult(aluResult), .writeData(writeData),
    .readData(readData)
);

   
endmodule
