`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2024 01:32:09 PM
// Design Name: 
// Module Name: game_over_word
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


module game_over_word(
    input   logic [9:0] DrawX, DrawY, 
    input   logic clk_125MHz,
    output  logic [9:0] OverX, OverY,
    output  logic [3:0]  Over_Red, Over_Green, Over_Blue
    );
    logic [31:0] over_data;
    logic [11:0] over_addr;
    assign OverX=80;
    assign OverY=100;
    always_comb begin
        over_addr = 12'd0;
        if(OverX<=DrawX && DrawX< (OverX+320) && OverY<=DrawY && DrawY<(OverY+64))
        begin
            over_addr = ((DrawX - OverX)+ (DrawY - OverY)*320)/8 ;
        end
    end
    
    over_color_mapper over_color_instance(
        .Over_data(over_data),
        .OverX(OverX),
        .OverY(OverY),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .Red(Over_Red),
        .Green(Over_Green),
        .Blue(Over_Blue)
    );
    
    blk_mem_gen_3 blk_over(
        .clka(clk_125MHz),      // Clock
        .wea(4'b0000),      // Write Enable for Port A
        .addra(over_addr),  // Address bus for Port A
        .dina(32'h00000000),   // Data input for Port A
        .douta(over_data), // Data output for Port A
        .ena(1'b1)
    );
endmodule
