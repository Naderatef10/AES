%add_round_key is a step in the AES-128 algorithm 
% inputs: 1)the state matrix of the algorithm 2)the key of this round of the AES algorithm 
function state = add_round_key(state,key)
%bitwise xor is done between the state and the key 
state = xor(state,key);
hexa_decimal_state = binary_matrix_hexa(state);
end 