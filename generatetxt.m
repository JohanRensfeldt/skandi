% Loop to create ten files
for n = 1:10
    % Create a matrix with random integers from 1 to 100
    data = randi(100, 5, 10);
    
    % Define the file name, and the iteration variable n
    filename = sprintf('random_numbers_%d.txt', n);
    
    % Open the file for writing
    fid = fopen(filename, 'wt');
    
    % Loop over rows
    for i = 1:size(data, 1)
        % Loop over the columns
        for j = 1:size(data, 2)
            % Write the current number with random number (1-4) of spaces after it
            fprintf(fid, ['%d', repmat(' ', 1, randi(4))], data(i, j));
        end
        % Add a new line at the end of each row
        fprintf(fid, '\n');
    end
    
    % Close the file
    fclose(fid);
end
