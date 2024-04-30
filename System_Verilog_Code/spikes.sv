`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2024 08:09:55 PM
// Design Name: 
// Module Name: spikes
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


module spikes(
    input   logic [9:0] DrawX, DrawY, 
    input   logic clk_125MHz,
    input   logic [9:0] SpikeX[0:NUM_SPIKES-1], SpikeY[0:NUM_SPIKES-1],
    input   logic  Draw_direction[0:NUM_SPIKES-1],
    output  logic [3:0]  Spike_Red, Spike_Green, Spike_Blue
    );
    localparam NUM_SPIKES = 24;
    logic [31:0] spike_data_up,spike_data_down;
    logic [5:0] spike_addr;
    logic Spike_Direction;
    logic [9:0] Spike_X,Spike_Y;
    logic [9:0] Spike_X_Part,Spike_Y_Part;
    logic [3:0]  Spike_Red_Up, Spike_Green_Up, Spike_Blue_Up, Spike_Red_Down, Spike_Green_Down, Spike_Blue_Down;
    always_comb begin
        spike_addr = 8'b00000000;
        Spike_X=10'h0;
        Spike_Y=10'h0;
        Spike_Direction=1'b0;
        for (int i = 0; i < NUM_SPIKES; i++) 
        begin
            if (SpikeX[i] <= DrawX && DrawX < (SpikeX[i] + 5'd20) &&
                SpikeY[i] <= DrawY && DrawY < (SpikeY[i] + 5'd20)) 
                begin
                    Spike_X=SpikeX[i];
                    Spike_Y=SpikeY[i];
                    Spike_Direction=Draw_direction[i];
                    spike_addr = (DrawX - Spike_X + (DrawY - Spike_Y) * 5'd20) >> 3;
                    break; 
                end
        end
    end
    
//    always_comb begin
//        spike_addr=8'b00000000;
//        if(SpikeX<=DrawX && DrawX< (SpikeX+6'd40) && SpikeY<=DrawY && DrawY<(SpikeY+6'd40))
//        begin
//            spike_addr=(DrawX-SpikeX+(DrawY-SpikeY)*40)>>3;
//        end
//    end
    
    spike_color_mapper spike_color_instance(
        .Spike_data(spike_data_up),
        .SpikeX(Spike_X),
        .SpikeY(Spike_Y),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .Red(Spike_Red_Up),
        .Green(Spike_Green_Up),
        .Blue(Spike_Blue_Up)
    );
    
    blk_mem_gen_2 blk_spike(
        .clka(clk_125MHz),      // Clock
        .wea(4'b0000),      // Write Enable for Port A
        .addra(spike_addr),  // Address bus for Port A
        .dina(32'h00000000),   // Data input for Port A
        .douta(spike_data_up), // Data output for Port A
        .ena(1'b1)
    );
    blk_mem_gen_4 blk_spike_down(
        .clka(clk_125MHz),      // Clock
        .wea(4'b0000),      // Write Enable for Port A
        .addra(spike_addr),  // Address bus for Port A
        .dina(32'h00000000),   // Data input for Port A
        .douta(spike_data_down), // Data output for Port A
        .ena(1'b1)
    );
    spike_down_color_mapper spike_color_instance_down(
        .Spike_data(spike_data_down),
        .SpikeX(Spike_X),
        .SpikeY(Spike_Y),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .Red(Spike_Red_Down),
        .Green(Spike_Green_Down),
        .Blue(Spike_Blue_Down)
    );
    always_comb begin
        if(Spike_Direction==1'b0)
        begin
            Spike_Red=Spike_Red_Up;
            Spike_Blue=Spike_Blue_Up;
            Spike_Green=Spike_Green_Up;
        end
        else
        begin
            Spike_Red=Spike_Red_Down;
            Spike_Blue=Spike_Blue_Down;
            Spike_Green=Spike_Green_Down;
        end
    end
endmodule