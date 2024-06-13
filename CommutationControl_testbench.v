`timescale 1ns/1ps

module CommutationControl_testbench();
	reg clk;
	reg [2:0] user_input;
	reg [2:0] hall_sensor;
	wire [5:0] bridge_signal;
	
	CommutationControl stbinst(.clk(clk), .user_input(user_input), .hall_sensor(hall_sensor), .bridge_signal(bridge_signal));
	
	  // Initialize the inputs and generate the clock signal
	initial begin
		clk = 0; // Set the clock input to 0
		forever #1 clk = ~clk; // Toggle the clock every T/2 units of time
  	end	
	initial begin
		user_input[2:0] = 3'b000;
		hall_sensor = 3'd0;
			
		 //all off excebridge_signal the hall_sensor sensors
		#5 user_input[2:0] = 3'b000; hall_sensor = 3'b100; //state 1
		#5 hall_sensor = 3'b110; //state 2
		#5 hall_sensor = 3'b010; //state 3
		#5 hall_sensor = 3'b011; //state 4
		#5 hall_sensor = 3'b001; //state 5
		#5 hall_sensor = 3'b101; //state 6
		
		 // ccw on with hall_sensor sensors
		#5 user_input[2:0] = 3'b010; hall_sensor = 3'b101; //state 6
		#5 hall_sensor = 3'b100; //state 1
		#5 hall_sensor = 3'b110; //state 2
		#5 hall_sensor = 3'b010; //state 3
		#5 hall_sensor = 3'b011; //state 4
		#5 hall_sensor = 3'b001; //state 5
		#5 hall_sensor = 3'b101; //state 6
		
		#5 user_input[2:0] = 3'b000; hall_sensor = 3'b101; //state 6 with all off
		
		// cw on with hall_sensor sensors
		#5 user_input[2:0] = 3'b100; hall_sensor = 3'b101; //state 6
		#5 hall_sensor = 3'b001; //state 5
		#5 hall_sensor = 3'b011; //state 4
		#5 hall_sensor = 3'b010; //state 3
		#5 hall_sensor = 3'b110; //state 2
		#5 hall_sensor = 3'b100; //state 1
		
		// Regen Break Two(cw and ccw) on with hall_sensor sensors
		#5 user_input[2:0] = 3'b110; hall_sensor = 3'b101; //state 6
		#5 hall_sensor = 3'b001; //state 5
		#5 hall_sensor = 3'b011; //state 4
		#5 hall_sensor = 3'b010; //state 3
		#5 hall_sensor = 3'b110; //state 2
		#5 hall_sensor = 3'b100; //state 1
		
		#5 user_input[2:0] = 3'b000; hall_sensor = 3'b100; //state 1
		
		//Regen Break One on with hall_sensor sensors
		#5 user_input[2:0] = 3'b001; hall_sensor = 3'b100; //state 1
		#5 hall_sensor = 3'b110; //state 2
		#5 hall_sensor = 3'b010; //state 3
		#5 hall_sensor = 3'b011; //state 4
		#5 hall_sensor = 3'b001; //state 5
		#5 hall_sensor = 3'b101; //state 6
		
		//regen break and cw and ccw on with hall_sensor sensors should output all off
		#5 user_input[2:0] = 3'b111; hall_sensor = 3'b100; //state 1
		#5 hall_sensor = 3'b110; //state 2
		#5 hall_sensor = 3'b010; //state 3
		#5 hall_sensor = 3'b011; //state 4
		#5 hall_sensor = 3'b001; //state 5
		#5 hall_sensor = 3'b101; //state 6
		
		#5 user_input[2:0] = 3'b101; hall_sensor = 3'b100; //state 1
		#5 hall_sensor = 3'b110; //state 2
		#5 hall_sensor = 3'b010; //state 3
		#5 hall_sensor = 3'b011; //state 4
		#5 hall_sensor = 3'b001; //state 5
		#5 hall_sensor = 3'b101; //state 6
		
		#0 $finish;
	end
	
	initial begin
		$monitor("simtime=%g, clk=%b, user_input=%b, hall_sensor%b, bridge_signal=%b", $time, clk,user_input,hall_sensor,bridge_signal);
	end
	
endmodule
