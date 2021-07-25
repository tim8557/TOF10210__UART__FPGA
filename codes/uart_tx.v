module uart_tx
#(
parameter UART_BPS = 'd9600,
parameter clk_fre  = 'd50_000_000
)
(
input clk,
input rst,
input [7:0] pi_data,
input pi_sig,
output reg tx
);

parameter BAUD_CNT_MAX = clk_fre/UART_BPS;

reg work_en;
reg [15:0] baud_cnt;
reg bit_sig;
reg [3:0] bit_cnt;

always@(posedge clk or posedge rst)
if (rst)
work_en <= 1'b0;
else if (pi_sig == 1'b1)
work_en <= 1'b1;
else if (bit_cnt == 4'd9 && bit_sig == 1'b1)
work_en <= 1'b0;

//baud_cnt
always@(posedge clk or posedge rst)
if (rst)
baud_cnt <= 16'd0;
else if (work_en == 1'b0 || baud_cnt == BAUD_CNT_MAX-1)
baud_cnt <= 16'd0;
else if (work_en == 1'b1)
baud_cnt <= baud_cnt + 1'b1;

//bit_sig
always@(posedge clk or posedge rst)
if (rst)
bit_sig <= 1'b0;
else if (baud_cnt == 16'd1)
bit_sig <= 1'b1;
else
bit_sig <= 1'b0;

//bit_cnt
always@(posedge clk or posedge rst)
if (rst)
bit_cnt <= 4'd0;
else if (bit_cnt == 4'd9 && bit_sig == 1'b1)
bit_cnt <= 4'd0;
else if (work_en == 1'b1 && bit_sig == 1'b1)
bit_cnt <= bit_cnt + 1'b1;


always@(posedge clk or posedge rst)
if (rst)
tx <= 1'b1;
else if (bit_sig == 1'b1)
case(bit_cnt)
0: tx <= 1'b0;
1: tx <= pi_data[0];
2: tx <= pi_data[1];
3: tx <= pi_data[2];
4: tx <= pi_data[3];
5: tx <= pi_data[4];
6: tx <= pi_data[5];
7: tx <= pi_data[6];
8: tx <= pi_data[7];
9: tx <= 1'b1;
default: tx <= 1'b1;
endcase

endmodule