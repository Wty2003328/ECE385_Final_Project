`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2024 08:09:32 PM
// Design Name: 
// Module Name: apples
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

localparam NUM_AppleS = 4;
module apples(
        input   logic [9:0] DrawX, DrawY, 
        input   logic clk_125MHz,
        output   logic [9:0] AppleX[0:NUM_AppleS-1], AppleY[0:NUM_AppleS-1],
        output  logic [3:0]  Apple_Red, Apple_Green, Apple_Blue
    );
    assign AppleX = {9'd264,9'd270,9'd433,9'd30};       
    assign AppleY = {9'd180,9'd155,9'd47,9'd158};
    logic [31:0] Apple_data;
    logic [4:0] Apple_addr;
    logic [9:0] apple_X,apple_Y;
    always_comb begin
        Apple_addr = 8'b00000000;
        apple_X=10'h0;
        apple_Y=10'h0;
        for (int i = 0; i < NUM_AppleS; i++) 
        begin
            if (AppleX[i] <= DrawX && DrawX < (AppleX[i] + 5'd16) &&
                AppleY[i] <= DrawY && DrawY < (AppleY[i] + 5'd16)) 
                begin
                    apple_X=AppleX[i];
                    apple_Y=AppleY[i];
                    Apple_addr = (DrawX - apple_X + (DrawY - apple_Y) * 5'd16) >> 3;
                    break; 
                end
        end
    end
    
    apple_color_mapper Apple_color_instance(
        .Apple_data(Apple_data),
        .AppleX(apple_X),
        .AppleY(apple_Y),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .Red(Apple_Red),
        .Green(Apple_Green),
        .Blue(Apple_Blue)
    );
    
    blk_mem_gen_7 blk_Apple(
        .clka(clk_125MHz),      // Clock
        .wea(4'b0000),      // Write Enable for Port A
        .addra(Apple_addr),  // Address bus for Port A
        .dina(32'h00000000),   // Data input for Port A
        .douta(Apple_data), // Data output for Port A
        .ena(1'b1)
    );

endmodule
