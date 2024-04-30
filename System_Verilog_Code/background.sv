`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2024 06:31:21 PM
// Design Name: 
// Module Name: background
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


module background(
        input   logic [9:0] DrawX, DrawY, 
        input   logic clk_125MHz,
        output  logic [3:0]  Bkg_Red, Bkg_Green, Bkg_Blue
    );
    logic [31:0] background_data;
    logic [15:0] background_addr;
    assign background_addr=(DrawX+DrawY*480)>>3;
    background_color_mapper bg_color_instance(
        .background_data(background_data),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .Red(Bkg_Red),
        .Green(Bkg_Green),
        .Blue(Bkg_Blue)
    );
    
    blk_mem_gen_0 blk_bkg(
        .clka(clk_125MHz),      // Clock
        .wea(4'b0000),      // Write Enable for Port A
        .addra(background_addr),  // Address bus for Port A
        .dina(32'h00000000),   // Data input for Port A
        .douta(background_data), // Data output for Port A
        .ena(1'b1)
    );
endmodule
