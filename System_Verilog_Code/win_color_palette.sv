`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2024 12:13:59 AM
// Design Name: 
// Module Name: win_color_palette
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


module win_color_palette(
 input  logic [9:0] DrawX, DrawY, winX, winY,
                input  logic [31:0] win_data, 
                output logic [3:0]  Red, Green, Blue
    );
    logic [3:0] pixel_idx,pixel_data;
    
    always_comb begin
        pixel_idx=4'd0;
        if(winX<=DrawX && DrawX< (winX+266) && winY<=DrawY && DrawY<(winY+64))
        begin
            pixel_idx=(DrawX-winX+(DrawY - winY)*266)%8;
        end
        pixel_data=4'h0;
        if(pixel_idx==4'd0)
        begin
            pixel_data=win_data[3:0];
        end
        else if(pixel_idx==4'd1)
        begin
            pixel_data=win_data[7:4];
        end
        else if(pixel_idx==4'd2)
        begin
            pixel_data=win_data[11:8];
        end
        else if(pixel_idx==4'd3)
        begin
            pixel_data=win_data[15:12];
        end
        else if(pixel_idx==4'd4)
        begin
            pixel_data=win_data[19:16];
        end
        else if(pixel_idx==4'd5)
        begin
            pixel_data=win_data[23:20];
        end
        else if(pixel_idx==4'd6)
        begin
            pixel_data=win_data[27:24];
        end
        else if(pixel_idx==4'd7)
        begin
            pixel_data=win_data[31:28];
        end
    end
    localparam [0:15][11:0] palette = {
	{4'hF, 4'hF, 4'hF},
	{4'h1, 4'h1, 4'h1},
	{4'hF, 4'hD, 4'h4},
	{4'h7, 4'h7, 4'h7},
	{4'hC, 4'hC, 4'hC},
	{4'h4, 4'h4, 4'h4},
	{4'hE, 4'hE, 4'hE},
	{4'hE, 4'hD, 4'h7},
	{4'hD, 4'hB, 4'h2},
	{4'h5, 4'h5, 4'h5},
	{4'hB, 4'hB, 4'hB},
	{4'hF, 4'hE, 4'hA},
	{4'h2, 4'h2, 4'h2},
	{4'h1, 4'h1, 4'h1},
	{4'h9, 4'h9, 4'h9},
	{4'hE, 4'hE, 4'hE}
};

    assign {Red, Green, Blue} = palette[pixel_data];
endmodule
