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
`define SIGNAL_SIZE	32

module FIR_filter_tb;
	integer 						inFile, outFile;
	reg	signed 	[`SIGNAL_SIZE - 1:0] 	inData;
	wire	signed	[`SIGNAL_SIZE - 1:0]	outData;
	reg 							clk, rst,start_f, stop_f;
	reg			[2:0]				startCount, stopCount;

	// Instantiation of FIR_filter module
	FIR_filter #(.signalSize(`SIGNAL_SIZE)) myFilter (outData, inData, clk, rst);

	// Clock generation
	initial begin
		clk = 0;
		forever #10 clk = ~clk;
	end

	// Reset signal
	initial begin
			inData = 0;
			stop_f = 0;
			start_f = 0;
			startCount = 5;
			stopCount = 4;
			rst = 1;
		#30 	rst = 0;
	end

	// Open input and output files 
	initial begin
		inFile 	= $fopen ("../Noisy Signal.dat", "r");
		outFile	= $fopen ("../Filtered Signal.dat", "w");
	end

	// Read inData from inFile and write outData in outFile
	initial begin
		@(negedge rst); // Wait until reset signal (rst) go from HIGH to LOW
		forever @(posedge clk) begin
			startCount = startCount - 1;
			
			if(startCount == 0) start_f = 1;
			
			if(~stop_f)
				if ($fscanf(inFile , "%d\n", inData) == -1)
					stop_f = 1;
			
			if(start_f) $fwrite(outFile, "%d\n", (outData / 10)); //Filter coefficients: 1 + 2  + 4 + 2 + 1 = 10
			
			if(stop_f) begin
				inData = 0;
				stopCount = stopCount - 1;
			end

			if(stopCount == 0) begin
				$fclose(inFile);
				$fclose(outFile);
				$stop;
			end
		end
	end
endmodule
