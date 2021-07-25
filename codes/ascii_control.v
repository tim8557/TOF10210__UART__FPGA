module ascii_control(clk, rst, pi_data, pi_sig, data_dis);
input clk, rst;
input pi_sig;
input [7:0] pi_data;
output reg [19:0] data_dis;

reg [3:0] cnt_num;
reg [15:0] data_reg;
reg clear_sig;
reg data_en;
reg [3:0] data_trans;
reg [3:0] data_num;
reg [19:0] data_sum;
reg [3:0] state;
reg sum_out_sig;


//clear_sig
always@(posedge clk or posedge rst)
if (rst)
clear_sig <= 1'b0;
else if (data_en == 1'b1)
clear_sig <= 1'b1;
else 
clear_sig <= 1'b0;

always@(posedge clk or posedge rst)
if (rst)
data_en <= 1'b0;
else if (pi_sig == 1'b1)
data_en <= 1'b1;
else 
data_en <= 1'b0;

//data_reg
always@(posedge clk or posedge rst)
if (rst)
data_reg <= 8'd0;
else if (pi_sig == 1'b1)
data_reg <= pi_data;
else 
data_reg <= data_reg;


//data_num
always@(posedge clk or posedge rst)
if (rst)
data_num <= 4'd0;
else if (clear_sig == 1'b1 && data_num == 4'd7)
data_num <= 4'd0;
else if (pi_sig == 1'b1)
data_num <= data_num + 1'b1;

//data_trans
always@(posedge clk or posedge rst)
if (rst)
data_trans <= 4'd0;
else if (data_en == 1'b1 && data_num == 4'd0)
data_trans <= 4'd0;
else if (data_en == 1'b1 && data_num == 4'd4)
data_trans <= 4'd0;
else if (data_en == 1'b1 && data_num == 4'd5)
data_trans <= 4'd0;
else if (data_en == 1'b1 && data_num == 4'd6)
data_trans <= 4'd0;
else if (data_en == 1'b1 && data_num == 4'd7)
data_trans <= 4'd0;
else if (data_en == 1'b1 && data_num == 4'd1)
data_trans <= pi_data[3:0];
else if (data_en == 1'b1 && data_num == 4'd2)
data_trans <= pi_data[3:0];
else if (data_en == 1'b1 && data_num == 4'd3)
data_trans <= pi_data[3:0];


//data_sum
always@(posedge clk or posedge rst)
if (rst)
data_sum <= 20'd0;
else if (clear_sig == 1'b1 && data_num == 4'd1)
data_sum <= data_trans*20'd100;
else if (clear_sig == 1'b1 && data_num == 4'd2)
data_sum <= data_sum + data_trans*20'd10;
else if (clear_sig == 1'b1 && data_num == 4'd3)
data_sum <= data_sum + data_trans*20'd1;
else if (clear_sig == 1'b1 && data_num == 4'd5)
data_sum <= 20'd0;

//sum_out_sig
always@(posedge clk or posedge rst)
if (rst)
sum_out_sig <= 1'b0;
else if (data_num == 4'd4 && data_en == 1'b1)
sum_out_sig <= 1'b1;
else 
sum_out_sig <= 1'b0;


//data_dis
always@(posedge clk or posedge rst)
if (rst)
data_dis <= 20'd0;
else if (sum_out_sig == 1'b1)
data_dis <= data_sum;
else 
data_dis <= data_dis;

endmodule
