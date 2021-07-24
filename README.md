# TOF10210__UART__FPGA

## TOF10210 
TOF10210 is a laser range sensor module. It's measurement distance is from 10 cm to 180 cm. We can
use UART or I2C interface to communicate with FPGA.<br>
<br>
<img src="https://github.com/tim8557/TOF10210__UART__FPGA/blob/main/images/sensor_photo.jpg" width="200" ><br>

## UART communication protocal
We used UART communication protocal to communicate with FPGA. The picture shows the time sequence when we<br>
use the TOF10210.<br>

### The rx_module
The rx_module is used to receive the serial communication data from TOF10210 and transfer it into parallel<br>
communication data. The picture is the input and output ports of rx_module.<br>
<br>
<img src="https://github.com/tim8557/TOF10210__UART__FPGA/blob/main/images/rx_module.JPG" width="400" ><br>
<br>
### The time sequence of rx_module
The picture is the time sequence of rx_module.<br>
<br>
**clk:** clock frequency<br>
**rst:** reset signal<br>
**rx:** serial comunication data<br>
**rx_sync1:** to avoid metastable<br>

![image](https://github.com/tim8557/TOF10210__UART__FPGA/blob/main/images/rx_time_sequence_2.JPG)<br>
