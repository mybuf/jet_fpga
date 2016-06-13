
	`timescale 1ns/1ps

	module spi_detect(
			input					clk_i		,
			input					reset_i	,	// not use
			
			input					spi_cs		,
			input					spi_sclk		,
			input					spi_miso	,
			output				spi_mosi	,
			output				fpga_int_out		,
			
			
			output					set_wr_en		            ,
			output		[15:0]	set_wr_addr	            ,
			output		[15:0]	set_wr_data	            ,
			
			output					set_rd_en		            ,
			output		[15:0]	set_rd_addr	            ,
			input			[15:0]	set_rd_data	            ,

			output				t_out
	) ;
	
	
	parameter Sim_Mode = 0 ;
	
	reg		[7:0]	sclkShift = 0 ;
	wire				sclkPos0 , sclkPos1,sclkPos2,sclkPos3,sclkPos4	;
	reg		[63:0]	dataShift = 0 ;
	reg 	[7:0]	bitCount = 0 ;
	wire 				wordFlag		;
	reg		[15:0]	wordCount = 0 ;
	wire 				headFlag ; // 命令标识
	
	reg [15:0]	baseAddr = 0 ;
	reg 			rwFlag = 0 ;
	
	// 检测时钟边沿
	always @(posedge clk_i) begin
		if(reset_i)
			sclkShift <= #1 0 ;
		else 
			sclkShift <= #1 {sclkShift[7:0],spi_sclk}	;
	end
	
	assign sclkPos0	= (sclkShift[0]==0&&spi_sclk==1)?1:0	;
	assign sclkPos1	= (sclkShift[1:0]==2'b01)?1:0	;
	assign sclkPos2	= (sclkShift[2:1]==2'b01)?1:0	;
	assign sclkPos3	= (sclkShift[3:2]==2'b01)?1:0	;
	assign sclkPos4	= (sclkShift[4:3]==2'b01)?1:0	;
	
	assign sclkNeg1 = (sclkShift[1:0]==2'b10)?1:0	;
	assign sclkNeg2 = (sclkShift[2:1]==2'b10)?1:0	;
	assign sclkNeg3 = (sclkShift[3:2]==2'b10)?1:0	;
	assign sclkNeg4 = (sclkShift[4:3]==2'b10)?1:0	;
	
	// 锁存输入数据
	always @(posedge clk_i) begin
		if(reset_i)
			dataShift <= #1 0 ;
		else if(spi_cs==0 && sclkPos0==1)
			dataShift <= #1 {dataShift[62:0],spi_miso} ;
	end
	
	/// 记录比特数
	always @(posedge clk_i) begin 
		if(reset_i)
			bitCount <= #1 0 ;
		else if(spi_cs)
			bitCount <= #1 0 ;
		else if(wordFlag)
			bitCount <= #1 0 ;
		else if(sclkPos0)
			bitCount <= #1 bitCount +1 ;
	end
	
	assign wordFlag = bitCount[4] ;
	
	/// 记录数据长度
	always @(posedge clk_i) begin
		if(reset_i)
			wordCount <= #1 0 ;
		else if(spi_cs)
			wordCount <= #1 0 ;
		else if(wordFlag)
			wordCount <= #1 wordCount + 1 ;
	end
	
	// 包头标识
	assign headFlag = (wordCount==0&&wordFlag==1)?1: 0;
	
	// 锁存包头命令内容
	always @(posedge clk_i) begin 
		if(reset_i) begin
			rwFlag <= #1 0 ;
			baseAddr <= #1 1 ;
		end
		else if(spi_cs) begin
			rwFlag <= #1 0 ;
			baseAddr <= #1 1 ;
		end
		else if(headFlag) begin
			rwFlag <= #1 dataShift[15] ; //获取读写标识位
			baseAddr <= #1 dataShift[14:0]	; // 获取操作基本地址
		end
	end
	
	
	reg [3:0]	wordFlagDelay = 0 ;
	always @(posedge clk_i) begin
		if(reset_i)
			wordFlagDelay <= #1 0 ;
		else 
			wordFlagDelay <= #1 {wordFlagDelay[2:0],wordFlag}	;
	end
	
	reg [16:0]	dataRdShift  = 0 ;
	always @(posedge clk_i) begin
		if(reset_i)
			dataRdShift <= #1 0 ;
		else if(wordFlagDelay[2])
			dataRdShift <= #1 {set_rd_data[15],set_rd_data[15:0]} ;
		else if(sclkNeg1==1)
			dataRdShift <= #1 {dataRdShift[15:0],1'b0}	;
	end
	
	
	wire	[16:0]	set_addr_cal = baseAddr + wordCount - 1 ;
	
	
	// 写数据
	assign set_wr_en = rwFlag & wordFlag & (!set_addr_cal[16]);
	assign set_wr_addr = set_addr_cal[15:0]	;
	assign set_wr_data = dataShift[15:0]	;
	
	// 读数据
	assign set_rd_en = 0 ;
	assign set_rd_addr = baseAddr + wordCount - 1 ;
	assign spi_mosi = dataRdShift[16] ;
	
	
	endmodule 
