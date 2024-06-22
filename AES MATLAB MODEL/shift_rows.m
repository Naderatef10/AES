%shift_rows is part of the AES algorithm 
%the shift_rows function takes the state matrix as input 
%the shift_rows matrix perform cyclic shifted with number of bytes shifted equals the row index
%therefore the first row of bytes is not shifted and is kept the same

function state = shift_rows(input_state)
state = input_state;
start_index = 1;
end_index = 8;
for i = 1:4
    %the first row of bytes (i==1) is not shifted and is kept the same
     if(i == 1)
          state(i,:) = input_state(i,:); %%%%%% the first word is not shifted %%%%%%%
     else
        state(i,:) = [input_state(i,end_index+1:32) input_state(i,start_index:end_index)];
        end_index = end_index + 8; %%% increase shifted bytes each cycle and start index will 
    % be fixed in the RHS of the concatenation
     end 
end 
state_hexa_decimal = binary_matrix_hexa(state);
end 