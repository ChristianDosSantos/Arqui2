module LSmis (wire addr_i[1:0],wire inst[1:0],reg exc):

@always(*)
begin
	case(inst)
		2'b00: exc = addr_i[0];
		2'b01: exc = addr_i[0]|addr_i[1];
		default: exc=0;
    endcase
end

endmodule