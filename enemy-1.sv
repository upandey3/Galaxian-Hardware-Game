module  enemy ( input Reset, frame_clk, /*collision,*/ level, lost_game,
				output [9:0] enemy_posX [0:23],
				output [9:0] enemy_posY [0:23],
				output [4:0] enemy_type, enemy_type2, enemy_type3,
				output logic clkdiv2
			);
    
    //logic ship_state;
    //logic [9:0] SHIP_X_Pos, SHIP_X_Motion, SHIP_Y_Pos, Ship_Size;
    logic [9:0] posX[0:23];
    logic [9:0] posY[0:23];
    logic [4:0] type_of_enemy, type_of_enemy2, type_of_enemy3;
    logic [9:0] enemy_X_Motion;

	parameter [9:0] size=15;
    parameter [9:0] enemy_X_Step=4;
    parameter [9:0] enemy_X_Max=195;
    parameter [9:0] enemy_X_Min=25;

    logic clkdiv, clkdiv1, clkdiv3, clkdiv4; //clkdiv3 = 1/16speed

    	//This cuts the 50 Mhz clock in half to generate a 25 MHz pixel clock  
    always_ff @ (posedge frame_clk or posedge Reset )
    begin 
        if (Reset) 
            clkdiv <= 1'b0;
        else 
            clkdiv <= ~ (clkdiv);
    end
     always_ff @ (posedge clkdiv or posedge Reset )
    begin 
        if (Reset) 
            clkdiv1 <= 1'b0;
        else 
            clkdiv1 <= ~ (clkdiv1);
    end
     always_ff @ (posedge clkdiv1 or posedge Reset )
    begin 
        if (Reset) 
            clkdiv2 <= 1'b0;
        else 
            clkdiv2 <= ~ (clkdiv2);
    end
     always_ff @ (posedge clkdiv2 or posedge Reset )
    begin 
        if (Reset) 
            clkdiv3 <= 1'b0;
        else 
            clkdiv3 <= ~ (clkdiv3);
    end
    always_ff @ (posedge clkdiv3 or posedge Reset )
    begin 
        if (Reset) 
            clkdiv4 <= 1'b0;
        else 
            clkdiv4 <= ~ (clkdiv4);
    end
   
    always_ff @ (posedge Reset or posedge clkdiv3)
    begin: Display_enemy
        if (Reset)  // Asynchronous Reset
			begin
				// The 24 enemies are laid out in 8 x 3 space with each enemy of the size 16 * 16.
		        // row 1 = 0 ... 7,  row 2 =  8... 15, row 3 =  16... 23
		        // Enemy 0 is at 48, 48, Enemy 1 is at 64, 48 ... Enemy 23 is at 160, 80  
				
				posX[0] <= 10'd97;
				posX[1] <= 10'd61;
				posX[2] <= 10'd79;
				posX[3] <= 10'd97;
				posX[4] <= 10'd115;
				posX[5] <= 10'd133;
				posX[6] <= 10'd151;
				posX[7] <= 10'd115;
				
				posX[8] <= 10'd43;
				posX[9] <= 10'd61;
				posX[10] <= 10'd79;
				posX[11] <= 10'd97;
				posX[12] <= 10'd115;
				posX[13] <= 10'd133;
				posX[14] <= 10'd151;
				posX[15] <= 10'd169;

				posX[16] <= 10'd43;
				posX[17] <= 10'd61;
				posX[18] <= 10'd79;
				posX[19] <= 10'd97;
				posX[20] <= 10'd115;
				posX[21] <= 10'd133;
				posX[22] <= 10'd151;
				posX[23] <= 10'd169;

				posY[0] <= 10'd30;
				posY[1] <= 10'd48;
				posY[2] <= 10'd48;
				posY[3] <= 10'd48;
				posY[4] <= 10'd48;
				posY[5] <= 10'd48;
				posY[6] <= 10'd48;
				posY[7] <= 10'd30;

				posY[8] <= 10'd66;
				posY[9] <= 10'd66;
				posY[10] <= 10'd66;
				posY[11] <= 10'd66;
				posY[12] <= 10'd66;
				posY[13] <= 10'd66;
				posY[14] <= 10'd66;
				posY[15] <= 10'd66;

				posY[16] <= 10'd84;
				posY[17] <= 10'd84;
				posY[18] <= 10'd84;
				posY[19] <= 10'd84;
				posY[20] <= 10'd84;
				posY[21] <= 10'd84;
				posY[22] <= 10'd84;
				posY[23] <= 10'd84;

				type_of_enemy <= 4'd0;
				type_of_enemy2 <= 4'd0;
				type_of_enemy3 <= 4'd0;
	        end

	    else// if (clkdiv4) //move and flap
	    begin
	    	if ((level == 0 )|| (lost_game == 1))
	    		begin
	    			type_of_enemy <= 4'd0;
	    			type_of_enemy2 <= 4'd0; 
	    			type_of_enemy3 <= 4'd0;
	    		end

	    	else
	    	begin
	    		if (type_of_enemy == 4'd0)
	    			type_of_enemy <= 4'd1;
	    		if (type_of_enemy == 4'd1)
	    			type_of_enemy <= 4'd2;
	    		if (type_of_enemy == 4'd2)
	    			type_of_enemy <= 4'd1;

	    		if (type_of_enemy2 == 4'd0)
	    			type_of_enemy2 <= 4'd6;
	    		if (type_of_enemy2 == 4'd6)
	    			type_of_enemy2 <= 4'd5;
	    		if (type_of_enemy2 == 4'd5)
	    			type_of_enemy2 <= 4'd6;

	    		if (type_of_enemy3 == 4'd0)
	    			type_of_enemy3 <= 4'd3;
	    		if (type_of_enemy3 == 4'd3)
	    			type_of_enemy3 <= 4'd4;
	    		if (type_of_enemy3 == 4'd4)
	    			type_of_enemy3 <= 4'd3;
	    		//enemy movement
				if ( ((posX[6] + size + 18) >= enemy_X_Max) )
					enemy_X_Motion <= (~(enemy_X_Step) + 1'b1);  // 2's complement.

				else if(((posX[1] - 18) <= enemy_X_Min))
					enemy_X_Motion <= enemy_X_Step;

				posX[0] <= (posX[0] + enemy_X_Motion);
				posX[1] <= (posX[1] + enemy_X_Motion);
				posX[2] <= (posX[2] + enemy_X_Motion);
				posX[3] <= (posX[3] + enemy_X_Motion);
				posX[4] <= (posX[4] + enemy_X_Motion);
				posX[5] <= (posX[5] + enemy_X_Motion);
				posX[6] <= (posX[6] + enemy_X_Motion);
				posX[7] <= (posX[7] + enemy_X_Motion);

				posX[8] <= (posX[8] + enemy_X_Motion);
				posX[9] <= (posX[9] + enemy_X_Motion);
				posX[10] <= (posX[10] + enemy_X_Motion);
				posX[11] <= (posX[11] + enemy_X_Motion);
				posX[12] <= (posX[12] + enemy_X_Motion);
				posX[13] <= (posX[13] + enemy_X_Motion);
				posX[14] <= (posX[14] + enemy_X_Motion);
				posX[15] <= (posX[15] + enemy_X_Motion);

				posX[16] <= (posX[16] + enemy_X_Motion);
				posX[17] <= (posX[17] + enemy_X_Motion);
				posX[18] <= (posX[18] + enemy_X_Motion);
				posX[19] <= (posX[19] + enemy_X_Motion);
				posX[20] <= (posX[20] + enemy_X_Motion);
				posX[21] <= (posX[21] + enemy_X_Motion);
				posX[22] <= (posX[22] + enemy_X_Motion);
				posX[23] <= (posX[23] + enemy_X_Motion);

	    	end
	    end
    end
       
    assign enemy_posY = posY; 
    assign enemy_posX = posX;
    assign enemy_type = type_of_enemy;
    assign enemy_type2 = type_of_enemy2;
    assign enemy_type3 = type_of_enemy3;
    

endmodule
