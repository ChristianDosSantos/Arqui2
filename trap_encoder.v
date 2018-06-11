module trap_encoder(wire inst_addr_mis_i, wire ile_instr_i, wire breakp_i, wire inst_acc_fault_i, wire load_addr_mis_i,
		 wire store_addr_mis_i, wire load_acc_fault_i, wire store_acc_fault_i, wire m_soft_int_i,
		 wire m_timer_int_i, wire m_ext_int_i, reg mcause_o[31:0], reg trap_o )

@always(*)
begin
	if (inst_addr_mis_i==1) begin
		mcause_o=4'h0000;
        trap_o=1'b1;
	end else if (ile_instr_i==1) begin
		mcause_o=4'h0002;
        trap_o=1'b1;
    end else if (breakp_i==1) begin
		mcause_o=4'h0003;
        trap_o=1'b1;
    end else if (inst_acc_fault_i==1) begin
		mcause_o=4'h0001;
        trap_o=1'b1;
    end else if (load_addr_mis_i==1) begin
		mcause_o=4'h0004;
        trap_o=1'b1;
    end else if (store_addr_mis_i==1) begin
		mcause_o=4'h0006;
        trap_o=1'b1;
    end else if (load_acc_fault_i==1) begin
		mcause_o=4'h0005;
        trap_o=1'b1;
    end else if (store_acc_fault_i==1) begin
		mcause_o=4'h0007;
        trap_o=1'b1;
    end else if (m_soft_int_i==1) begin
		mcause_o=4'h8003;
        trap_o=1'b1;
    end else if (m_timer_int_i==1) begin
		mcause_o=4'h8007;
        trap_o=1'b1;
    end else if (m_ext_int_i==1) begin
		mcause_o=4'h80b;
        trap_o=1'b1;
    end else begin
    	mcause_o=4'h0000;
    	trap_o=1'b0;
    end
end

endmodule