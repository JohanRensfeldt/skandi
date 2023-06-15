function processFolder()

inputFolderPath = 'random_numbers';

% Get a list of all .opg files in the folder
files = dir(fullfile(inputFolderPath, '*.txt'));

% Process each file
for i = 1:length(files)
    inputFile = fullfile(inputFolderPath, files(i).name);

    % Generate the output file name
    [pathstr, name, ext] = fileparts(inputFile);
    outputFile = fullfile(pathstr, [name '_processed' ext]);

    % Read the file
    fid = fopen(inputFile, 'r');
    data = textscan(fid, '%s', 'Delimiter', '\n', 'WhiteSpace', '');
    fclose(fid);
    data = data{1};

    % Process each line
    for j = 1:length(data)
        % Split the line into numbers
        lineSplit = strsplit(data{j});
        numbers = str2double(lineSplit(~cellfun(@isempty, lineSplit)));

        % Create a new line with the numbers formatted as strings of width 4, 
        % followed by a comma and four spaces for all but the last number
        newLine = '';
        for k = 1:length(numbers)
            if k == length(numbers)
                newLine = [newLine, sprintf('%4d', numbers(k))];
            else
                newLine = [newLine, sprintf('%4d,    ', numbers(k))];
            end
        end

        % Replace the line in the data
        data{j} = newLine;
    end

    % Write the modified data to the output file
    fid = fopen(outputFile, 'w');
    for j = 1:length(data)
        fprintf(fid, '%s\n', data{j});
    end
    fclose(fid);
end

end
