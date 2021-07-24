# TOF10210__UART__FPGA

## TOF10210 
TOF10210 is a laser range sensor module. It's measurement distance is from 10 cm to 180 cm. We can
use UART or I2C interface to communicate with FPGA.<br>
<br>
<img src="https://github.com/tim8557/TOF10210__UART__FPGA/blob/main/images/sensor_photo.jpg" width="200" ><br>

## UART communication protocal
### The Baud rate
The baud rate in our project is 9600 bps. The time interval between each bit is 104.17 us. We used the counter to<br>
count the number of bit with the clock frequency of 50 MHz. The counter needed to reset when we count to 5207.
CNT_MAX is the number that counter need to be reset.
CNT_MAX = (1/(baud rate))*49999999

### The rx_module
The rx_module is used to receive the serial communication data from TOF10210 and transfer it into parallel<br>
communication data. The picture is the input and output ports of rx_module.<br>
<br>
<img src="https://github.com/tim8557/TOF10210__UART__FPGA/blob/main/images/rx_module.JPG" width="400" ><br>
<br>
### The time sequence of rx_module
The picture is the time sequence of rx_module. The description of the parameters is below.<br>
<br>
**clk:** clock frequency<br>
**rst:** reset signal<br>
**rx:** serial comunication data<br>
**rx_sync1:** to avoid metastable<br>
**rx_sync2:** to avoid metastable<br>
**rx_sync3:** to generate the start signal at the falling edge of rx_sync2<br>
**start_sig:** the signal to start the data transformation<br>
**baud_cnt:** count the time interval between each bit<br>
**bit_sig:** this signal is used to sample the input data rx<br>
**bit_cnt:** count the number of bits<br>
**data:** store the rx data into register<br>
**rx_sig:** the finish signal of the data transformation<br>
**po_sig:** output the finish signal
**po_data:** output the processed data<br>
<br>
![image](https://github.com/tim8557/TOF10210__UART__FPGA/blob/main/images/rx_time_sequence_2.JPG)<br>
