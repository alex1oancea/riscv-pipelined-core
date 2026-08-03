module datapath(
    input logic clk, reset,
    input logic [1:0] resultSrc,
    input logic pcSrc, aluSrc,
    input logic regWrite,
    input logic [1:0] immSrc,
    input logic [2:0] aluControl,
    output logic zero,
    output logic [31:0] pc,
    input logic [31:0] instr,
    output logic [31:0] aluResult, writeData,
    input logic [31:0] readData
    );

logic [31:0] pcNext, pcPlus4, pcTarget, immExt, srcA, srcB, result;

//next pc logic
flopr #(.size(32)) PC
(
    .d(pcNext),
    .clk(clk), .rst(reset),
    .q(pc)
);

assign pcPlus4 = pc + 32'd4;
assign pcTarget = pc + immExt;
mux2 #(32) pcMux(pcPlus4, pcTarget, pcSrc, pcNext);

//register file logic
regfile RegFile(
    .clk(clk),
    .WE3(regWrite),
    .A1(instr[19:15]),
    .A2(instr[24:20]),
    .A3(instr[11:7]),
    .WD3(result),
    .RD1(srcA),
    .RD2(writeData)
);

extend Extend(instr[31:7], immSrc, immExt);

//ALU logic    
mux2 #(32) SRCbMux(writeData, immExt, aluSrc, srcB);
alu ALU (srcA, srcB, aluControl, aluResult, zero);
mux3 #(32) ResultMux (aluResult, readData, pcPlus4, resultSrc, result);   
endmodule
