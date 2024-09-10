`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2024 04:42:31 PM
// Design Name: 
// Module Name: uart_rx
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


module uart_rx
#(parameter DBITS = 8 , // data bits 
            SB_TICK = 16 // stop bit ticks
)
(
input clk , reset_n ,  
input rx , s_ticks ,
output reg rx_done_ticks ,
output [DBITS - 1 : 0] rx_dout
);
localparam idle = 0 , start = 1 , data = 2 ,  stop = 3 ;
reg [1 : 0] state_reg , state_next ; 
reg [3 : 0] s_reg , s_next ;
reg [$clog2(DBITS) - 1 :0] n_reg , n_next ;
reg [DBITS - 1 : 0] b_reg , b_next ;
always @(posedge clk , negedge reset_n)
begin
if(~reset_n)
begin
state_reg <= idle ;
s_reg <= 0 ;
b_reg <= 0 ;
n_reg <= 0 ;
end
else
begin
state_reg <= state_next ;
s_reg <= s_next ;
b_reg <= b_next ;
n_reg <= n_next ;
end
end
always @(*)
begin
state_next = state_reg;
s_next = s_reg ; 
b_next = b_reg ; 
n_next = n_reg ;
rx_done_ticks = 1'b0 ;
case(state_reg)
idle : if(~rx)
        begin
        s_next = 0 ;
        state_next = start ;
        end
start : if(s_ticks)
          if(s_reg == 7)
          begin
          s_next = 0;
          n_next = 0;
          state_next = data ; 
          end   
          else
          s_next = s_reg + 1 ;
data : if(s_ticks)
          if(s_reg == 15)
          begin
          b_next = {rx , b_reg[DBITS - 1 : 1]} ;
          s_next = 0;
          if(n_reg == (DBITS - 1 ))
          state_next = stop;
          else
          n_next = n_reg + 1;
          end 
          else
          s_next = s_reg + 1 ;
stop : if(s_ticks)
          if(s_reg == SB_TICK - 1)
          begin
          rx_done_ticks = 1'b1;
          state_next = idle;
          end
          else
          s_next = s_reg +1 ; 
default : state_next  = idle ;         
             
endcase
end
assign rx_dout = b_reg ;
endmodule
