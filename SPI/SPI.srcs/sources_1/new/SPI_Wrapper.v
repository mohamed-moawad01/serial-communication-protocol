`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2024 02:52:30 PM
// Design Name: 
// Module Name: SPI_Wrapper
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


module SPI_Wrapper
#(parameter ADDR_WIDTH = 8 , DATA_WIDTH = 10)
(
input MOSI, ss_n , clk , rst_n ,
output MISO
);

wire rx_valid , tx_valid ;
wire [9 : 0] rx_data ;
wire [7 : 0] tx_data ;
SPI_SLAVE SPI_SLAVE 
                   (
                   .MOSI(MOSI) , 
                   .clk(clk) ,
                   .rst_n(rst_n) ,
                   .tx_data(tx_data) ,
                   .tx_valid(tx_valid) , 
                   .rx_data(rx_data) , 
                   .rx_valid(rx_valid) ,
                   .ss_n(ss_n) , 
                   .MISO (MISO) 
                   
                   );

RAM #(.ADDR_WIDTH(ADDR_WIDTH) , .DATA_WIDTH (DATA_WIDTH))RAM
                   (
                   .din(rx_data) ,
                   .rx_valid(rx_valid) ,
                   .dout(tx_data) , 
                   .tx_valid(tx_valid) ,
                   .clk(clk) , 
                   .rst_n(rst_n)
                   );
                       


endmodule
