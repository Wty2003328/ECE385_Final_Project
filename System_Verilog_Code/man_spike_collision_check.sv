`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2024 11:26:04 PM
// Design Name: 
// Module Name: man_spike_collision_check
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

module game_state_check(
        input logic [9:0] ManX, ManY,
        input logic   [15:0]   keycode,
        input   logic  Draw_direction[0:NUM_SPIKES-1],
        input logic [9:0] SpikeX[0:NUM_SPIKES-1], SpikeY[0:NUM_SPIKES-1],
        input   logic [9:0] AppleX[0:NUM_AppleS-1], AppleY[0:NUM_AppleS-1],
        output  logic collide,
        output  logic reset,
        output  logic level_complete
    );
    localparam NUM_SPIKES = 24;
    localparam NUM_AppleS = 4;
    always_comb begin
        reset=1'b0;
        if(keycode[7:0]==16'h15||keycode[15:8]==16'h15)
        begin
            reset=1'b1;
        end
        
        level_complete=1'b0;
        if(0<=ManX&&ManX<=10&&ManY==215)
        begin
            level_complete=1'b1;
        end
        collide=1'b0;
        for (int i = 0; i < NUM_SPIKES; i++) 
        begin
            if(Draw_direction[i]==0)
            begin
                if((ManX+15==SpikeX[i]||ManX+10==SpikeX[i])&&((ManY+19)>=SpikeY[i]+18)&&((ManY+19)<=SpikeY[i]+19))
                begin
                    collide=1'b1;
                end
                else if((ManX+15==SpikeX[i]+1||ManX+10==SpikeX[i]+1)&&((ManY+19)>=SpikeY[i]+16)&&((ManY+19)<=SpikeY[i]+19))
                begin
                    collide=1'b1;
                end
                else if((ManX+15==SpikeX[i]+2||ManX+10==SpikeX[i]+2)&&((ManY+19)>=SpikeY[i]+14)&&((ManY+19)<=SpikeY[i]+19))
                begin
                    collide=1'b1;
                end
                else if((ManX+15==SpikeX[i]+3||ManX+10==SpikeX[i]+3)&&((ManY+19)>=SpikeY[i]+12)&&((ManY+19)<=SpikeY[i]+19))
                begin
                    collide=1'b1;
                end
                else if((ManX+15==SpikeX[i]+4||ManX+10==SpikeX[i]+4)&&((ManY+19)>=SpikeY[i]+10)&&((ManY+19)<=SpikeY[i]+19))
                begin
                    collide=1'b1;
                end
                else if((ManX+15==SpikeX[i]+5||ManX+10==SpikeX[i]+5)&&((ManY+19)>=SpikeY[i]+8)&&((ManY+19)<=SpikeY[i]+19))
                begin
                    collide=1'b1;
                end
                else if((ManX+15==SpikeX[i]+6||ManX+10==SpikeX[i]+6)&&((ManY+19)>=SpikeY[i]+6)&&((ManY+19)<=SpikeY[i]+19))
                begin
                    collide=1'b1;
                end
                else if((ManX+15==SpikeX[i]+7||ManX+10==SpikeX[i]+7)&&((ManY+19)>=SpikeY[i]+4)&&((ManY+19)<=SpikeY[i]+19))
                begin
                    collide=1'b1;
                end
                else if((ManX+15==SpikeX[i]+8||ManX+10==SpikeX[i]+8)&&((ManY+19)>=SpikeY[i]+2)&&((ManY+19)<=SpikeY[i]+19))
                begin
                    collide=1'b1;
                end
                else if((ManX+15==SpikeX[i]+9||ManX+10==SpikeX[i]+9)&&((ManY+19)>=SpikeY[i])&&((ManY+19)<=SpikeY[i]+19))
                begin
                    collide=1'b1;
                end
                
                if((ManX+4==SpikeX[i]+19||ManX+10==SpikeX[i]+19)&&((ManY+19)>=SpikeY[i]+18)&&((ManY+19)<=SpikeY[i]+19))
                begin
                    collide=1'b1;
                end
                else if((ManX+4==SpikeX[i]+18||ManX+10==SpikeX[i]+18)&&((ManY+19)>=SpikeY[i]+16)&&((ManY+19)<=SpikeY[i]+19))
                begin
                    collide=1'b1;
                end
                else if((ManX+4==SpikeX[i]+17||ManX+10==SpikeX[i]+17)&&((ManY+19)>=SpikeY[i]+14)&&((ManY+19)<=SpikeY[i]+19))
                begin
                    collide=1'b1;
                end
                else if((ManX+4==SpikeX[i]+16||ManX+10==SpikeX[i]+16)&&((ManY+19)>=SpikeY[i]+12)&&((ManY+19)<=SpikeY[i]+19))
                begin
                    collide=1'b1;
                end
                else if((ManX+4==SpikeX[i]+15||ManX+10==SpikeX[i]+15)&&((ManY+19)>=SpikeY[i]+10)&&((ManY+19)<=SpikeY[i]+19))
                begin
                    collide=1'b1;
                end
                else if((ManX+4==SpikeX[i]+14||ManX+10==SpikeX[i]+14)&&((ManY+19)>=SpikeY[i]+8)&&((ManY+19)<=SpikeY[i]+19))
                begin
                    collide=1'b1;
                end
                else if((ManX+4==SpikeX[i]+13||ManX+10==SpikeX[i]+13)&&((ManY+19)>=SpikeY[i]+6)&&((ManY+19)<=SpikeY[i]+19))
                begin
                    collide=1'b1;
                end
                else if((ManX+4==SpikeX[i]+12||ManX+10==SpikeX[i]+12)&&((ManY+19)>=SpikeY[i]+4)&&((ManY+19)<=SpikeY[i]+19))
                begin
                    collide=1'b1;
                end
                else if((ManX+4==SpikeX[i]+11||ManX+10==SpikeX[i]+11)&&((ManY+19)>=SpikeY[i]+2)&&((ManY+19)<=SpikeY[i]+19))
                begin
                    collide=1'b1;
                end
                else if((ManX+4==SpikeX[i]+10||ManX+10==SpikeX[i]+10)&&((ManY+19)>=SpikeY[i])&&((ManY+19)<=SpikeY[i]+19))
                begin
                    collide=1'b1;
                end
            end else begin
                if((ManX+15==SpikeX[i]||ManX+10==SpikeX[i])&&(ManY>=SpikeY[i])&&(ManY<=SpikeY[i]))
                begin
                    collide=1'b1;
                end
                else if((ManX+15==SpikeX[i]+1||ManX+10==SpikeX[i]+1)&&(ManY>=SpikeY[i])&&(ManY<=SpikeY[i]+2))
                begin
                    collide=1'b1;
                end
                else if((ManX+15==SpikeX[i]+2||ManX+10==SpikeX[i]+2)&&(ManY>=SpikeY[i])&&(ManY<=SpikeY[i]+4))
                begin
                    collide=1'b1;
                end
                else if((ManX+15==SpikeX[i]+3||ManX+10==SpikeX[i]+3)&&(ManY>=SpikeY[i])&&(ManY<=SpikeY[i]+6))
                begin
                    collide=1'b1;
                end
                else if((ManX+15==SpikeX[i]+4||ManX+10==SpikeX[i]+4)&&(ManY>=SpikeY[i])&&(ManY<=SpikeY[i]+8))
                begin
                    collide=1'b1;
                end
                else if((ManX+15==SpikeX[i]+5||ManX+10==SpikeX[i]+5)&&(ManY>=SpikeY[i])&&(ManY<=SpikeY[i]+10))
                begin
                    collide=1'b1;
                end
                else if((ManX+15==SpikeX[i]+6||ManX+10==SpikeX[i]+6)&&(ManY>=SpikeY[i])&&(ManY<=SpikeY[i]+12))
                begin
                    collide=1'b1;
                end
                else if((ManX+15==SpikeX[i]+7||ManX+10==SpikeX[i]+7)&&(ManY>=SpikeY[i])&&(ManY<=SpikeY[i]+14))
                begin
                    collide=1'b1;
                end
                else if((ManX+15==SpikeX[i]+8||ManX+10==SpikeX[i]+8)&&(ManY>=SpikeY[i])&&(ManY<=SpikeY[i]+16))
                begin
                    collide=1'b1;
                end
                else if((ManX+15==SpikeX[i]+9||ManX+10==SpikeX[i]+9)&&(ManY>=SpikeY[i])&&(ManY<=SpikeY[i]+18))
                begin
                    collide=1'b1;
                end
                
                if((ManX+4==SpikeX[i]+19||ManX+10==SpikeX[i]+19)&&(ManY>=SpikeY[i])&&(ManY<=SpikeY[i]))
                begin
                    collide=1'b1;
                end
                else if((ManX+4==SpikeX[i]+18||ManX+10==SpikeX[i]+18)&&(ManY>=SpikeY[i])&&(ManY<=SpikeY[i]+2))
                begin
                    collide=1'b1;
                end
                else if((ManX+4==SpikeX[i]+17||ManX+10==SpikeX[i]+17)&&(ManY>=SpikeY[i])&&(ManY<=SpikeY[i]+4))
                begin
                    collide=1'b1;
                end
                else if((ManX+4==SpikeX[i]+16||ManX+10==SpikeX[i]+16)&&(ManY>=SpikeY[i])&&(ManY<=SpikeY[i]+6))
                begin
                    collide=1'b1;
                end
                else if((ManX+4==SpikeX[i]+15||ManX+10==SpikeX[i]+15)&&(ManY>=SpikeY[i])&&(ManY<=SpikeY[i]+8))
                begin
                    collide=1'b1;
                end
                else if((ManX+4==SpikeX[i]+14||ManX+10==SpikeX[i]+14)&&(ManY>=SpikeY[i])&&(ManY<=SpikeY[i]+10))
                begin
                    collide=1'b1;
                end
                else if((ManX+4==SpikeX[i]+13||ManX+10==SpikeX[i]+13)&&(ManY>=SpikeY[i])&&(ManY<=SpikeY[i]+12))
                begin
                    collide=1'b1;
                end
                else if((ManX+4==SpikeX[i]+12||ManX+10==SpikeX[i]+12)&&(ManY>=SpikeY[i])&&(ManY<=SpikeY[i]+14))
                begin
                    collide=1'b1;
                end
                else if((ManX+4==SpikeX[i]+11||ManX+10==SpikeX[i]+11)&&(ManY>=SpikeY[i])&&(ManY<=SpikeY[i]+16))
                begin
                    collide=1'b1;
                end
                else if((ManX+4==SpikeX[i]+10||ManX+10==SpikeX[i]+10)&&(ManY>=SpikeY[i])&&(ManY<=SpikeY[i]+18))
                begin
                    collide=1'b1;
                end
            end
           
            
            if(collide==1'b1)
            begin
                break;
            end
        end
        
        for (int j=0; j<NUM_AppleS;j++)
        begin
            if((ManX<=AppleX[j]+10)&&(ManX>=AppleX[j]-10)&&(ManY<AppleY[j]+14)&&(ManY>AppleY[j]-8))
            begin
                    collide=1'b1;
            end
            if(collide==1'b1)
            begin
                break;
            end
        end
    end
endmodule
