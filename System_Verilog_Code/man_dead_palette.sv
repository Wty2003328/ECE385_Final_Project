`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2024 01:47:03 PM
// Design Name: 
// Module Name: man_dead_palette
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


module man_dead_palette(
        input  logic [9:0] DrawX, DrawY, ManX, ManY,
                       input  logic [31:0] man_data, 
                       output logic [3:0]  Red, Green, Blue
    );
    logic [3:0] pixel_idx,pixel_data;
    
 always_comb begin
        pixel_idx=4'd0;
        if(ManX<=DrawX && DrawX< (ManX+5'd20) && ManY<=DrawY && DrawY<(ManY+5'd20))
        begin
            pixel_idx=(DrawX-ManX+(DrawY-ManY)*20)%8;
        end
        pixel_data=32'd0;
        if(pixel_idx==4'd0)
        begin
            pixel_data=man_data[3:0];
        end
        else if(pixel_idx==4'd1)
        begin
            pixel_data=man_data[7:4];
        end
        else if(pixel_idx==4'd2)
        begin
            pixel_data=man_data[11:8];
        end
        else if(pixel_idx==4'd3)
        begin
            pixel_data=man_data[15:12];
        end
        else if(pixel_idx==4'd4)
        begin
            pixel_data=man_data[19:16];
        end
        else if(pixel_idx==4'd5)
        begin
            pixel_data=man_data[23:20];
        end
        else if(pixel_idx==4'd6)
        begin
            pixel_data=man_data[27:24];
        end
        else if(pixel_idx==4'd7)
        begin
            pixel_data=man_data[31:28];
        end
    end
    localparam [0:15][11:0] palette = {
        {4'hF, 4'hF, 4'hF},
        {4'h6, 4'h5, 4'h3},
        {4'hE, 4'h1, 4'h2},
        {4'hE, 4'hB, 4'h6},
        {4'h0, 4'h0, 4'h0},
        {4'h5, 4'h2, 4'h1},
        {4'hA, 4'h8, 4'h6},
        {4'h2, 4'h1, 4'h1},
        {4'hF, 4'hF, 4'hF},
        {4'h4, 4'h3, 4'h3},
        {4'h0, 4'h0, 4'h0},
        {4'hE, 4'h1, 4'h2},
        {4'hE, 4'h1, 4'h2},
        {4'hE, 4'h1, 4'h2},
        {4'hE, 4'h1, 4'h2},
        {4'hE, 4'h1, 4'h2}
    };
    assign {Red, Green, Blue} = palette[pixel_data];
endmodule
