function hexMatrix = Convert_string_to_matrix(input_hexa)
% Hexadecimal string
hexStr = char(input_hexa);

% Split the string into pairs of two hexadecimal digits
hexPairs = cellstr(reshape(hexStr, 2, [])');

% Convert to a matrix (4x4) filled column-wise
hexMatrix = reshape(hexPairs, 4, 4);

hexMatrix=string(hexMatrix)

end 