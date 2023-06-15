function processFile3(inputFile, outputFile, startLine, endLine)

    % Read the file
    fid = fopen(inputFile, 'r');
    data = textscan(fid, '%s', 'Delimiter', '\n', 'WhiteSpace', '');
    fclose(fid);
    data = data{1};

    % Define function to split line into numbers
    splitNumbers = @(line) str2double(strsplit(line));

    % Create new lines for data lines and replace data lines in the data
    for j = startLine:endLine
        numbers = splitNumbers(data{j});
        newLine = '';
        for k = 1:length(numbers)
            if isnan(numbers(k))
                newLine = [newLine, sprintf('    ')];
            else
                newLine = [newLine, sprintf('%4d', numbers(k))];
            end
            if k ~= length(numbers) && ~isnan(numbers(k+1))
                newLine = [newLine, ',    '];
            end
        end
        data{j} = newLine;
    end

    % Write the modified data to the output file
    fid = fopen(outputFile, 'w');
    fprintf(fid, '%s\n', data{:});
    fclose(fid);
end

