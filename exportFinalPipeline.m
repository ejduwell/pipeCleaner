function exportFinalPipeline(mainFuncPath, outputDir, onlyLocal, dryRun, dirs2exclude, pathTagsIn, codeSubDirsOut)
% exportFinalPipeline - Copy all dependent user-defined MATLAB scripts/functions
% using static analysis via matlab.codetools.requiredFilesAndProducts.
%
% Developed by Ethan Duwell, PhD. (06/2025)
% Note: Ethan used OpenAI's GPT4o LLM model in the development of this 
%       function and others in the pipeCleaner repository.
%
% Inputs:
%   mainFuncPath     - Path to main .m file (string or char)
%   outputDir        - Destination folder for copied files
%   onlyLocal        - (Optional) Only include files under user's home directory (default: true)
%   dryRun           - (Optional) If true, list what would be copied (default: false)
%   dirs2exclude     - (Optional) Cell array of full paths to exclude
%   pathTagsIn       - (Optional) Cell array of string segments to match against full file path
%   codeSubDirsOut   - (Optional) Cell array of output subdirectory names (same length as pathTagsIn)

    if nargin < 3 || isempty(onlyLocal), onlyLocal = true; end
    if nargin < 4 || isempty(dryRun), dryRun = false; end
    if nargin < 5, dirs2exclude = {}; end
    if nargin < 6, pathTagsIn = {}; end
    if nargin < 7, codeSubDirsOut = {}; end

    % Normalize home directory
    homeDir = strrep(char(java.lang.System.getProperty('user.home')), '\', '/');
    if ~endsWith(homeDir, '/'), homeDir = [homeDir '/']; end
    homeDir = string(homeDir);

    % Normalize excluded directories
    if iscell(dirs2exclude)
        dirs2exclude = cellfun(@(p) strrep(p, '\', '/'), dirs2exclude, 'UniformOutput', false);
    end
    dirs2exclude = string(dirs2exclude);
    dirs2exclude = stripTrailingSlash(dirs2exclude) + "/";

    % Normalize tag routing
    pathTagsIn     = string(pathTagsIn);
    codeSubDirsOut = string(codeSubDirsOut);
    if numel(pathTagsIn) ~= numel(codeSubDirsOut)
        error('pathTagsIn and codeSubDirsOut must have the same number of elements.');
    end

    if ~exist(mainFuncPath, 'file')
        error('Main function file does not exist: %s', mainFuncPath);
    end

    if ~dryRun && ~exist(outputDir, 'dir')
        mkdir(outputDir);
    end

    % Get required files
    requiredFiles = matlab.codetools.requiredFilesAndProducts(mainFuncPath);
    requiredFiles = strrep(requiredFiles, '\', '/');
    requiredFiles = string(requiredFiles);

    % Filter files
    filesToCopy = string([]);
    for i = 1:length(requiredFiles)
        fpath = requiredFiles(i);

        if any(startsWith(fpath, dirs2exclude)), continue; end
        if onlyLocal && ~startsWith(fpath, homeDir), continue; end

        filesToCopy(end+1) = fpath; %#ok<AGROW>
    end

    % Dry run
    if dryRun
        fprintf('Dry-run mode: the following %d files would be copied to:\n  %s\n', ...
            numel(filesToCopy), outputDir);
        for i = 1:length(filesToCopy)
            fprintf('  • %s\n', filesToCopy(i));
        end
        return;
    end

    % Copy with smart routing
    fprintf('Copying files to %s ...\n', outputDir);
    for i = 1:length(filesToCopy)
        srcFile = char(filesToCopy(i));
        [~, fname, ext] = fileparts(srcFile);

        % Determine subdirectory using pathTagsIn
        targetSubDir = 'miscFcns';
        for j = 1:length(pathTagsIn)
            if contains(srcFile, pathTagsIn(j))
                targetSubDir = codeSubDirsOut(j);
                break;
            end
        end

        fullDestDir = fullfile(outputDir, targetSubDir);
        if ~exist(fullDestDir, 'dir')
            mkdir(fullDestDir);
        end

        destFile = fullfile(fullDestDir, [fname ext]);
        try
            copyfile(srcFile, destFile);
            fprintf('  ✓ Copied: %s → %s\n', [fname ext], targetSubDir);
        catch
            warning('Failed to copy: %s', srcFile);
        end
    end

    fprintf('Export complete. %d files copied.\n', numel(filesToCopy));
end

function stripped = stripTrailingSlash(paths)
    stripped = regexprep(paths, '/?$', '');
end
