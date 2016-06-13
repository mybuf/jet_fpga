

	`timescale 1ns/1ps
	/******************************************************\
		file		:	jet_sys_top.v
		module	: 	jet_sys_top
		company 	: 	
		
	\******************************************************/

	module jet_sys_top(
			input					clk_i								,
			input					reset_i							,	// not use
			
			input					spi_cs								,
			input					spi_sclk							,
			input					spi_miso							,
			output				spi_mosi							,
			output				fpga_int_out					,

			output				t_out
	) ;
	parameter Sim_Mode = 0 ;
	
	///////////////////////////////////////////////////////////////////////////////////////
	wire sysClk ;
	wire sysReset ;
	IBUFG #(
		.IOSTANDARD("DEFAULT")
	) IBUFG_inst (
		.O(sysClk), // Clock buffer output
		.I(clk_i)  // Clock buffer input (connect directly to top-level port)
	);
	
	reg [23:0]	countBase = 0 ;
	wire 			countBaseEnd  ;
	always @(posedge sysClk) begin
		if(!countBaseEnd)
			countBase <= #1 countBase + 1 ;
	end
	wire simCountEnd = countBase[3] ;
	wire workCountEnd = (countBase==24'hFFFF_FF)?1:0 ;
	assign countBaseEnd = (Sim_Mode==1)?simCountEnd : workCountEnd ;
	
	assign sysReset = !countBaseEnd ;
	
	////////////////////////////////////////////////////////////////////////////////////////
	
	wire				setWrEn			;
	wire	[15:0]	setWrAddr	;
	wire	[15:0]	setWrData		;
	
	wire				setRdEn			;
	wire	[15:0]	setRdAddr		;
	wire	[15:0]	setRdData		;
	
	spi_detect u1_net(
		.			clk_i					(		sysClk						)	,
		.			reset_i				(		sysReset					)	,
		
		.			spi_cs					(		spi_cs						)	,
		.			spi_sclk				(		spi_sclk					)	,
		.			spi_miso				(		spi_miso					)	,
		.			spi_mosi				(		spi_mosi					)	,
		
		.			set_wr_en			(		setWrEn					)	,
		.			set_wr_addr		(		setWrAddr				)	,
		.			set_wr_data		(		setWrData				)	,
		
		.			set_rd_en			(		setRdEn					)	,
		.			set_rd_addr		(		setRdAddr				)	,
		.			set_rd_data		(		setRdData				)	,

		.			t_out					(				)
	)		;
	
	
	wire	[15:0]		u2SetRdData			;
	wire					u2SetRdDataEn	;
	header u2_header(
		.			clk_i					(		sysClk						)	,
		.			reset_i				(		sysReset					)	,
	
		.			set_wr_en			(		setWrEn					)	,
		.			set_wr_addr		(		setWrAddr				)	,
		.			set_wr_data		(		setWrData				)	,
	
		.			set_rd_en			(		setRdEn					)	,
		.			set_rd_addr		(		setRdAddr				)	,
		.			set_rd_data		(		u2SetRdData			)	,
		.			set_rd_data_en	(		u2SetRdDataEn		)	,
	
		.			t_out					(										)
	) ;
	
	
	
	wire	[15:0]		u3SetRdData			;
	sram_ctrl u3_sram_ctrl(
		.			clk_i					(		sysClk						)	,
		.			reset_i				(		sysReset					)	,
	
		.			set_wr_en			(		setWrEn					)	,
		.			set_wr_addr		(		setWrAddr				)	,
		.			set_wr_data		(		setWrData				)	,
	
		.			set_rd_en			(		setRdEn					)	,
		.			set_rd_addr		(		setRdAddr				)	,
		.			set_rd_data		(		u3SetRdData			)	,
	
		.			t_out					(										)
	) ;
	
	
	
	wire			logicSetRdDataEn = u2SetRdDataEn	;
	wire [15:0]	logicSetRdData 	= u2SetRdData ;
	
	assign setRdData = (logicSetRdDataEn==1)?logicSetRdData : u3SetRdData ;
	
	
	endmodule 
