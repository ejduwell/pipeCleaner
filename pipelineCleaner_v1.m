
%% Set Parameters

% Specify "Main Functions" for your pipeline/program
% These will be fed in sequentially as the primary inputs to 
% exportFinalPipeline will find and copy all dependent user-defined MATLAB 
% scripts/functions using static analysis via Matlab's
% matlab.codetools.requiredFilesAndProducts functions.
%--------------------------------------------------------------------------
mainFcnz={
    "SFTnz2File_multi_v2.m",...
    "BI_NzStack_SFcompare_v1_2.m",...
    "sftNz_noiseDescFile_template_v1.m",...
    };
%--------------------------------------------------------------------------

% Specify paths in mainFcnDirz to specify which directories contain your 
% functions. These will be added you your path at the beginning of the
% script and removed at the end. Directory paths specified in dirs2exclude
% will not be searched.
% **Note: Any other directories that already happen to be on your path and
% are not specified in dirs2exclude will be searched as well.**
%--------------------------------------------------------------------------
mainFcnDirz={
    "/home/eduwell/SynologyDrive/SNAP/projects/kernelNoise_sims",...
    "/home/eduwell/SynologyDrive/SNAP/projects/noiseSpatialFreqComp",...
    };

dirs2exclude={
    "/home/eduwell/Documents/MATLAB/3.0.19.13/Psychtoolbox/",...
    };
%--------------------------------------------------------------------------

% Specify pathTagsIn and corresponding codeSubDirsOut. These two
% parameters/arrays can be used flexibly and creatively to sort functions 
% into output subdirectorys and should have the same number of elements. 
% Think of the strings you specify in pathTagsIn as "regular expressions." 
% Function paths discovered by exportFinalPipeline containing strings in 
% pathTagsIn are saved in a subdirectory whose name is specified in the 
% corresponding index/position in codeSubDirsOut.
%--------------------------------------------------------------------------
pathTagsIn={
    "noiseSpatialFreqComp",...
    "SFTnz",...
    "phzOri",...
    "bandpassFilterImage",...
    "generatePhaseScrambledImage_v4"...
    "sftNz_noiseDescFile_template",...
    };

codeSubDirsOut={
    "noiseSpatialFreqComp",...
    "sftNzGenFcns",...
    "sftNzGenFcns",...
    "sftNzGenFcns",...
    "sftNzGenFcns",...
    "parDescFilez",...
    };
%--------------------------------------------------------------------------

% Specify the outputDirParent and outputDir directories.
% outputDir will be your new "program directory" in which the main functions
% and their dependencies are exported and will be saved within the
% outputDirParent directory.
%--------------------------------------------------------------------------
outputDirParent="/home/eduwell/SynologyDrive/SNAP/projects/sandbox/pipeCleaner";
outputDir="sftNz";
%--------------------------------------------------------------------------

% Specify onlyLocal and dryRun parameters.
%--------------------------------------------------------------------------
onlyLocal=true; % limit dependency search to your home directory? (true, false)
dryRun=false; % if true, only prints out paths & does not copy.
%--------------------------------------------------------------------------

% Specify genPrgrmDirz and prgrmDirz and prgrmDirz to generate additional
% program directories and subdirectories within your program's outputDir. 
%--------------------------------------------------------------------------
genPrgrmDirz=1; % 1=generate program dirs listed in prgrmDirz
                % 0=don't
                % Note: dryRun=true wil also turn of directory creation.

% specify additional directories to generate within program outputDir              
prgrmDirz={
    "additionalProgramDir1",...
    "additionalProgramDir1/Subdir",...
    "additionalProgramDir2",...
    "additionalProgramDir2/Subdir",...   
    };
%--------------------------------------------------------------------------

%% Add mainFcnDirz to path

disp(" ");
disp("Adding main function directories/subdirectories to path..")
for jj=1:length(mainFcnDirz)
    addpath(genpath(mainFcnDirz{1,jj}))
end

%% Run exportFinalPipeline.m

% combine outputDirParent and outputDir to build full path..
outputDir=strcat(outputDirParent,"/",outputDir);

for ii=1:length(mainFcnz)
    
    % grab function for this pass..
    mainFunc=mainFcnz{1,ii};
    mainFuncPath=which(mainFunc);

    % announce on command line..
    disp(" ");
    disp(strcat("Finding dependencies for: ",mainFunc));
    disp(strcat("(Located at: ",mainFuncPath,")"));
    disp(" ");
    
    % call exportFinalPipeline
    exportFinalPipeline(mainFuncPath, outputDir, onlyLocal, dryRun, dirs2exclude, pathTagsIn, codeSubDirsOut);

end

%% Generate additional program directories if requested

if genPrgrmDirz==1 && dryRun==false    
    for hh=1:length(prgrmDirz)        
        prgrmDir=strcat(outputDir,"/",prgrmDirz{1,hh});
    end
end

%% Remove mainFcnDirz to path

disp(" ");
disp("Removing the original main function directories/subdirectories from path..")
for jj=1:length(mainFcnDirz)
    rmpath(genpath(mainFcnDirz{1,jj}));
end

%% Close up

disp(" ");
disp("Finished...");
disp(" ");

clear; % clean up..
