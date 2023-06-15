% Loop to create ten files
for n = 1:10
    % Create a matrix with random integers from 1 to 100
    data = randi(100, 5, 10);
    
    % Define the file name, including the iteration variable n
    filename = sprintf('random_numbers_%d.txt', n);
    
    % Open the file for writing
    fid = fopen(filename, 'wt');
    
    % Add 10 lines of random text at the top of the file
    for i = 1:10
        % Generate a line of 10 random characters (numbers and letters)
        randomChars = char(randi([48, 122], 1, 10));  % ASCII codes 48-57 are numbers, 97-122 are lowercase letters
        fprintf(fid, '%s\n', randomChars);
    end
    
    % Loop over the rows
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
