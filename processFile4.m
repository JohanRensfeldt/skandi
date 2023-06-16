function processFile4(inputFile, outputFile, startLine, endLine)

    % Read the file
    fid = fopen(inputFile, 'r');
    data = textscan(fid, '%s', 'Delimiter', '\n', 'WhiteSpace', '');
    fclose(fid);
    data = data{1};

    % Define function to split line into numbers and labels
    splitNumbersAndLabel = @(line) strsplit(line);

    % First pass to find the maximum number width
    maxWidth = 0;
    for j = startLine:endLine
        strNumbers = splitNumbersAndLabel(data{j});
        for k = 2:length(strNumbers) % Start from second element to skip the label
            number = str2double(strNumbers{k});
            if ~isnan(number)
                strNum = sprintf('%g', number);
                maxWidth = max(maxWidth, length(strNum));
            end
        end
    end
    
    % Padding format specifier based on maximum width
    formatSpecifier = sprintf('%%-%dg', maxWidth); 

    % Create new lines for data lines and replace data lines in the data
    for j = startLine:endLine
        strNumbers = splitNumbersAndLabel(data{j});
        newLine = strNumbers{1}; % start with the label
        for k = 2:length(strNumbers) % Start from second element to skip the label
            number = str2double(strNumbers{k});
            if isnan(number)
                newLine = [newLine, sprintf('%*s', maxWidth, ' ')];
            else
                newLine = [newLine, sprintf(',%s', sprintf(formatSpecifier, number))];
            end
        end
        data{j} = strtrim(newLine); % remove leading and trailing whitespaces
        if ~isempty(data{j}) && data{j}(end) == ','
            data{j}(end) = []; % remove trailing comma
        end
        if ~isempty(data{j}) && data{j}(1) == ','
            data{j}(1) = [];
        end
    end

    % Write the modified data to the output file
    fid = fopen(outputFile, 'w');
    fprintf(fid, '%s\n', data{:});
    fclose(fid);
end
