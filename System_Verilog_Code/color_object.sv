`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2024 06:04:46 PM
// Design Name: 
// Module Name: color_object
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

localparam NUM_SPIKES = 24;


module color_object(
        input logic Dead,
        input logic Win,
        input  logic [9:0]  DrawX, DrawY, ManX, ManY,OverX,OverY,WinX,WinY,
        input  logic [9:0]  SpikeX[0:NUM_SPIKES-1],SpikeY[0:NUM_SPIKES-1],
        input  logic [9:0]  AppleX[0:NUM_AppleS-1],AppleY[0:NUM_AppleS-1],
        input logic [3:0]   Bkg_Red, Bkg_Green, Bkg_Blue,
        input logic [3:0]   Spike_Red, Spike_Green, Spike_Blue,
        input logic [3:0]   Apple_Red, Apple_Green, Apple_Blue,
        input logic [3:0]   Man_Red, Man_Green, Man_Blue,
        input logic [3:0]   Win_Red, Win_Green, Win_Blue,
        input logic [3:0]   Over_Red,Over_Green,Over_Blue,
        output logic [3:0]  Red, Green, Blue
    );
    localparam NUM_AppleS = 4;
    always_comb begin
        Red=Bkg_Red;
        Green=Bkg_Green;
        Blue=Bkg_Blue;
        for (int i = 0; i < NUM_SPIKES; i++) 
        begin
            if (AppleX[i] <= DrawX && DrawX < (AppleX[i] + 5'd16) &&
                AppleY[i] <= DrawY && DrawY < (AppleY[i] + 5'd16)&& (~(Apple_Red==4'hF && Apple_Green==4'hF && Apple_Blue==4'hF))) 
                begin
                    Red=Apple_Red;
                    Green=Apple_Green;
                    Blue=Apple_Blue;
                    break; 
                end
        end
        
        for (int i = 0; i < NUM_SPIKES; i++) 
        begin
            if (SpikeX[i] <= DrawX && DrawX < (SpikeX[i] + 5'd20) &&
                SpikeY[i] <= DrawY && DrawY < (SpikeY[i] + 5'd20)&& (~(Spike_Red==4'hF && Spike_Green==4'hF && Spike_Blue==4'hF))) 
                begin
                    Red=Spike_Red;
                    Green=Spike_Green;
                    Blue=Spike_Blue;
                    break; 
                end
        end
        
        if(ManX<=DrawX && DrawX< (ManX+5'd20) && ManY<=DrawY && DrawY<(ManY+5'd20) && Man_Red!=4'hF && Man_Green!=4'hF && Man_Blue!=4'hF)
        begin
            Red=Man_Red;
            Green=Man_Green;
            Blue=Man_Blue;
        end
        if(Dead==1&&OverX<=DrawX && DrawX< (OverX+320) && OverY<=DrawY && DrawY<(OverY+64) && Over_Red!=4'h0 && Over_Green!=4'h0 && Over_Blue!=4'h0)
        begin
            Red=Over_Red;
            Green=Over_Green;
            Blue=Over_Blue;
        end
        if(Win==1&&WinX<=DrawX && DrawX< (WinX+266) && WinY<=DrawY && DrawY<(WinY+64) && (~(Win_Red==4'hF && Win_Green==4'hF && Win_Blue==4'hF)))
        begin
            Red=Win_Red;
            Green=Win_Green;
            Blue=Win_Blue;
        end
//        if(SpikeX<=DrawX && DrawX< (SpikeX+6'd40) && SpikeY<=DrawY && DrawY<(SpikeY+6'd40) && Spike_Red!=4'hF && Spike_Green!=4'hF && Spike_Blue!=4'hF)
//        begin
//            Red=Spike_Red;
//            Green=Spike_Green;
//            Blue=Spike_Blue;
//        end
    end
endmodule
