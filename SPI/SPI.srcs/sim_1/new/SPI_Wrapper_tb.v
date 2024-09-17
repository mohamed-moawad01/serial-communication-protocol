`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2024 10:20:20 AM
// Design Name: 
// Module Name: SPI_Wrapper_tb
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


module SPI_Wrapper_tb(

    );
    localparam ADDR_WIDTH = 8 , DATA_WIDTH = 10;
    reg MOSI, ss_n , clk , rst_n ;
    wire MISO ;
    SPI_Wrapper#(.ADDR_WIDTH(ADDR_WIDTH) , .DATA_WIDTH(DATA_WIDTH)) UUT0
     (
     .MOSI(MOSI),
     .ss_n(ss_n),
     .clk(clk),
     .rst_n(rst_n),
     .MISO(MISO)
     );
     
     always 
     begin
     clk = 1'b0;
     #4 clk = 1'b1;
     #4;
     end
     
     
     initial
     begin
     
     rst_n = 0;
     ss_n = 1;
     #2 rst_n = 1;
     @(posedge clk)
     ss_n = 0;
     @(posedge clk)
     MOSI = 0 ;
     /*write_addr*/
     @(posedge clk)
     MOSI = 0 ;
     @(posedge clk)
     MOSI = 0 ;
     @(posedge clk)
     MOSI = 0;
     @(posedge clk)
     MOSI = 0 ;
     @(posedge clk)
     MOSI = 0 ;
     @(posedge clk)
     MOSI = 0 ;
     @(posedge clk)
     MOSI = 0 ;
     @(posedge clk)
     MOSI = 0 ;
     @(posedge clk)
     MOSI = 0 ;
     @(posedge clk)
     MOSI = 1 ;
     @(posedge clk);
     /*return_IDLE*/
     @(posedge clk) ss_n = 1;
     /*restart*/
     @(posedge clk) ss_n = 0;
     @(posedge clk) MOSI = 0;
     /*data_in*/
     @(posedge clk)
     MOSI = 0 ;
     @(posedge clk)
     MOSI = 1 ;
     @(posedge clk)
     MOSI = 0;
     @(posedge clk)
     MOSI = 0 ;
     @(posedge clk)
     MOSI = 0 ;
     @(posedge clk)
     MOSI = 0 ;
     @(posedge clk)
     MOSI = 0 ;
     @(posedge clk)
     MOSI = 1 ;
     @(posedge clk)
     MOSI = 0 ;
     @(posedge clk)
     MOSI = 1 ;
     @(posedge clk);
     /*return_IDLE*/
     @(posedge clk) ss_n = 1;
     /*restart*/
     @(posedge clk) ss_n = 0;
     @(posedge clk) MOSI = 1;
     /*read_add*/
     @(posedge clk)
     MOSI = 1 ;
     @(posedge clk)
     MOSI = 0 ;
     @(posedge clk)
     MOSI = 0;
     @(posedge clk)
     MOSI = 0 ;
     @(posedge clk)
     MOSI = 0 ;
     @(posedge clk)
     MOSI = 0 ;
     @(posedge clk)
     MOSI = 0 ;
     @(posedge clk)
     MOSI = 0;
     @(posedge clk)
     MOSI = 0 ;
     @(posedge clk)
     MOSI = 1 ;
     repeat(2)@(posedge clk);
     /*return_IDLE*/
     @(posedge clk) ss_n = 1;
     /*restart*/
     @(posedge clk) ss_n = 0;
     @(posedge clk) MOSI = 1;
     /*read_CMD*/
     @(posedge clk)
     MOSI = 1 ;
     @(posedge clk)
     MOSI = 1 ;
     @(posedge clk)
     MOSI = 0;
     @(posedge clk)
     MOSI = 0 ;
     @(posedge clk)
     MOSI = 0 ;
     @(posedge clk)
     MOSI = 0 ;
     @(posedge clk)
     MOSI = 0 ;
     @(posedge clk)
     MOSI = 0;
     @(posedge clk)
     MOSI = 0 ;
     @(posedge clk)
     MOSI = 1 ;
     repeat(2)@(posedge clk);
     /*return_IDLE*/
     @(posedge clk) ss_n = 1;
     /*restart*/
     @(posedge clk) ss_n = 0;
     @(posedge clk) MOSI = 1;
     


     
     end
endmodule
