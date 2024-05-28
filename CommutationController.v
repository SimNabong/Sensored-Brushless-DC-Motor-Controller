module CommutationControl(
	input clk,
	input [2:0]UI, 
	input [2:0]HS, //Hall Sensors 
	output [5:0]PT //6 Power Transistor control signals
);
	/*
	  UI[0](Regen Break One) or UI[1]&UI[2](Regen Break Two)
	  UI[1] is clockwise spin
	  UI[2] is counter-cw spin
	  HS[0],HS[1],HS[2] are the HS sensor signals
	*/	
	
	wire Aw,Bw,Cw,Dw,Ew,Fw;
	reg [1:0]Ar = 2'd0;
	reg [1:0]Br = 2'd0;
	reg [1:0]Cr = 2'd0;
	reg [1:0]Dr = 2'd0;
	reg [1:0]Er = 2'd0;
	reg [1:0]Fr = 2'd0; //registers for delays


	assign Aw = ~HS[0]&HS[2]&~UI[0]&UI[2] | ~HS[1]&HS[2]&~UI[0]&UI[1] | ~HS[0]&HS[1]&~UI[0]&UI[1]&UI[2] | HS[0]&~HS[1]&~UI[0]&UI[1]&UI[2] | HS[0]&~HS[2]&~UI[0]&UI[1]&UI[2] | HS[1]&~HS[2]&~UI[0]&UI[1]&UI[2];
	
	assign Bw = HS[1]&~HS[2]&UI[0]&~UI[1]&~UI[2] | ~HS[1]&HS[2]&UI[0]&~UI[1]&~UI[2] | HS[0]&~HS[2]&UI[0]&~UI[1]&~UI[2] | HS[0]&~HS[2]&~UI[0]&~UI[1]&UI[2] | ~HS[0]&HS[2]&UI[0]&~UI[1]&~UI[2] | ~HS[0]&HS[1]&UI[0]&~UI[1]&~UI[2] | HS[1]&~HS[2]&~UI[0]&UI[1]&~UI[2] | HS[0]&~HS[1]&UI[0]&~UI[1]&~UI[2];
	
	assign Cw = HS[0]&~HS[1]&~UI[0]&UI[1]&UI[2] | ~HS[1]&HS[2]&~UI[0]&UI[1]&UI[2] | ~HS[0]&HS[1]&~UI[0]&UI[1]&UI[2] | HS[1]&~HS[2]&~UI[0]&UI[2] | HS[0]&~HS[2]&~UI[0]&UI[1] | ~HS[0]&HS[2]&~UI[0]&UI[1]&UI[2];
	
	assign Dw = ~HS[0]&HS[1]&UI[0]&~UI[1]&~UI[2] | HS[0]&~HS[1]&UI[0]&~UI[1]&~UI[2] | ~HS[0]&HS[2]&UI[0]&~UI[1]&~UI[2] | ~HS[1]&HS[2]&~UI[0]&~UI[1]&UI[2] | ~HS[1]&HS[2]&UI[0]&~UI[1]&~UI[2] | HS[1]&~HS[2]&UI[0]&~UI[1]&~UI[2] | ~HS[0]&HS[2]&~UI[0]&UI[1]&~UI[2] | HS[0]&~HS[2]&UI[0]&~UI[1]&~UI[2];
	
	assign Ew = ~HS[0]&HS[2]&~UI[0]&UI[1]&UI[2] | HS[0]&~HS[2]&~UI[0]&UI[1]&UI[2] | HS[0]&~HS[1]&~UI[0]&UI[2] | ~HS[1]&HS[2]&~UI[0]&UI[1]&UI[2] | HS[1]&~HS[2]&~UI[0]&UI[1]&UI[2] | ~HS[0]&HS[1]&~UI[0]&UI[1];
	
	assign Fw = HS[0]&~HS[1]&~UI[0]&UI[1]&~UI[2] | HS[0]&~HS[1]&UI[0]&~UI[1]&~UI[2] | ~HS[0]&HS[1]&~UI[0]&~UI[1]&UI[2] | HS[0]&~HS[2]&UI[0]&~UI[1]&~UI[2] | ~HS[0]&HS[1]&UI[0]&~UI[1]&~UI[2] | ~HS[1]&HS[2]&UI[0]&~UI[1]&~UI[2] | ~HS[0]&HS[2]&UI[0]&~UI[1]&~UI[2] | HS[1]&~HS[2]&UI[0]&~UI[1]&~UI[2];
	
	
	always@(posedge clk)begin  //introduces a dead-time that prevents power transistors in the same bridge from being on at the same time, because if they did then that would cause a short in  the battery. This part however can be removed if the gate drivers has this capability. This dead-time needs to be adjusted based on the turn off/on delay of the power trans used.
	
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
	

	assign PT = {Ar[1],Br[1],Cr[1],Dr[1],Er[1],Fr[1]};



endmodule