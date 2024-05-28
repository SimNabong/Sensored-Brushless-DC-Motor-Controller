`timescale 1ns/1ps

module CommutationControl_testbench();
	reg clk;
	reg [2:0]UI;
	reg [2:0]HS;
	wire [5:0]PT;
	
	CommutationControl stbinst(.clk(clk), .UI(UI), .HS(HS), .PT(PT));
	
	  // Initialize the inputs and generate the clock signal
  initial begin
    clk = 0; // Set the clock input to 0
    forever #1 clk = ~clk; // Toggle the clock every T/2 units of time
  end
	
	initial begin
		UI[2:0] = 3'b000;
		HS = 3'd0;
		
		
		 //all off except the HS sensors
		#5 UI[2:0]=3'b000;HS=3'b100; //state 1
		#5 UI[2:0]=3'b000;HS=3'b110; //state 2
		#5 UI[2:0]=3'b000;HS=3'b010; //state 3
		#5 UI[2:0]=3'b000;HS=3'b011; //state 4
		#5 UI[2:0]=3'b000;HS=3'b001; //state 5
		#5 UI[2:0]=3'b000;HS=3'b101; //state 6
		
		 // ccw on with HS sensors
		#5 UI[2:0]=3'b010;HS=3'b101; //state 6
		#5 UI[2:0]=3'b010;HS=3'b100; //state 1
		#5 UI[2:0]=3'b010;HS=3'b110; //state 2
		#5 UI[2:0]=3'b010;HS=3'b010; //state 3
		#5 UI[2:0]=3'b010;HS=3'b011; //state 4
		#5 UI[2:0]=3'b010;HS=3'b001; //state 5
		#5 UI[2:0]=3'b010;HS=3'b101; //state 6
		
		
		#5 UI[2:0]=3'b000;HS=3'b101; //state 6 with all off
		
		// cw on with HS sensors
		#5 UI[2:0]=3'b100;HS=3'b101; //state 6
		#5 UI[2:0]=3'b100;HS=3'b001; //state 5
		#5 UI[2:0]=3'b100;HS=3'b011; //state 4
		#5 UI[2:0]=3'b100;HS=3'b010; //state 3
		#5 UI[2:0]=3'b100;HS=3'b110; //state 2
		#5 UI[2:0]=3'b100;HS=3'b100; //state 1
		
		// Regen Break Two(cw and ccw) on with HS sensors
		#5 UI[2:0]=3'b110;HS=3'b101; //state 6
		#5 UI[2:0]=3'b110;HS=3'b001; //state 5
		#5 UI[2:0]=3'b110;HS=3'b011; //state 4
		#5 UI[2:0]=3'b110;HS=3'b010; //state 3
		#5 UI[2:0]=3'b110;HS=3'b110; //state 2
		#5 UI[2:0]=3'b110;HS=3'b100; //state 1
		

		#5 UI[2:0]=3'b001;HS=3'b100; //state 1
		
		//Regen Break One on with HS sensors
		#5 UI[2:0]=3'b001;HS=3'b100; //state 1
		#5 UI[2:0]=3'b001;HS=3'b110; //state 2
		#5 UI[2:0]=3'b001;HS=3'b010; //state 3
		#5 UI[2:0]=3'b001;HS=3'b011; //state 4
		#5 UI[2:0]=3'b001;HS=3'b001; //state 5
		#5 UI[2:0]=3'b001;HS=3'b101; //state 6
		
		//regen break and cw and ccw on with HS sensors should all output off
		#5 UI[2:0]=3'b111;HS=3'b100; //state 1
		#5 UI[2:0]=3'b111;HS=3'b110; //state 2
		#5 UI[2:0]=3'b111;HS=3'b010; //state 3
		#5 UI[2:0]=3'b111;HS=3'b011; //state 4
		#5 UI[2:0]=3'b111;HS=3'b001; //state 5
		#5 UI[2:0]=3'b111;HS=3'b101; //state 6
		
		#5 UI[2:0]=3'b101;HS=3'b100; //state 1
		#5 UI[2:0]=3'b101;HS=3'b110; //state 2
		#5 UI[2:0]=3'b101;HS=3'b010; //state 3
		#5 UI[2:0]=3'b101;HS=3'b011; //state 4
		#5 UI[2:0]=3'b101;HS=3'b001; //state 5
		#5 UI[2:0]=3'b101;HS=3'b101; //state 6
		
		#0 $finish;
										
		
	end
	
	
	initial begin
		$monitor("simtime=%g, clk=%b, UI=%b, HS%b, PT=%b", $time, clk,UI,HS,PT);
	end
	
endmodule