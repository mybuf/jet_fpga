
	`timescale 1ns/1ps

	module header(
			input											clk_i		,
			input											reset_i	,	// not use
						
			input											set_wr_en		            ,
			input					[15:0]				set_wr_addr	            ,
			input					[15:0]				set_wr_data	            ,
									
			input											set_rd_en		            ,
			input					[15:0]				set_rd_addr	            ,
			output	reg		[15:0]				set_rd_data	            ,
			output	reg								set_rd_data_en			,

			output									t_out
	) ;
	
	parameter Sim_Mode = 0 ;
	
	parameter	[15:0]	ADDR_STATUS		=	16'H0000	;
	parameter	[15:0]	ADDR_NRESET		=	16'H0001	;
	parameter	[15:0]	ADDR_JETNUM		=	16'H0010	;
	
	parameter	[15:0]	ADDR_STADDR		=	16'H0011	;
	parameter	[15:0]	ADDR_DATAROW	=	16'H0012	;
	parameter	[15:0]	ADDR_DATACOL		=	16'H0013	;
	
	reg	[15:0]		cpldStatus = 0 ;
	reg	[15:0]		nResetLogic = 0 ;
	reg	[15:0]		jetNum = 0 ;
	reg	[15:0]		dataStAddr = 0 ;
	reg	[15:0]		dataRow = 0 ;
	reg	[15:0]		dataCol = 0 ;
	always @(posedge clk_i) begin
		if(reset_i) begin
			cpldStatus 			<= #1 0 		;
			nResetLogic 		<= #1 0 		;
			jetNum 				<= #1 0 		;
			dataStAddr 		<= #1 0 		;
			dataRow 			<= #1 0 		;
			dataCol 				<= #1 0 		;
		end
		else if(set_wr_en)	begin // write
			case(set_wr_addr)
				ADDR_STATUS		: cpldStatus 		<= #1	set_wr_data     ; 
				ADDR_NRESET		: nResetLogic 	<= #1	set_wr_data     ; 
				ADDR_JETNUM		: jetNum 			<= #1	set_wr_data     ; 
				ADDR_STADDR		: dataStAddr 	<= #1	set_wr_data     ; 
				ADDR_DATAROW	: dataRow 			<= #1	set_wr_data     ; 
				ADDR_DATACOL		: dataCol 			<= #1	set_wr_data     ; 
				default		:	;
			endcase
		end
	end
	
	always @(posedge clk_i) begin
		if(reset_i)
			set_rd_data <= #1 0 ;
		else 
			case(set_rd_addr)
				ADDR_STATUS		:		begin set_rd_data <= #1	cpldStatus 			;		set_rd_data_en <= #1 1 ;	end
				ADDR_NRESET		:		begin set_rd_data <= #1	nResetLogic 		;		set_rd_data_en <= #1 1 ;	end
				ADDR_JETNUM		:		begin set_rd_data <= #1	jetNum 				;		set_rd_data_en <= #1 1 ;	end
				ADDR_STADDR		:		begin set_rd_data <= #1	dataStAddr 		;		set_rd_data_en <= #1 1 ;	end
				ADDR_DATAROW	:		begin set_rd_data <= #1	dataRow 			;		set_rd_data_en <= #1 1 ;	end
				ADDR_DATACOL		:		begin set_rd_data <= #1	dataCol 				;		set_rd_data_en <= #1 1 ;	end
				default	:	set_rd_data_en <= #1 0 ;
			endcase
	end
	
	
	
	
	
	endmodule 
