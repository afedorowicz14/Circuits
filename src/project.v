/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_afedorowicz14 (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

reg [3:0] a;
assign a = ui_in[7:4];
reg [3:0] b;
assign b = ui_in[3:0];
reg [2:0] ALUOP;
assign ALUOP = uio_in[2:0];
reg [7:0] result;
assign uo_out = result;

always @(posedge clk)begin
  case (ALUOP)
    3'b000:begin
    result = a + b;
    end

    3'b001:begin
    result = a - b;
    end

    3'b010:begin
    result = a * b;
    end

    3'b011:begin
    result = a / b;
    end

    3'b100:begin
    result = a & b;
    end

    3'b101:begin
    result = a | b;
    end
  endcase
end
  // All output pins must be assigned. If not used, assign to 0.
  
  //List all unused inputs to prevent warnings
  wire _unused = &{ena, rst_n, uio_in[7:3]};

endmodule