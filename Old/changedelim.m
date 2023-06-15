function changedelim()

% Path to input and output
inputFile = 'random_numbers.txt';
outputFile = 'out.txt';

% Range to be changed
startLine = 1; % starting line
endLine = 5; % ending line

% Read 
fid = fopen(inputFile, 'r');
data = textscan(fid, '%s', 'Delimiter', '\n', 'WhiteSpace', '');
fclose(fid);
data = data{1};

% Change the separator
for i = startLine:endLine
    if i <= length(data)
        data{i} = strrep(data{i}, '  ', ',');
    end
end

% Write modified data to the output file
fid = fopen(outputFile, 'w');
for i = 1:length(data)
    fprintf(fid, '%s\n', data{i});
end
fclose(fid);

end
