`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2024 05:41:45 PM
// Design Name: 
// Module Name: man
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module man(
    input   logic   [9:0]   DrawX, DrawY, 
    input   logic   clk_125MHz,
    input   logic   Reset, 
    input   logic   Win,
    input   logic   Dead,
    input   logic   frame_clk,
    input   logic   [15:0]   keycode,
    
    output  logic   [9:0]   ManX, ManY,
    output  logic   [3:0]   Man_Red, Man_Green, Man_Blue,
    output  logic   Jump_sound
    );
    logic [31:0] man_alive_right_data,man_alive_left_data,man_dead_data;
    logic [5:0] man_addr;
    logic [3:0]   Man_Alive_Right_Red, Man_Alive_Right_Green, Man_Alive_Right_Blue;
    logic [3:0]   Man_Alive_Left_Red, Man_Alive_Left_Green, Man_Alive_Left_Blue;
    logic [3:0]   Man_Dead_Red, Man_Dead_Green, Man_Dead_Blue;
    
    always_comb begin
        man_addr=6'b000000;
        if(ManX<=DrawX && DrawX< (ManX+20) && ManY<=DrawY && DrawY<(ManY+20))
        begin
         man_addr=(DrawX-ManX+(DrawY-ManY)*20)>>3;
        end
    end
    
    man_color_mapper man_color_instance(
        .man_data(man_alive_right_data),
        .ManX(ManX),
        .ManY(ManY),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .Red(Man_Alive_Right_Red),
        .Green(Man_Alive_Right_Green),
        .Blue(Man_Alive_Right_Blue)
    );
    man_left_palette man_color_instance_left(
        .man_data(man_alive_left_data),
        .ManX(ManX),
        .ManY(ManY),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .Red(Man_Alive_Left_Red),
        .Green(Man_Alive_Left_Green),
        .Blue(Man_Alive_Left_Blue)
    );
    man_dead_palette man_color_instance_dead(
        .man_data(man_dead_data),
        .ManX(ManX),
        .ManY(ManY),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .Red(Man_Dead_Red),
        .Green(Man_Dead_Green),
        .Blue(Man_Dead_Blue)
    );
    blk_mem_gen_1 blk_man(
        .clka(clk_125MHz),      // Clock
        .wea(4'b0000),      // Write Enable for Port A
        .addra(man_addr),  // Address bus for Port A
        .dina(32'h00000000),   // Data input for Port A
        .douta(man_alive_right_data), // Data output for Port A
        .ena(1'b1)
    );
    blk_mem_gen_5 blk_man_left(
        .clka(clk_125MHz),      // Clock
        .wea(4'b0000),      // Write Enable for Port A
        .addra(man_addr),  // Address bus for Port A
        .dina(32'h00000000),   // Data input for Port A
        .douta(man_alive_left_data), // Data output for Port A
        .ena(1'b1)
    );
    blk_mem_gen_6 blk_man_dead(
        .clka(clk_125MHz),      // Clock
        .wea(4'b0000),      // Write Enable for Port A
        .addra(man_addr),  // Address bus for Port A
        .dina(32'h00000000),   // Data input for Port A
        .douta(man_dead_data), // Data output for Port A
        .ena(1'b1)
    );
    logic towards_left;
    always_comb begin
        if(Dead==1'b0)
        begin
            if(towards_left==1'b0)
            begin
                Man_Red=Man_Alive_Right_Red;
                Man_Blue=Man_Alive_Right_Blue;
                Man_Green=Man_Alive_Right_Green;
            end
            else
            begin
                Man_Red=Man_Alive_Left_Red;
                Man_Blue=Man_Alive_Left_Blue;
                Man_Green=Man_Alive_Left_Green;
            end
        end
        else
        begin
            Man_Red=Man_Dead_Red;
            Man_Blue=Man_Dead_Blue;
            Man_Green=Man_Dead_Green;
        end
    end
	 
//    parameter [9:0] Man_X_Center=40;  // Center position on the X axis
//    parameter [9:0] Man_Y_Center=280;  // Center position on the Y axis
//    parameter [9:0] Man_X_Min=0;       // Leftmost point on the X axis
//    parameter [9:0] Man_X_Max=480;     // Rightmost point on the X axis
//    parameter [9:0] Man_Y_Min=0;       // Topmost point on the Y axis
//    parameter [9:0] Man_Y_Max=360;     // Bottommost point on the Y axis
//    parameter [9:0] Man_X_Step=1;      // Step size on the X axis
//    parameter [9:0] Man_Y_Step=1;      // Step size on the Y axis

//    logic [9:0] Man_X_Motion;
//    logic [9:0] Man_X_Motion_next;
//    logic [9:0] Man_Y_Motion;
//    logic [9:0] Man_Y_Motion_next;

//    logic [9:0] Man_X_next;
//    logic [9:0] Man_Y_next;

//    always_comb begin
//        Man_Y_Motion_next = 10'h0; // set default motion to be same as prev clock cycle 
//        Man_X_Motion_next = 10'h0;
        
//        //modify to control Man motion with the keycode
//        if (keycode == 8'h1A)  //W
//        begin
//               Man_Y_Motion_next = -10'd1;
//               Man_X_Motion_next = 10'h0;
//        end
//        else if (keycode == 8'h16)    //S
//        begin
//               Man_Y_Motion_next = 10'd1;
//               Man_X_Motion_next = 10'h0;
//        end
//        else if  (keycode == 8'h07)      //D
//        begin
//               Man_X_Motion_next = 10'd1;
//               Man_Y_Motion_next = 10'h0;
//        end
//        else if (keycode == 8'h04)     //A
//        begin
//               Man_X_Motion_next = -10'd1;
//               Man_Y_Motion_next = 10'h0;
//        end
        


//        if ( (ManY + ManS) >= Man_Y_Max )  // Man is at the bottom edge, BOUNCE!
//        begin
//            Man_Y_Motion_next = (~ (Man_Y_Step) + 1'b1);  // set to -1 via 2's complement.
//        end
//        else if ( (ManY - ManS) <= Man_Y_Min )  // Man is at the top edge, BOUNCE!
//        begin
//            Man_Y_Motion_next = Man_Y_Step;
//        end  
//       //fill in the rest of the motion equations here to bounce left and right
//        else if ( (ManX + ManS) >= Man_X_Max )
//        begin 
//		      Man_X_Motion_next = (~ (Man_X_Step) + 1'b1);
//		end
//        else if ( (ManX - ManS) <= Man_X_Min ) 
//        begin 
//		      Man_X_Motion_next = Man_X_Step;
//		end
//    end

//    assign ManS = 16;  // default Man size
//    assign Man_X_next = (ManX + Man_X_Motion_next);
//    assign Man_Y_next = (ManY + Man_Y_Motion_next);
   
//    always_ff @(posedge frame_clk) //make sure the frame clock is instantiated correctly
//    begin: Move_Man
//        if (Reset)
//        begin 
//            Man_Y_Motion <= 10'd0; //Man_Y_Step;
//			Man_X_Motion <= 10'd0; //Man_X_Step;
            
//			ManY <= Man_Y_Center;
//			ManX <= Man_X_Center;
//        end
//        else 
//        begin 
//			Man_Y_Motion <= Man_Y_Motion_next; 
//			Man_X_Motion <= Man_X_Motion_next; 
//            ManY <= Man_Y_next;  // Update Man position
//            ManX <= Man_X_next;			
//		end  
//    end
    logic on_ground,wall_left,wall_right,wall_above;
    on_ground_checker ground_checker(.ManX(ManX),.ManY(ManY),.on_ground(on_ground));
    wall_checker wall_check(.ManX(ManX),.ManY(ManY),.wall_left(wall_left),.wall_right(wall_right),.wall_above(wall_above));

    // Constants and State Variables
    parameter [9:0] Man_X_Center=40;  // Center position on the X axis
    parameter [9:0] Man_Y_Center=280;  // Center position on the Y axis
    parameter [9:0] Man_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Man_X_Max=480;     // Rightmost point on the X axis
    parameter [9:0] Man_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Man_Y_Max=360;     // Bottommost point on the Y axis
    parameter [9:0] Man_X_Step=1;      // Step size on the X axis
    parameter [9:0] Man_Y_Step=1;      // Step size on the Y axis
    
    logic [9:0] Man_X_Motion;
    logic [9:0] Man_X_Motion_next;
    logic [9:0] Man_Y_Motion;
    logic [9:0] Man_Y_Motion_next;

    logic [9:0] Man_X_next;
    logic [9:0] Man_Y_next;
    logic [7:0] keycode_1,keycode_2;
    logic jumping;
    logic [9:0] jumping_frame_count;
    assign keycode_1=keycode[7:0];
    assign keycode_2=keycode[15:8];
    always_ff @(posedge frame_clk or posedge Reset) begin
        if (Reset) begin 
            Man_Y_Motion <= 10'd0;
            Man_X_Motion <= 10'd0;
            ManY <= Man_Y_Center;
            ManX <= Man_X_Center;
            jumping<=1'b0;
            towards_left<=1'b0;
            Jump_sound <=1'b0;
        end 
        else if(Win==1||Dead==1)
        begin
            Man_Y_Motion <= 10'd0;
            Man_X_Motion <= 10'd0;
            Man_Y_Motion_next = 10'h0;
            Man_X_Motion_next = 10'h0;
            ManY<=ManY;
            ManX<=ManX;
        end 
        else begin
            // Default motion setup
            Man_Y_Motion_next = 10'h0;
            Man_X_Motion_next = 10'h0;
    
            // Control Man motion with the keycode
            if ((keycode_1 == 8'h1A||keycode_2 == 8'h1A) && jumping==1'b0 && on_ground==1) begin  // W
                jumping=1'b1;
                jumping_frame_count=5'd0;
                Jump_sound = 1'd1;
            end
            
            if(jumping==1'b1) begin
                if(jumping_frame_count<9'd20) begin
                    Man_Y_Motion_next =-10'd4;
                    
                end
                else if(jumping_frame_count<9'd30) begin
                    Man_Y_Motion_next =-10'd3;

                end
                else if(jumping_frame_count<9'd45) begin
                    Man_Y_Motion_next =10'd0;

                end
                else if(jumping_frame_count<9'd60) begin
                    Man_Y_Motion_next =10'd1;
                    Jump_sound = 1'd0;
                end
                else begin
                if (on_ground || wall_above) begin
                    jumping = 1'b0;
                    Jump_sound = 1'b0;  // Reset Jump_sound signal when landing or hitting an obstacle
                end
            end
            jumping_frame_count <= jumping_frame_count + 1;
        end
        else begin
            Jump_sound = 1'b0;  // Ensure Jump_sound is off when not jumping
        end


            
            if((keycode_1 == 8'h07&&keycode_2 == 8'h04)||(keycode_2 == 8'h07&&keycode_1 == 8'h04))
            begin
                Man_X_Motion_next = 10'd0;
            end
            else if ((keycode_1 == 8'h07||keycode_2 == 8'h07)&&wall_right==0) begin  // D
                Man_X_Motion_next = 10'd1;
                towards_left=1'b0;
            end else if ((keycode_1 == 8'h04||keycode_2 ==8'h04)&&wall_left==0) begin  // A
                Man_X_Motion_next = -10'd1;
                towards_left=1'b1;
            end
            
            if(on_ground==0)
            begin
                Man_Y_Motion_next=Man_Y_Motion_next+10'd2;
            end
            // Boundary checks for bouncing behavior
//            if ((ManY + 10'd20) >= Man_Y_Max) begin
//                Man_Y_Motion_next = (~Man_Y_Step + 1'b1);
//            end else if ((ManY) <= Man_Y_Min) begin
//                Man_Y_Motion_next = Man_Y_Step;
//            end
    
//            if ((ManX + 10'd20) >= Man_X_Max) begin
//                Man_X_Motion_next = (~Man_X_Step + 1'b1);
//            end else if ((ManX) <= Man_X_Min) begin
//                Man_X_Motion_next = Man_X_Step;
//            end
    
            // Update motion states
            Man_Y_Motion <= Man_Y_Motion_next;
            Man_X_Motion <= Man_X_Motion_next;
            
            // Calculate next positions
            Man_X_next = ManX + Man_X_Motion_next;
            Man_Y_next = ManY + Man_Y_Motion_next;
            
            
            
            
            if(0<=Man_X_next&&Man_X_next<=33&&Man_Y_next>215)
            begin
                Man_Y_next=215;
            end
            else if(32<=Man_X_next&&Man_X_next<=400&&Man_Y_next>314)
            begin
                Man_Y_next=314;
            end
            else if(81<=Man_X_next&&Man_X_next<=367&&Man_Y_next>215&&Man_Y_next<254)
            begin
               Man_Y_next=215; 
            end
            else if(368<=Man_X_next&&Man_X_next<=387&&Man_Y_next>235&&Man_Y_next<254)
            begin
               Man_Y_next=235; 
            end
            else if(400<=Man_X_next&&Man_X_next<=435&&Man_Y_next>274)
            begin
               Man_Y_next=274; 
            end
            
            if(Man_X_next>=81&&Man_X_next<=387&&Man_Y_next<294&&Man_Y_next>274)
            begin
                Man_Y_next=294;
                jumping<=1'b0;
            end
        
            if(Man_X_next>=81&&Man_X_next<=172&&Man_Y_next<175&&Man_Y_next>155)
            begin
                Man_Y_next=175;
                jumping<=1'b0;
            end
            // Update Man position
            ManY <= Man_Y_next;
            ManX <= Man_X_next;
        end
    end
endmodule
