function hexStr = Matrix_to_hex_string(hexMatrix)
    % Initialize an empty string to hold the concatenated result
    hexStr = '';

    % Get the number of columns in the matrix
    [rows, cols] = size(hexMatrix);

    % Iterate over each column
    for col = 1:cols
        % Iterate over each row in the current column
        for row = 1:rows
            % Concatenate the current element to the result string
            hexStr = strcat(hexStr, hexMatrix(row, col));
        end
    end
end