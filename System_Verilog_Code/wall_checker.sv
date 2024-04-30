`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2024 02:55:33 PM
// Design Name: 
// Module Name: wall_checker
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


module wall_checker(
    input  logic   [9:0]   ManX, ManY,
    output logic wall_left,wall_right,wall_above
    );
    always_comb begin
        wall_left=1'b0;
        wall_right=1'b0;
        wall_above=1'b0;
        
        if(ManX>=80&&ManX<=388&&ManY==294)
        begin
            wall_above=1'b1;
        end
        
        if(ManX>=80&&ManX<=171&&ManY==175)
        begin
            wall_above=1'b1;
        end
        
        if(ManY>215&&ManX<=37)
        begin
            wall_left=1'b1;
        end
        
        if(215<ManY&&ManY<=293&&ManX>=76&&ManX<=90)
        begin
            wall_right=1'b1;
        end
        
        if(ManY>274&&ManX>=395)
        begin
           wall_right=1'b1; 
        end
        
        if(ManX==435)
        begin
           wall_right=1'b1;
        end
        
        if(235<ManY&&ManY<=293&&ManX<=392&&ManX>=380)
        begin
           wall_left=1'b1; 
        end
        
        if(215<ManY&&ManY<=293&&ManX<=372&&ManX>=352)
        begin
           wall_left=1'b1; 
        end
        
        if(ManX==0)
        begin
           wall_left=1'b1; 
        end
    end
endmodule
