module instrmem (
    input logic [31:0] a,
    output logic [31:0] rd
);

logic [31:0] rom [63:0];
initial 
    $readmemh("C:/proiecte/riscv-pipelined-core/DiscombobulatorV/DiscombobulatorV.srcs/sources_1/riscvtest.txt", rom);
assign rd = rom[a[31:2]];

endmodule