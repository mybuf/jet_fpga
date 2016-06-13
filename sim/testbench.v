

	`timescale 1ns/1ps

	module testbench;
	
	
	reg			clk_i			               ;
	reg			reset_i		               ;
	reg			spi_cs		                   ;
	reg			spi_sclk	                   ;
	wire			spi_miso	                   ;
	wire			spi_mosi	                   ;
	
	wire				set_wr_en			;
	wire	[15:0]	set_wr_addr		;
	wire	[15:0]	set_wr_data		;
	
	wire				set_rd_en		;
	wire	[15:0]	set_rd_addr	;
	wire	[15:0]	set_rd_data	= 16'h1234;
	
	
	initial begin
		clk_i = 0 ;
		forever begin
			#10 clk_i = !clk_i ;
		end	
	end
	
	reg [255:0]	dataBuf = {16'h0000,16'h0000,16'h0000,16'h0000,16'h0000,16'h0000,16'h0000,16'h0000,
												16'h0000,16'h0000,16'h0000,16'h0000,16'h0000,16'h0000,16'h0000,16'h0000} ;
	assign spi_miso = dataBuf[255] ;
	
	
	
	task spi_sclk_task ;
	begin
		#({$random}%50+100) 
		spi_sclk = 0 ;
		#({$random}%50+100) 
		spi_sclk = 1 ;
		#({$random}%50+100) 
		spi_sclk = 0 ;
	end
	endtask
	
	task spi_task ;
		input [14:0] dataLen ;
		begin
			spi_cs = 0 ;	
			repeat(dataLen) begin
				repeat(16) begin
					spi_sclk_task;
					dataBuf = {dataBuf[255:0],1'b0} ;
				end
			end
			spi_cs = 1 ;
			repeat(22) @(posedge clk_i) ;
		end
	endtask
	
	
	initial begin
		reset_i = 1 ;
		spi_cs = 1 ;	
		spi_sclk = 0 ;
		#123
		reset_i = 0 ;
		repeat(20) @(posedge clk_i) ;
		#1 
		
		
	//	dataBuf = {16'h8001,16'h0002,16'h0004,16'h0006,16'h0300,16'h000a,16'h0000,16'h0000,16'h0000,16'h0000,16'h0000,16'h0000,16'h0000,16'h0000,16'h0000,16'h0000} ;
	//	spi_task(2);
	//	dataBuf = {16'h0001,16'h0002,16'h0004,16'h0006,16'h0300,16'h000a,16'h0000,16'h0000,16'h0000,16'h0000,16'h0000,16'h0000,16'h0000,16'h0000,16'h0000,16'h0000} ;
	//	spi_task(2);
		
		dataBuf = {16'h8040,16'h1234,16'h4321,16'h0006,16'h0300,16'h000a,16'h0000,16'h0000,16'h0000,16'h0e00,16'h0f00,16'h0500,16'h0010,16'h0000,16'h0300,16'h00ad} ;
		spi_task(20);
		dataBuf = {16'h0040,16'h0002,16'h0004,16'h0006,16'h0300,16'h000a,16'h0000,16'h0000,16'h0000,16'h0000,16'h0000,16'h0000,16'h0000,16'h0000,16'h0000,16'h0000} ;
		spi_task(20);
	
		$stop ;
		
	end
	
	jet_sys_top u1_net(
		.			clk_i					(		clk_i					)	,
		.			reset_i				(		reset_i				)	,
		                                                
		.			spi_cs					(		spi_cs					)	,
		.			spi_sclk				(		spi_sclk				)	,
		.			spi_miso				(		spi_miso				)	,
		.			spi_mosi				(		spi_mosi				)	,
		
		.			t_out					(		t_out					)
	)		;
	defparam u1_net.Sim_Mode = 1 ;
	
	endmodule 
