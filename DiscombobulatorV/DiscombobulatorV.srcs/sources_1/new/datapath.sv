module datapath(
    input logic clk, reset,
    input logic [1:0] resultSrcD,
    input logic aluSrcD,
    input logic regWriteD,
    input logic memWriteD,
    input logic [1:0] immSrcD,
    input logic [2:0] aluControlD,
    input logic branchD,
    input logic jumpD,
    output logic [31:0] pcF,
    input logic [31:0] instrF,
    output logic [31:0] aluResultM, writeDataM,
    output logic memWriteM,
    input logic [31:0] readDataM,
    output logic [31:0] instrD
);

// Fetch
logic [31:0] pcNext, pcPlus4F;
// Decode
logic [31:0] pcD, pcPlus4D, rd1D, rd2D, immExtD;
logic [4:0]  rdD, rs1D, rs2D;
// Execute
logic regWriteE, memWriteE, jumpE, branchE, aluSrcE;
logic [1:0]  resultSrcE;
logic [2:0]  aluControlE;
logic [31:0] rd1E, rd2E, pcE, immExtE, pcPlus4E, srcAE, srcBE, aluResultE, writeDataE, pcTargetE;
logic [4:0]  rdE, rs1E, rs2E;
logic zeroE, pcSrcE;
// Memory
logic regWriteM;
logic [1:0]  resultSrcM;
logic [31:0] pcPlus4M;
logic [4:0]  rdM;
// Writeback
logic regWriteW;
logic [1:0]  resultSrcW;
logic [31:0] aluResultW, readDataW, pcPlus4W, resultW;
logic [4:0]  rdW;
//Hazard Unit
logic [1:0] forwardAE, forwardBE;

//FETCH STAGE
mux2 #(32) pcMux(pcPlus4F, pcTargetE, pcSrcE, pcNext);

flopr #(.size(32)) PC(
    .clk(clk), 
    .rst(reset), 
    .d(pcNext), 
    .q(pcF)
);

assign pcPlus4F = pcF + 32'd4;

if_id_reg IF_ID(
    .clk(clk), .rst(reset),
    .instrF(instrF), .pcF(pcF), .pcPlus4F(pcPlus4F),
    .instrD(instrD), .pcD(pcD), .pcPlus4D(pcPlus4D)
);


//DECODE STAGE
assign rdD = instrD[11:7]; 

regfile RegFile(
    .clk(clk),
    .WE3(regWriteW),           
    .A1(instrD[19:15]),
    .A2(instrD[24:20]),
    .A3(rdW),                  
    .WD3(resultW),             
    .RD1(rd1D),
    .RD2(rd2D)
);

extend Extend(
    .instr(instrD[31:7]), 
    .immSrc(immSrcD), 
    .immExt(immExtD)
);

//ID/EX 
id_ex_reg ID_EX(
    .clk(clk), .rst(reset),
    .rs1D(instrD[19:15]), .rs2D(instrD[24:20]),
    .rs1E(rs1E), .rs2E(rs2E),
    .regWriteD(regWriteD), .resultSrcD(resultSrcD), .memWriteD(memWriteD),
    .jumpD(jumpD), .branchD(branchD), .aluControlD(aluControlD), .aluSrcD(aluSrcD),
    .rd1D(rd1D), .rd2D(rd2D), .pcD(pcD), .rdD(rdD), .immExtD(immExtD), .pcPlus4D(pcPlus4D),
    .regWriteE(regWriteE), .resultSrcE(resultSrcE), .memWriteE(memWriteE),
    .jumpE(jumpE), .branchE(branchE), .aluControlE(aluControlE), .aluSrcE(aluSrcE),
    .rd1E(rd1E), .rd2E(rd2E), .pcE(pcE), .rdE(rdE), .immExtE(immExtE), .pcPlus4E(pcPlus4E)
);


hazardUnit HazardUnit(
    .rs1E(rs1E),
    .rs2E(rs2E),
    .rdM(rdM),
    .rdW(rdW),
    .regWriteM(regWriteM),
    .regWriteW(regWriteW),
    .forwardAE(forwardAE),
    .forwardBE(forwardBE)
    );

mux3 #32 MuxForwardA (rd1E, resultW, aluResultM, forwardAE, srcAE);
mux3 #32 MuxForwardB (rd2E, resultW, aluResultM, forwardBE, writeDataE);

mux2 #(32) srcBMux(writeDataE, immExtE, aluSrcE, srcBE);

alu ALU(
    .in0(srcAE), 
    .in1(srcBE), 
    .sel(aluControlE), 
    .out(aluResultE), 
    .zf(zeroE)
);

assign pcTargetE = pcE + immExtE;
assign pcSrcE = (branchE & zeroE) | jumpE; 

//EX/MEM
ex_mem_reg EX_MEM(
    .clk(clk), .rst(reset),
    .regWriteE(regWriteE), .resultSrcE(resultSrcE), .memWriteE(memWriteE),
    .aluResultE(aluResultE), .writeDataE(writeDataE), .rdE(rdE), .pcPlus4E(pcPlus4E),
    .regWriteM(regWriteM), .resultSrcM(resultSrcM), .memWriteM(memWriteM),
    .aluResultM(aluResultM), .writeDataM(writeDataM), .rdM(rdM), .pcPlus4M(pcPlus4M)
);

//REGISTRU MEM/WB
mem_wb_reg MEM_WB(
    .clk(clk), .rst(reset),
    .regWriteM(regWriteM), .resultSrcM(resultSrcM),
    .aluResultM(aluResultM), .readDataM(readDataM), .rdM(rdM), .pcPlus4M(pcPlus4M),
    .regWriteW(regWriteW), .resultSrcW(resultSrcW),
    .aluResultW(aluResultW), .readDataW(readDataW), .rdW(rdW), .pcPlus4W(pcPlus4W)
);


mux3 #(32) resultMux(
    .in0(aluResultW), 
    .in1(readDataW), 
    .in2(pcPlus4W), 
    .sel(resultSrcW), 
    .out(resultW)
);

endmodule