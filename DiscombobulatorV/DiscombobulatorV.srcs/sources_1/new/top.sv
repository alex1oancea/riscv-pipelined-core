module top(
    input logic clk, rst,
    output logic [31:0] dataAdr,
    output logic [31:0] writeData,
    output logic memWrite
    );
    
logic [31:0] instr, pc, readData;
    
core Core(
    .clk(clk),
    .reset(rst),
    .pc(pc),
    .instr(instr),
    .memWrite(memWrite),
    .aluResult(dataAdr), .writeData(writeData),
    .readData(readData)
    );

instrmem InstrMem(
    .a(pc),
    .rd(instr)
);

datamem DataMem( 
    .clk(clk),
    .we(memWrite),
    .wd(writeData),
    .a(dataAdr),
    .rd(readData)
    );
    
endmodule
