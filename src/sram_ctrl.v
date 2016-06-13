

	`timescale 1ns/1ps
	/******************************************************\
		file		:	sram_ctrl.v
		module	: 	sram_ctrl
		company 	: 	
		
	\******************************************************/

	module sram_ctrl(
			input											clk_i							,
			input											reset_i						,	// not use

			input											set_wr_en		            ,
			input					[15:0]				set_wr_addr	            ,
			input					[15:0]				set_wr_data	            ,
									
			input											set_rd_en		            ,
			input					[15:0]				set_rd_addr	            ,
			output				[15:0]				set_rd_data	            ,
			
			output										t_out
	) ;
	parameter Sim_Mode = 0 ;
	
	wire [15:0]	opRdAddr = set_rd_addr	;
	
	sram_16384x16 sram(
		 .						clka			(			clk_i									)						,
		 .						wea			(			set_wr_en							)						,
		 .						addra		(			set_wr_addr						)						,
		 .						dina		(			set_wr_data						)						,
		 .						douta		(														)						,
		 
		 .						clkb			(			clk_i									)						,
		 .						web			(			0											)						,
		 .						addrb		(			opRdAddr							)						,
		 .						dinb		(			0											)						,
		 .						doutb       (			set_rd_data						)
	);
	
	
	endmodule 
