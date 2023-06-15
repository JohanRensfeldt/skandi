function processFile2(inputFile, outputFile)

    % Read the file
    fid = fopen(inputFile, 'r');
    data = textscan(fid, '%s', 'Delimiter', '\n', 'WhiteSpace', '');
    fclose(fid);
    data = data{1};

    % Define function to split line into numbers
    splitNumbers = @(line) str2double(strsplit(line));

    % Detect the start of data lines
    isDataStart = find(cellfun(@(line) all(~isnan(splitNumbers(line))), data), 1, 'first');

    % Create new lines for data lines and replace data lines in the data
    for j = isDataStart:length(data)
        numbers = splitNumbers(data{j});
        newLine = '';
        for k = 1:length(numbers)
            if isnan(numbers(k))
                newLine = [newLine, sprintf('%4s', 'NaN')];
            else
                newLine = [newLine, sprintf('%4d', numbers(k))];
            end
            if k ~= length(numbers)
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

