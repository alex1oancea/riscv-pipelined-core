`timescale 1ns / 1ps
module tb();

logic clk, reset, memWrite;
logic [31:0] writeData, dataAdr;
top Dut(
    .clk(clk), .rst(reset),
    .dataAdr(dataAdr),
    .writeData(writeData),
    .memWrite(memWrite)
    );

//initialize
initial begin
    reset <= 1;
    #22 reset <=0;
end

//generate clock
initial begin
    clk = 0;
    forever begin
    #5 clk = ~clk;
    end
end

//check results
always @(negedge clk) begin
    if(memWrite) begin
        if(dataAdr === 100 && writeData === 25) begin
            $display("Simulation succeeded");
            $stop;
        end
        else if( dataAdr !== 96) begin
            $display("Simulation failed");
            $stop;
        end
    end
end



endmodule
