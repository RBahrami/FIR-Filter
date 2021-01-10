/*
 * MIT License
 * 
 * Copyright (c) 2021 Reza Bahrami
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

/* 
 * FIR low pass filter
 * AUTHOR : Reza Bahrami
 * Email : r.bahrami.work@outlook.com
 */
 
`timescale 1ns/100ps
`default_nettype none
// FIR filter
module FIR_filter(y, x, clk, rst);
	parameter 	signalSize 	= 8;
	output	wire	signed [signalSize - 1:0] 	y;
	input		wire	signed [signalSize - 1:0] 	x;
	input 	wire						clk, rst;
	reg 			[signalSize - 1:0]		R[4:0];
	always @(posedge clk)
		if (rst) begin // Reset Register Map
			R[0] <= 0;
			R[1] <= 0;
			R[2] <= 0;
			R[3] <= 0;
			R[4] <= 0;
		end
		else begin	// Shift Register Map to Right
			R[0] <= R[1];
			R[1] <= R[2];
			R[2] <= R[3];
			R[3] <= R[4];
			R[4] <= x;
		end
	assign y = R[4] + (R[3] << 1) + (R[2] << 2) + (R[1] << 1) + R[0]; // y = R[4] + 2R[3] + 4R[2] + 2R[1] + R[0]
endmodule
