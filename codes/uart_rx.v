module uart_rx
#(
parameter UART_BPS = 'd9600,
parameter clk_fre  = 'd50_000_000
)
(
input clk,
input rst,
input rx,
output reg [7:0] po_data,
output reg po_sig
);

parameter BAUD_CNT_MAX = clk_fre/UART_BPS;

reg rx_reg1;
reg rx_reg2;
reg rx_reg3;
reg start_sig;
reg work_en;
reg [15:0] baud_cnt;
reg bit_sig;
reg [3:0] bit_cnt;
reg [7:0] rx_data;
reg rx_sig;

always@(posedge clk or posedge rst)
if (rst)
rx_reg1 <= 1'b1;
else 
rx_reg1 <= rx;

always@(posedge clk or posedge rst)
if (rst)
rx_reg2 <= 1'b1;
else 
rx_reg2 <= rx_reg1;

always@(posedge clk or posedge rst)
if (rst)
rx_reg3 <= 1'b1;
else 
rx_reg3 <= rx_reg2;

always@(posedge clk or posedge rst)
if (rst)
start_sig <= 1'b0;
else if (rx_reg2 == 1'b0 && rx_reg3 == 1'b1 && work_en == 1'b0)
start_sig <= 1'b1;
else 
start_sig <= 1'b0;

//work_en
always@(posedge clk or posedge rst)
if (rst)
work_en <= 1'b0;
else if (start_sig == 1'b1)
work_en <= 1'b1;
else if (bit_cnt == 4'd8 && bit_sig == 1'b1)
work_en <= 1'b0;
else 
work_en <= work_en;

//baud_cnt
always@(posedge clk or posedge rst)
if (rst)
baud_cnt <= 16'd0;
else if ((baud_cnt == BAUD_CNT_MAX - 1)|| (work_en == 1'b0))
baud_cnt <= 16'd0;
else if (work_en == 1'b1)
baud_cnt <= baud_cnt + 1'b1;
else 
baud_cnt <= baud_cnt;

//bit_sig 
always@(posedge clk or posedge rst)
if (rst)
bit_sig <= 1'b0;
else if (baud_cnt == BAUD_CNT_MAX/2 -1)
bit_sig <= 1'b1;
else 
bit_sig <= 1'b0;

//bit_cnt
always@(posedge clk or posedge rst)
if (rst)
bit_cnt <= 4'd0;
else if (bit_cnt == 4'd8 && bit_sig == 1'b1)
bit_cnt <= 4'd0;
else if (bit_sig == 1'b1)
bit_cnt <= bit_cnt + 1'b1;
else 
bit_cnt <= bit_cnt;

//
always@(posedge clk or posedge rst)
if (rst)
rx_data <= 8'b0;
else if ((bit_cnt >= 4'd1) && (bit_cnt <= 4'd8) && (bit_sig == 1'b1))
rx_data <= {rx_reg3,rx_data[7:1]};

always@(posedge clk or posedge rst)
if (rst)
rx_sig <= 1'b0;
else if (bit_cnt == 4'd8 && bit_sig == 1'b1)
rx_sig <= 1'b1;
else 
rx_sig <= 1'b0;

//output data
always@(posedge clk or posedge rst)
if (rst)
po_data <= 8'b0;
else if (rx_sig == 1'b1)
po_data <= rx_data;

//output signal
always@(posedge clk or posedge rst)
if (rst)
po_sig <= 1'b0;
else
po_sig <= rx_sig;

endmodule