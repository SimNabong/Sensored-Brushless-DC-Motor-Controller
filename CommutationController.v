module CommutationControl(
	input clk,
	input [2:0]user_input, //user input
	input [2:0]hall_sensor, //Hall sensors 
	output [5:0]bridge_signal //6 Power Transistor control signals
);
	/*
	  user_input[0](Regen Break One) or user_input[1]&user_input[2](Regen Break Two)
	  user_input[1] is clockwise spin
	  user_input[2] is counter-cw spin
	  HS[0],HS[1],HS[2] are the HS sensor signals
	*/	
	
	wire Aw,Bw,Cw,Dw,Ew,Fw;
	reg [1:0]Ar = 2'd0;
	reg [1:0]Br = 2'd0;
	reg [1:0]Cr = 2'd0;
	reg [1:0]Dr = 2'd0;
	reg [1:0]Er = 2'd0;
	reg [1:0]Fr = 2'd0; //registers for delays


	assign Aw = ~hall_sensor[0]&hall_sensor[1]&user_input[0]&~user_input[2] | ~hall_sensor[0]&hall_sensor[1]&user_input[0]&~user_input[1] | ~hall_sensor[0]&hall_sensor[2]&user_input[0]&~user_input[1] | hall_sensor[0]&~hall_sensor[2]&user_input[0]&~user_input[2] | ~hall_sensor[1]&hall_sensor[2]&user_input[0]&~user_input[1] | ~hall_sensor[0]&hall_sensor[2]&user_input[0]&~user_input[2] | hall_sensor[0]&~hall_sensor[1]&user_input[0]&~user_input[1] | hall_sensor[0]&~hall_sensor[2]&user_input[1]&~user_input[2] | ~hall_sensor[0]&hall_sensor[2]&~user_input[1]&user_input[2] | ~hall_sensor[1]&hall_sensor[2]&user_input[0]&~user_input[2] | hall_sensor[1]&~hall_sensor[2]&user_input[0]&~user_input[2] | hall_sensor[0]&~hall_sensor[1]&user_input[0]&~user_input[2] | hall_sensor[1]&~hall_sensor[2]&user_input[0]&~user_input[1] | hall_sensor[0]&~hall_sensor[2]&user_input[0]&~user_input[1];
	
	assign Bw = ~hall_sensor[0]&hall_sensor[2]&user_input[1]&user_input[2] | hall_sensor[0]&~hall_sensor[2]&user_input[1]&user_input[2] | ~hall_sensor[1]&hall_sensor[2]&user_input[1]&user_input[2] | hall_sensor[0]&~hall_sensor[1]&user_input[1]&user_input[2] | hall_sensor[1]&~hall_sensor[2]&user_input[1]&user_input[2] | hall_sensor[0]&~hall_sensor[2]&~user_input[0]&user_input[2] | ~hall_sensor[0]&hall_sensor[1]&user_input[1]&user_input[2] | ~hall_sensor[0]&hall_sensor[2]&~user_input[0]&user_input[1];
	
	assign Cw = ~hall_sensor[1]&hall_sensor[2]&user_input[0]&~user_input[2] | ~hall_sensor[0]&hall_sensor[2]&user_input[0]&~user_input[1] | ~hall_sensor[1]&hall_sensor[2]&user_input[0]&~user_input[1] | hall_sensor[0]&~hall_sensor[2]&user_input[0]&~user_input[1] | hall_sensor[0]&~hall_sensor[1]&user_input[0]&~user_input[2] | ~hall_sensor[0]&hall_sensor[1]&user_input[0]&~user_input[1] | ~hall_sensor[0]&hall_sensor[1]&user_input[0]&~user_input[2] | ~hall_sensor[1]&hall_sensor[2]&user_input[1]&~user_input[2] | hall_sensor[1]&~hall_sensor[2]&user_input[0]&~user_input[2] | hall_sensor[1]&~hall_sensor[2]&~user_input[1]&user_input[2] | hall_sensor[1]&~hall_sensor[2]&user_input[0]&~user_input[1] | hall_sensor[0]&~hall_sensor[1]&user_input[0]&~user_input[1] | hall_sensor[0]&~hall_sensor[2]&user_input[0]&~user_input[2] | ~hall_sensor[0]&hall_sensor[2]&user_input[0]&~user_input[2];
	
	assign Dw = ~hall_sensor[1]&hall_sensor[2]&~user_input[0]&user_input[2] | ~hall_sensor[0]&hall_sensor[2]&user_input[1]&user_input[2] | ~hall_sensor[0]&hall_sensor[1]&user_input[1]&user_input[2] | hall_sensor[1]&~hall_sensor[2]&user_input[1]&user_input[2] | ~hall_sensor[1]&hall_sensor[2]&user_input[1]&user_input[2] | hall_sensor[0]&~hall_sensor[1]&user_input[1]&user_input[2] | hall_sensor[1]&~hall_sensor[2]&~user_input[0]&user_input[1] | hall_sensor[0]&~hall_sensor[2]&user_input[1]&user_input[2];
	
	assign Ew = hall_sensor[0]&~hall_sensor[2]&user_input[0]&~user_input[2] | hall_sensor[0]&~hall_sensor[1]&user_input[0]&~user_input[2] | hall_sensor[1]&~hall_sensor[2]&user_input[0]&~user_input[2] | ~hall_sensor[0]&hall_sensor[1]&user_input[0]&~user_input[2] | ~hall_sensor[1]&hall_sensor[2]&user_input[0]&~user_input[1] | hall_sensor[1]&~hall_sensor[2]&user_input[0]&~user_input[1] | hall_sensor[0]&~hall_sensor[1]&~user_input[1]&user_input[2] | ~hall_sensor[0]&hall_sensor[2]&user_input[0]&~user_input[2] | hall_sensor[0]&~hall_sensor[1]&user_input[0]&~user_input[1] | hall_sensor[0]&~hall_sensor[2]&user_input[0]&~user_input[1] | ~hall_sensor[1]&hall_sensor[2]&user_input[0]&~user_input[2] | ~hall_sensor[0]&hall_sensor[1]&user_input[0]&~user_input[1] | ~hall_sensor[0]&hall_sensor[1]&user_input[1]&~user_input[2] | ~hall_sensor[0]&hall_sensor[2]&user_input[0]&~user_input[1];
	
	assign Fw = hall_sensor[0]&~hall_sensor[2]&user_input[1]&user_input[2] | hall_sensor[1]&~hall_sensor[2]&user_input[1]&user_input[2] | ~hall_sensor[0]&hall_sensor[2]&user_input[1]&user_input[2] | ~hall_sensor[1]&hall_sensor[2]&user_input[1]&user_input[2] | ~hall_sensor[0]&hall_sensor[1]&user_input[1]&user_input[2] | ~hall_sensor[0]&hall_sensor[1]&~user_input[0]&user_input[2] | hall_sensor[0]&~hall_sensor[1]&~user_input[0]&user_input[1] | hall_sensor[0]&~hall_sensor[1]&user_input[1]&user_input[2];
	
	
	/*
	introduces a dead-time that prevents power transistors in the same bridge from being on at the same time, because if they did then that would cause a short in  the battery. This part however can be removed if the gate drivers has this capability. This dead-time needs to be adjusted based on the turn off/on delay of the power trans used.
	*/
	always@(posedge clk)begin 
	
		Ar[0] <= Aw&~Br[1];
		Ar[1] <= Ar[0]; 
		Br[0] <= Bw&~Ar[1]; 
		Br[1] <= Br[0];
		
		
		Cr[0] <= Cw&~Dr[1];
		Cr[1] <= Cr[0];
		Dr[0] <= Dw&~Cr[1];
		Dr[1] <= Dr[0];
		
		Er[0] <= Ew&~Fr[1];
		Er[1] <= Er[0];
		Fr[0] <= Fw&~Er[1];
		Fr[1] <= Fr[0];		
		
	end
	

	assign bridge_signal = {Ar[1],Br[1],Cr[1],Dr[1],Er[1],Fr[1]};



endmodule
