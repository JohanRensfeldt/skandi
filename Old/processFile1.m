function processFile1(inputFile, outputFile)

    % Read the file
    fid = fopen(inputFile, 'r');
    data = textscan(fid, '%s', 'Delimiter', '\n', 'WhiteSpace', '');
    fclose(fid);
    data = data{1};

    % Flag for marking the start of data lines
    isData = false;

    % Process each line
    for j = 1:length(data)
        % Split the line into numbers
        lineSplit = strsplit(data{j});
        numbers = str2double(lineSplit(~cellfun(@isempty, lineSplit)));

        % If all elements are numbers, then this is a data line
        if all(~isnan(numbers))
            isData = true;
        end

        % If this is not a data line, skip it
        if ~isData
            continue;
        end

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
