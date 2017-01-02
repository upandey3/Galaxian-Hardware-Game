module  missile ( 	input Reset, frame_clk, //missile1_hit, missile2_hit,
				input [15:0] keycode,
				input [9:0] SHIPX, SHIPY,
				output [9:0]  MISSILE1_X, MISSILE1_Y, //MISSILE2_X, MISSILE2_Y,
				output missile_1//, missile_2
			);
    
    logic missile1_state;// missile2_state;
    logic [3:0] missile_size;
    logic [9:0] missile1_X_Pos, missile1_Y_Motion, missile1_Y_Pos;
    //logic [9:0] missile2_X_Pos, missile2_Y_Motion, missile2_Y_Pos;
	 
    parameter [9:0] missile_Y_Step=6;     // Step size on the Y axis
    logic [9:0] missile_Y_Start, missile_X_Start;
	 
	 assign missile_Y_Start = SHIPY - 3;
    assign missile_X_Start = SHIPX - 1;
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin
        if (Reset)  // Asynchronous Reset
        begin 
			missile1_state <= 0;
			missile1_Y_Motion <= 0;
		 	missile1_Y_Pos <= missile_Y_Start;
		 	missile1_X_Pos <= missile_X_Start;
		 	/*
			missile2_state <= 0;
			missile2_Y_Motion <= 0;
		 	missile2_X_Pos <= missile_X_Start;
			missile2_Y_Pos <= missile_Y_Start;*/
        end
		  
     else
     begin
/*
        if (missile1_hit)
        begin
			missile1_state <= 0;
			missile1_Y_Motion <= 0;
		end
        if (missile2_hit)
        begin
			missile2_state <= 0;
			missile2_Y_Motion <= 0;
		end*/
			// 8'h2c = space
			
			//change to else if for missile hit on
			/*
      	if ((keycode == 8'h2c) && (missile1_state == 0) && (missile2_state == 0)) //0 missiles deployed
		begin
			missile1_state <= 1;							
		 	missile1_Y_Motion <= (~missile_Y_Step) + 1'b1;
		 	missile1_Y_Pos <= missile_Y_Start;
		 	missile1_X_Pos <= missile_X_Start;
			missile2_X_Pos <= missile2_X_Pos;
			missile2_Y_Motion <= missile2_Y_Motion;
		end
		else if ((keycode == 8'h2c) && (missile1_state == 0) && (missile2_state == 0)) //only 1st missile deployed
		begin
			missile2_state <= 1;							
		 	missile2_Y_Motion <= (~missile_Y_Step) + 1'b1;
		 	missile2_Y_Pos <= missile_Y_Start;
		 	missile2_X_Pos <= missile_X_Start;
			missile1_X_Pos <= missile1_X_Pos;
			missile1_Y_Motion <= missile1_Y_Motion;
		end
		else if ((keycode == 8'h2c) && (missile1_state == 0) && (missile2_state == 0)) //only 2nd missile deployed
		begin
			missile1_state <= 1;							
		 	missile1_Y_Motion <= (~missile_Y_Step) + 1'b1;
		 	missile1_Y_Pos <= missile_Y_Start;
		 	missile1_X_Pos <= missile_X_Start;
			missile2_X_Pos <= missile2_X_Pos;
			missile2_Y_Motion <= missile2_Y_Motion;
		end
		*/
		if ((missile1_Y_Pos <= 0) || (missile1_Y_Pos >= 287))
		begin
			missile1_state <= 0;
			missile1_Y_Motion <= 0;
			missile1_Y_Pos <= missile_Y_Start;
		 	missile1_X_Pos <= missile_X_Start;
		end
		
		else if (((keycode[7:0] == 8'h2c) || (keycode[15:8] == 8'h2c)) && (missile1_state == 0))
		begin
			missile1_state <= 1;							
		 	missile1_Y_Motion <= (~missile_Y_Step) + 1'b1;
		 	missile1_Y_Pos <= missile_Y_Start;
		 	missile1_X_Pos <= missile_X_Start;
		end
		
		else
		begin
			missile1_X_Pos <= missile1_X_Pos;
			missile1_Y_Motion <= missile1_Y_Motion;
			missile1_Y_Pos <= (missile1_Y_Pos + missile1_Y_Motion);
			/*missile2_X_Pos <= missile2_X_Pos;
			missile2_Y_Motion <= missile2_Y_Motion;*/
		end

		/*
		if (missile2_Y_Pos <= 0)
		begin
			missile2_state <= 0;
			missile2_Y_Motion <= 0;
		end*/
	 end
		//missile1_Y_Pos <= (missile1_Y_Pos + missile1_Y_Motion); // Update missile position
		//missile2_Y_Pos <= (missile2_Y_Pos + missile2_Y_Motion); // Update missile position 
    end
       
    assign MISSILE1_X = missile1_X_Pos;
    assign MISSILE1_Y = missile1_Y_Pos;
	 assign missile_1 = missile1_state;
    /*assign MISSILE2_X = missile2_X_Pos;
    assign MISSILE2_Y = missile2_Y_Pos;
    assign missile_2 = missile2_state;
    */

endmodule
