module tof1021
(
input clk,
input rst,
input rx,
output tx,
output [7:0] seg0, 
output [7:0] seg1, 
output [7:0] seg2, 
output [7:0] seg3, 
output [7:0] seg4,
output [7:0] seg5
);

parameter clk_fre = 50_000_000;

wire [7:0] rx_data;
wire [7:0] tx_data;
wire rx_sig;
wire tx_sig;
wire [19:0] data_bcd; 
wire [3:0] unit;
wire [3:0] ten;
wire [3:0] hun;
wire [3:0] thou;
wire [3:0] ten_thou;
wire [3:0] hun_thou;


uart_rx
#(
.UART_BPS(9600),
.clk_fre(50_000_000)
)
rx1
(
.clk(clk),
.rst(rst),
.rx(rx),
.po_data(rx_data),
.po_sig(rx_sig)
);

uart_tx
#(
.UART_BPS(9600),
.clk_fre(50_000_000)
)
tx1
(
.clk(clk),
.rst(rst),
.pi_data(tx_data),
.pi_sig(tx_sig),
.tx(tx)
);

ascii_control ascii_control_inst
(
.clk(clk), 
.rst(rst), 
.pi_data(rx_data), 
.pi_sig(rx_sig), 
.data_dis(data_bcd)
);

bcd_8421 bcd1(
.clk(clk), 
.rst(rst_deb),
.data(data_bcd), 
.unit(unit), 
.ten(ten), 
.hun(hun),
.thou(thou),
.ten_thou(ten_thou), 
.hun_thou(hun_thou)
);

seven_seg s0(
.en(1'b1),
.in(unit), 
.seg(seg0));
				 
				 
seven_seg_dot s1(
.en(1'b1),
.in(ten), 
.seg(seg1));

seven_seg s2(
.en(1'b1),
.in(hun), 
.seg(seg2));

seven_seg s3(
.en(1'b1),
.in(thou), 
.seg(seg3));

seven_seg s4(
.en(1'b1),
.in(ten_thou), 
.seg(seg4));

seven_seg s5(
.en(1'b1),
.in(hun_thou), 
.seg(seg5));

endmodule 