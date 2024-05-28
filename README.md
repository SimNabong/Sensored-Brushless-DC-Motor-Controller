# Sensored-Brushless-DC-Motor-Controller in Verilog
Using 3 inputs(labeled as UI[2:0] in the verilog code), this motor controller will allow a user to make an Sensored BLDC motor spin Clockwise, Counterclockwise, or regenerative brake using the high-side or the low-side power transistor.

This is the second version of my Sensored BLDC motor controller. The first version is purely hardware, which you could view in this video: https://www.youtube.com/watch?v=dUQjvkLtdNA
The main difference between this version and the previous version is the regenerative functions and the extra dead-time. The regenerative braking can be activated by turning UI[0] "on" or by turning UI[2] and UI[1] at the same time. UI[1] is for the clockwise spin and UI[2] is for the counterclockwise spin. The extra dead-time on the output signals ensure that none of the power transistors in the same bridge are "on" at the same time. The extra dead-time can be unjusted depending on the turn on/off delay of the power transistors being used. It could also be completely removed if the gate driver introduces the deadtime itself since some gate drivers has this capability. 

The Control Functions are:
  just UI[0] will regenerative brake using low-side of the 3-phase-bridge.
  just UI[1] will make the motor spin clockwise.
  just UI[2] will make the motor spin counterclockwise.
  UI[1] and UI[2] at the same time will regenerative brake using high-side of the 3-phase-bridge.
  other combination that wasnt previously mentioned will result in all of the output signal going "off" or is similar to not pressing anything. For example: if UI[0] and UI[1] and UI[2] are turned on at the same time, the motor will not do anything.(Ill use them for the next version of the motor controller maybe. I have other functions for the controller that I'm going to implement to make a sensored BLDC motor do more things ;)).

To program an CPLD(which is what im implementing this on) or an FPGA using this repo you first need to download the .qpf and .v files. Then open this in your design software and compile it. Once compiled, set your pins to your liking then go on your merry way of programming your programmable device.

