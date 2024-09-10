`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2024 05:47:13 PM
// Design Name: 
// Module Name: RAM_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RAM_tb(

    );
    reg clk , rst_n , rx_valid ;
    reg [9 : 0] din ; 
    wire  tx_valid ;
    wire [7 :  0] dout ;
    localparam T  = 10;
    always 
    begin
    clk = 1'b0; 
    #T clk = 1'b1;
    #T ;
    end
    RAM UUT0 
    (
    clk , rst_n , rx_valid , din , tx_valid , dout
    );
    initial
    begin
    rx_valid = 1'b1;
    rst_n = 1'b1 ;
    @(posedge clk)
    din = 10'b0000000001;
    @(posedge clk)
    din = 10'b0100001101;
    @(posedge clk)
    din = 10'b1000000001;
    @(posedge clk)
    din = 10'b1100000001;
    @(posedge clk)
    din = 10'b0000001001;
    @(posedge clk)
    din = 10'b0100001111;
    @(posedge clk)
    din = 10'b1000001001;
    @(posedge clk)
    din = 10'b1100001001;
    @(posedge clk)
    din = 10'b0000000001;
    @(posedge clk)
    din = 10'b0101101101;
    @(posedge clk)
    din = 10'b1000000001;
    @(posedge clk)
    din = 10'b1100000001;
    
    #30 $stop ;
    
    end
endmodule
