function state = shift_rows(input_state)
state = input_state;
start_index = 1;
end_index = 8;
for i = 1:4
     if(i == 1)
          state(i,:) = input_state(i,:); %%%%%% the first word is not shifted %%%%%%%
     else
        state(i,:) = [input_state(i,end_index+1:32) input_state(i,start_index:end_index)];
        end_index = end_index + 8; %%% increase shifted bytes each cycle and start index will 
    % be fixed in the RHS of the concatenation
     end 
end 
end 