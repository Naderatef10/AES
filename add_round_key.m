function state = add_round_key(state,key)
state = xor(state,key);
end 