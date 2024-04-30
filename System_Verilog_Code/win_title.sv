`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2024 12:07:04 AM
// Design Name: 
// Module Name: win_title
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


module win_title(
input   logic [9:0] DrawX, DrawY, 
    input   logic clk_125MHz,
    output  logic [9:0] WinX, WinY,
    output  logic [3:0]  Win_Red, Win_Green, Win_Blue
    );
    logic [31:0] win_data;
    logic [11:0] win_addr;
    assign WinX=107;
    assign WinY=100;
    always_comb begin
        win_addr = 12'd0;
        if(WinX<=DrawX && DrawX< (WinX+266) && WinY<=DrawY && DrawY<(WinY+64))
        begin
            win_addr = (DrawX - WinX+ (DrawY - WinY)*266)/8 ;
        end
    end
    
    win_color_palette win_color_instance(
        .win_data(win_data),
        .winX(WinX),
        .winY(WinY),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .Red(Win_Red),
        .Green(Win_Green),
        .Blue(Win_Blue)
    );
    
    blk_mem_gen_8 blk_win(
        .clka(clk_125MHz),      // Clock
        .wea(4'b0000),      // Write Enable for Port A
        .addra(win_addr),  // Address bus for Port A
        .dina(32'h00000000),   // Data input for Port A
        .douta(win_data), // Data output for Port A
        .ena(1'b1)
    );
endmodule