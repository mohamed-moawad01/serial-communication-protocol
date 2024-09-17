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
output reg [9 : 0] rx_data 
    );
 localparam IDLE = 0 , CHK_CMD = 1 , WRITE = 2  , READ_ADD = 3 , READ_DATA = 4;
 reg [9 : 0] data_reg , data_next ;
 reg [2 : 0] state_reg , state_next ;
 reg [3 : 0] count_reg , count_next ;
  always @(posedge clk , negedge rst_n )
  begin
  if(~rst_n)
  begin
  state_reg <= IDLE ;
  data_reg <= 0 ;
  count_reg <= 0 ;
  end
  else if(~ss_n)
  begin
  state_reg <= state_next ;
  data_reg <= data_next ;
  count_reg <= count_next ;
  end
  else
  state_reg <= IDLE;
  end
  always @(*)
  begin
   state_next = state_reg ;
  data_next = data_reg ;
  count_next = count_reg ;
  case(state_reg)
  IDLE : begin
         rx_valid = 0 ;
         count_next = 0 ;
         if(~ss_n)
         state_next = CHK_CMD ;
         end
  CHK_CMD : begin
            if(~ss_n)
            begin
            if(~MOSI)
            state_next = WRITE ;
            else if(tx_valid)
            state_next = READ_DATA ;
            else
            state_next = READ_ADD ;
            end
            else
            state_next = IDLE ;
            end
  WRITE : begin
          if(ss_n)
          state_next = IDLE ;
          else
          begin
          if(count_reg > 9)
          begin
          rx_valid = 1;
          state_next = IDLE ;
          rx_data = data_reg ;
          end
          else
          begin
          data_next = {data_reg[8 : 0], MOSI} ;
          count_next = count_reg + 1;
          end
          end
          end
  READ_ADD : begin
          if(ss_n)
          state_next = IDLE ;
          else
          begin
          if(count_reg > 9)
          begin
          rx_valid = 1;
          state_next = IDLE ;
          rx_data = data_reg ;
          end
          else
          begin
          data_next = {data_reg[8 : 0], MOSI} ;
          count_next = count_reg + 1;
          end
          end
          end 
  READ_DATA : begin
              if(ss_n)
              state_next = IDLE ;
              else
              if(count_reg > 7)
              state_next = IDLE ;
              else
              begin
              MISO = tx_data[count_reg];
              count_next = count_reg + 1;
              end
              
              end                             
  endcase
  end

  
endmodule
