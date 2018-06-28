module main_decoder (input wire opcode_i, input wire func3_i, input wire eq_i, input wire lt_i, 
					  input wire ltu_i, output reg PC_control_o, output reg ctrl_muxa_o, 
					  output reg ctrl_muxb_o, output reg ctrl_muxcsr_o, output reg ctrl_muxj_o,
					  output reg type_imm_o, output reg rf_we_wb_o, output reg alu_op_ex_o,
					  output reg we_mem_ctrl_o, output reg data_or_alu_ctrl_o, 
					  output reg mux_sel_o, output reg csr_op_o, output reg func3_o,
					  output reg is_LS_mem_ctrl_o);

@always(*)
begin
	if (opcode_i == 7'b0110111) //LUI
		begin
		PC_control_o = 1'h0;
		ctrl_muxa_o = 1'h2;
		ctrl_muxb_o = 1'h1;
		ctrl_muxcsr_o = 1'h0;
		ctrl_muxj_o = 1'h0;
		type_imm_o = 1'h0;
        rf_we_wb_o = 1'h1;
        alu_op_ex_o = 1'h0;
        we_mem_ctrl_o = 1'h0;
        data_or_alu_ctrl_o = 1'h1;
        mux_sel_o = 1'h1;
        csr_op_o = 1'h0;
        func3_o = func3_i;
        is_LS_mem_ctrl_o = 1'h0;
		end
	else if (opcode_i==7'b1101111) //JAL
		begin
		PC_control_o = 1'h1;
		ctrl_muxa_o = 1'h1;
		ctrl_muxb_o = 1'h1;
		ctrl_muxcsr_o = 1'h0;
		ctrl_muxj_o = 1'h1;
		type_imm_o = 1'h3;
        rf_we_wb_o = 1'h1;
        alu_op_ex_o = 1'h0;
        we_mem_ctrl_o = 1'h0;
        data_or_alu_ctrl_o = 1'h1;
        mux_sel_o = 1'h1;
        csr_op_o = 1'h0;
        func3_o = func3_i;
        is_LS_mem_ctrl_o = 1'h0;
		end
	else if (opcode_i==7'b1100011) //branch
		begin
		case (func3_i)
			3'b000: begin  //BEQ
				PC_control_o = eq_i ? 1'h0:1'h1;
				ctrl_muxa_o = 1'h1;
				ctrl_muxb_o = 1'h1;
				ctrl_muxcsr_o = 1'h0;
				ctrl_muxj_o = 1'h1;
				type_imm_o = 1'h2;
        		rf_we_wb_o = 1'h0;
        		alu_op_ex_o = 1'h0;
        		we_mem_ctrl_o = 1'h0;
        		data_or_alu_ctrl_o = 1'h1;
        		mux_sel_o = 1'h1;
        		csr_op_o = 1'h0;
        		func3_o = func3_i;
        		is_LS_mem_ctrl_o = 1'h0;
			end
			3'b100: begin //BLT
				PC_control_o = lt_i ? 1'h0:1'h1;
				ctrl_muxa_o = 1'h1;
				ctrl_muxb_o = 1'h1;
				ctrl_muxcsr_o = 1'h0;
				ctrl_muxj_o = 1'h1;
				type_imm_o = 1'h2;
        		rf_we_wb_o = 1'h0;
        		alu_op_ex_o = 1'h0;
        		we_mem_ctrl_o = 1'h0;
        		data_or_alu_ctrl_o = 1'h1;
        		mux_sel_o = 1'h1;
        		csr_op_o = 1'h0;
        		func3_o = func3_i;
        		is_LS_mem_ctrl_o = 1'h0;
			end
			3'b110: begin //BLTU
				PC_control_o = ltu_i ? 1'h0:1'h1;
				ctrl_muxa_o = 1'h1;
				ctrl_muxb_o = 1'h1;
				ctrl_muxcsr_o = 1'h0;
				ctrl_muxj_o = 1'h1;
				type_imm_o = 1'h2;
        		rf_we_wb_o = 1'h0;
        		alu_op_ex_o = 1'h0;
        		we_mem_ctrl_o = 1'h0;
        		data_or_alu_ctrl_o = 1'h1;
        		mux_sel_o = 1'h1;
        		csr_op_o = 1'h0;
        		func3_o = func3_i;
        		is_LS_mem_ctrl_o = 1'h0;
			end
		endcase
		end
	else if (opcode_i==7'b0000011) //load
		begin
			PC_control_o = 1'h0;
			ctrl_muxa_o = 1'h0;
			ctrl_muxb_o = 1'h1;
			ctrl_muxcsr_o = 1'h0;
			ctrl_muxj_o = 1'h0;
			type_imm_o = 1'h1;
        	rf_we_wb_o = 1'h1;
        	alu_op_ex_o = 1'h0;
       		we_mem_ctrl_o = 1'h0;
       		data_or_alu_ctrl_o = 1'h0;
       		mux_sel_o = 1'h1;
       		csr_op_o = 1'h0;
       		func3_o = func3_i;
       		is_LS_mem_ctrl_o = 1'h0;
		end
	else if (opcode_i==7'b0010011) //ADDI ORI
		begin
		case (func3_i)
			3'b000: begin  //ADDI
				PC_control_o = 1'h0;
				ctrl_muxa_o = 1'h0;
				ctrl_muxb_o = 1'h1;
				ctrl_muxcsr_o = 1'h0;
				ctrl_muxj_o = 1'h0;
				type_imm_o = 1'h6;
        		rf_we_wb_o = 1'h1;
        		alu_op_ex_o = 1'h0;
        		we_mem_ctrl_o = 1'h0;
        		data_or_alu_ctrl_o = 1'h1;
        		mux_sel_o = 1'h1;
        		csr_op_o = 1'h0;
        		func3_o = func3_i;
        		is_LS_mem_ctrl_o = 1'h0;
			end
			3'b100: begin //BLT
				PC_control_o = 1'h0;
				ctrl_muxa_o = 1'h0;
				ctrl_muxb_o = 1'h1;
				ctrl_muxcsr_o = 1'h0;
				ctrl_muxj_o = 1'h0;
				type_imm_o = 1'h6;
        		rf_we_wb_o = 1'h1;
        		alu_op_ex_o = 1'h3;
        		we_mem_ctrl_o = 1'h0;
        		data_or_alu_ctrl_o = 1'h1;
        		mux_sel_o = 1'h1;
        		csr_op_o = 1'h0;
        		func3_o = func3_i;
        		is_LS_mem_ctrl_o = 1'h0;	
			end
		endcase
	    end
	    else begin
	    	PC_control_o = 1'h0;
			ctrl_muxa_o = 1'h0;
			ctrl_muxb_o = 1'h0;
			ctrl_muxcsr_o = 1'h0;
			ctrl_muxj_o = 1'h0;
			type_imm_o = 1'h0;
       		rf_we_wb_o = 1'h0;
      		alu_op_ex_o = 1'h0;
       		we_mem_ctrl_o = 1'h0;
       		data_or_alu_ctrl_o = 1'h0;
       		mux_sel_o = 1'h0;
       		csr_op_o = 1'h0;
       		func3_o = 3'b000;
       		is_LS_mem_ctrl_o = 1'h0;
	    end
end

endmodule