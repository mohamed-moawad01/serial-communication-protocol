`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2024 03:51:19 AM
// Design Name: 
// Module Name: SPI_SLAVE
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


module SPI_SLAVE(
input clk , rst_n ,
input MOSI , tx_valid , ss_n ,
input [7 : 0] tx_data ,
output reg MISO ,
output reg rx_valid ,
output  [9 : 0] rx_data 
    );
    integer k ;
    reg [7 : 0] data_reg , data_next ;
    reg [2 : 0] count_reg , count_next ;
    reg [2 : 0] state_reg , state_next ;
    localparam IDLE = 0 , CHK_CMD = 1 , WRITE = 2 , READ_ADD_CMD = 3 , READ_DATA = 4 ;  
    
    always @(posedge clk , negedge rst_n , posedge ss_n)
    begin
    if(~rst_n || ss_n)
    begin
    state_reg <= IDLE ;
    
    data_reg <= 0 ;
    
    count_reg <= 0 ;
    end
    
    else
    begin
    state_reg <= state_next ;
    
    data_reg <= data_next ;
    
    count_reg <= count_next ;
    end
    end
    
    always @(*)
    begin
    state_next = state_reg ;
    
    data_next = data_reg ;
    
    count_next = count_reg ;
    case(state_reg)
    
    IDLE : begin 
           count_next = 0 ;
           if(~ss_n)
           state_next = CHK_CMD ;
           end
        
    CHK_CMD : if(~ss_n) 
               begin
               if(~MOSI)
              state_next = WRITE ;
              else if(tx_valid)
              state_next = READ_DATA ;
              else
              state_next = READ_ADD_CMD ;
              end  
              else
              state_next = IDLE ;       
   
    WRITE : if(count_reg == 9)   
             begin
             rx_valid = 1'b1 ;
             
             state_next = IDLE ;
             
             end
             else
             begin
             data_next = {MOSI,data_next[7 : 1]} ;
             count_next = count_reg + 1 ;
             rx_valid = 1'b0;
             end
             
    READ_ADD_CMD : if(count_reg == 9)   
               begin
               rx_valid = 1'b1 ;
               
               state_next = IDLE ;
             
               end
               else
               begin
               data_next = {MOSI,data_next[7 : 1]} ;
               count_next = count_reg + 1 ;
               rx_valid = 1'b0;
               end  
                
   READ_DATA : begin
               rx_valid = 1'b0 ;
               for(k = 7 ; k >= 0  ; k = k-1)
               begin
               MISO = tx_data[k];
               end 
               if(MISO == 1'bx)
               state_next = IDLE ;
               end
    endcase
    end
    
    assign rx_data = data_reg ; 
endmodule
