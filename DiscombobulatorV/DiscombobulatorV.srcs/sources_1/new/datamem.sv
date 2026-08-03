module datamem(
    input logic clk,
    input logic we,
    input logic [31:0] wd,
    input logic [31:0] a,
    output logic [31:0] rd
    );

logic [31:0] ram [63:0];

assign rd = ram[a[31:2]];

always_ff @(posedge clk) 
    if(we)
        ram[a[31:2]] <= wd;
 
    
endmodule
