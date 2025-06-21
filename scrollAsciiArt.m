function scrollAsciiArt(path2Ascii, scrollSpeed)
% scrollAsciiArt - Display ASCII art scrolling line-by-line in the Command Window.
%
% Syntax: scrollAsciiArt(path2Ascii, scrollSpeed)
%
% Inputs:
%   path2Ascii  - String, path to the .txt file containing ASCII art.
%   scrollSpeed - Integer, number of lines per second (controls scroll speed).
%
% Example:
%   scrollAsciiArt('asciiArt.txt', 10)

    % Validate scrollSpeed
    if ~isscalar(scrollSpeed) || scrollSpeed <= 0
        error('scrollSpeed must be a positive integer.');
    end

    % Read the ASCII art file
    if ~isfile(path2Ascii)
        error('File not found: %s', path2Ascii);
    end

    fid = fopen(path2Ascii, 'r');
    if fid == -1
        error('Failed to open file: %s', path2Ascii);
    end

    % Read lines into cell array
    asciiLines = {};
    while ~feof(fid)
        line = fgetl(fid);
        asciiLines{end+1} = line; %#ok<AGROW>
    end
    fclose(fid);

    % Display lines one by one with pause for scrolling effect
    nLines = numel(asciiLines);
    pauseTime = 1 / scrollSpeed;

    for i = 1:nLines
        disp(asciiLines{i});
        pause(pauseTime);
    end
end
