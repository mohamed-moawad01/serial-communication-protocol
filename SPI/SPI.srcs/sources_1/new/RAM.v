`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2024 04:59:07 PM
// Design Name: 
// Module Name: RAM
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


module RAM
#(parameter ADDR_WIDTH = 8 , DATA_WIDTH = 10)(
input clk , rst_n , rx_valid ,
input [DATA_WIDTH - 1 : 0] din , 
output reg tx_valid ,
output reg [DATA_WIDTH - 3 :  0] dout
    );
    
    reg [DATA_WIDTH - 3  : 0] RAM [0 : 2**ADDR_WIDTH - 1];
    reg [ADDR_WIDTH - 1 : 0] address_in ;
    reg [ADDR_WIDTH - 1 : 0] address_out ;
    reg [DATA_WIDTH - 3 : 0] data ;
    always @(posedge clk , negedge rst_n)
    begin
    if(~rst_n)
    begin
    address_in  <= 0 ;
    address_out  <= 0 ;
    data <= 0 ;
    end
    else
    begin
    if(rx_valid)
    RAM[address_in] <= data  ;
    dout <= RAM[address_out] ;
    end
    end
    always @(*)
    begin
    casex(din)
    10'b00xx_xxxx_xx : begin 
                       if(rx_valid)
                       address_in = din[7 : 0] ;
                       tx_valid = 1'b0 ;
                       end
    10'b01xx_xxxx_xx : begin
                       if(rx_valid)
                       data = din[7 : 0] ;
                       tx_valid = 1'b0 ;
                       end
    10'b10xx_xxxx_xx : begin 
                       if(rx_valid)
                       address_out = din[7 : 0] ;
                       tx_valid = 1'b0 ;
                       end
    10'b11xx_xxxx_xx :  tx_valid = 1'b1;
    
    
    endcase
    end
endmodule
