`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2024 09:26:50 PM
// Design Name: 
// Module Name: on_ground_checker
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


module on_ground_checker(
    input  logic   [9:0]   ManX, ManY,
    output logic on_ground
    );
    always_comb begin
        on_ground=1'b0;
        if(0<=ManX&&ManX<=33&&ManY==215)
        begin
            on_ground=1'b1;
        end
        else if(31<=ManX&&ManX<=400&&ManY==314)
        begin
            on_ground=1'b1;
        end
        else if(81<=ManX&&ManX<=367&&ManY==215)
        begin
           on_ground=1'b1; 
        end
        else if(368<=ManX&&ManX<=387&&ManY==235)
        begin
           on_ground=1'b1; 
        end
        else if(400<=ManX&&ManX<=435&&ManY==274)
        begin
           on_ground=1'b1; 
        end
    end
endmodule
