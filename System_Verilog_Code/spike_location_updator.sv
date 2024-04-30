`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2024 06:21:37 PM
// Design Name: 
// Module Name: spike_location_updator
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


module spike_location_updator(
    input   logic [9:0] ManX, ManY,
    input   logic   frame_clk,
    input   logic   Reset, 
    input   logic   Dead,
    output  logic [9:0] SpikeX[0:NUM_SPIKES-1], SpikeY[0:NUM_SPIKES-1],
    output  logic Draw_direction[0:NUM_SPIKES-1],
    output  logic Triggered[0:NUM_SPIKES-1]
    );
    localparam NUM_SPIKES = 24;
    logic [9:0] Velocity[0:NUM_SPIKES-1];
//    always_comb begin
//        SpikeX = {9'd130, 9'd200, 9'd220, 9'd351, 9'd435,9'd130,9'd150,9'd300,9'd320,9'd340};
//        SpikeY = {9'd215, 9'd215, 9'd215, 9'd215, 9'd274,9'd293,9'd293,9'd293,9'd293,9'd293};
//        //00: up, 01: down, 10: left, 11:right
//        Draw_direction={1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b1,1'b1,1'b1};
        
//    end
    always_ff @(posedge frame_clk or posedge Reset) begin
        if (Reset) begin 
            SpikeX = {
            //1st tier spikes
            9'd97,9'd157,
            //2nd tier spikes
            9'd145,9'd331, 9'd200, 9'd220, 9'd275,9'd351,
            //2.5 tier spikes
            9'd435,
            //1 tier downward spikes
            9'd216,9'd276,
            //2 tier downward spikes
            9'd97,
            //3 tier downward spikes
            9'd130,9'd150,9'd200,9'd220,9'd280,9'd300,9'd320,9'd371,
            //rightside downward spikes 
            9'd240,9'd396,9'd416,9'd436};
            
            SpikeY = {
            //1st tier spikes
            9'd136,9'd136,
            //2nd tier spikes
            9'd215,9'd215, 9'd215, 9'd215, 9'd215,9'd215,
            //2.5 tier spikes
            9'd274,
            //1 tier downward spikes
            9'd96,9'd96,
            //2 tier downward spikes
            9'd175,
            //3 tier downward spikes
            9'd293,9'd293,9'd293,9'd293,9'd293,9'd293,9'd293,9'd293,
            //rightside downward spikes 
            9'd116,9'd135,9'd155,9'd175
            };
            //0: up, 1: down
            Draw_direction={1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1};
            Velocity={9'b0,9'b0,9'b0,9'b0,9'b0,9'b0,9'b0,9'b0,9'b0,9'b0,9'b0,9'b0,9'b0,9'b0,9'b0,9'b0,9'b0,9'b0,9'b0,9'b0,9'b0,9'b0,9'b0,9'b0};
            Triggered={1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0};
        end 
        else 
        begin
            if(ManX==210&&Triggered[15]==0)
            begin
                Velocity[15]=9'd1;
                Triggered[15]=1'b1;
            end
            if(ManX==290&&Triggered[16]==0)
            begin
                Velocity[16]=9'd1;
                Triggered[16]=1'b1;
            end
            if(ManX==307&&Triggered[18]==0)
            begin
                Velocity[18]=9'd1;
                Triggered[18]=1'b1;
            end
            if(ManX==368&&ManY<=270&&Triggered[7]==0)
            begin
                Velocity[7]=(~(9'd0));
                Triggered[7]=1'b1;
            end
            if(ManX==285&&ManY<=270&&Triggered[6]==0)
            begin
                Velocity[6]=(~(9'd0));
                Triggered[6]=1'b1;
            end
            if(ManX==220&&ManY<=270&&Triggered[4]==0&&Triggered[20]==0)
            begin
                Velocity[4]=(~(9'd0));
                Triggered[4]=1'b1;
                Velocity[20]=9'd1;
                Triggered[20]=1'b1;
            end
            if(ManX==405&&Triggered[21]==0&&Triggered[22]==0)
            begin
                Velocity[21]=9'd1;
                Triggered[21]=1'b1;
                Velocity[22]=9'd1;
                Triggered[22]=1'b1;
            end
            for (int i = 0; i < NUM_SPIKES; i++) 
            begin
                SpikeY[i]<=SpikeY[i]+Velocity[i];
                if(SpikeY[i]>359||SpikeY[i]==0)
                begin
                    SpikeY[i]=360;
                    Velocity[i]=0;
                end
            end
        end
    end
endmodule
