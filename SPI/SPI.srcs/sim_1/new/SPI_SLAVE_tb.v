`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2024 12:17:03 PM
// Design Name: 
// Module Name: SPI_SLAVE_tb
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


module SPI_SLAVE_tb(

    );
    reg clk , rst_n , MOSI , tx_valid , ss_n ;
    reg [7 : 0] tx_data ;
    wire MISO , rx_valid ;
    wire [9 : 0] rx_data ;
    
    SPI_SLAVE UUT (clk , rst_n , MOSI ,tx_valid , ss_n , tx_data , MISO , rx_valid ,rx_data);
    always 
    begin
    clk = 0 ;
    #10 clk = 1;
    #10;
    end
    initial
    begin
    rst_n = 0;
    #2 rst_n = 1;
    tx_valid = 1'b1 ;
    tx_data = 8'b1010_1101;
    @(posedge clk)
    ss_n = 0;
    @(posedge clk)
    MOSI = 1 ;
    #(20*9) $finish;
    end
  
endmodule
