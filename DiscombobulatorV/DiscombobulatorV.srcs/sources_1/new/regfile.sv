module refile(
    input logic clk,
    input logic WE3,
    input logic [4:0] A1,
    input logic [4:0] A2,
    input logic [4:0] A3,
    input logic [31:0] WD3,
    output logic [31:0] RD1,
    output logic [31:0] RD2
);

logic [0:31] mem [31:0];

assign RD1 = (A1 == 0) ? 32'd0 : mem[A1];
assign RD2 = (A2 == 0) ? 32'd0 : mem[A2];

always_ff @(posedge clk) begin
    if (WE3 == 1)
        mem[A3] <= WD3;
end

endmodule