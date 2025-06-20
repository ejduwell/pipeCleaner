
%% Set Parameters

mainFcnDirz={
    "/home/eduwell/SynologyDrive/SNAP/projects/kernelNoise_sims",...
    "/home/eduwell/SynologyDrive/SNAP/projects/noiseSpatialFreqComp",...
    };

mainFcnz={
    "SFTnz2File_multi_v2.m",...
    "BI_NzStack_SFcompare_v1_2.m",...
    "sftNz_noiseDescFile_template_v1.m",...
    };

dirs2exclude={
    "/home/eduwell/Documents/MATLAB/3.0.19.13/Psychtoolbox/",...
    };

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
    "parDescFilez"
    };

outputDirParent="/home/eduwell/SynologyDrive/SNAP/projects/sandbox/pipeCleaner";
outputDir="sftNz";
onlyLocal=true; % limit dependency search to your home directory? (true, false)
dryRun=false; % if true, only prints out paths & does not copy.

%% Add mainFcnDirz to path

% disp(" ");
% disp("Adding main function directories/subdirectories to path..")
% for jj=1:length(mainFcnDirz)
%     addpath(genpath(mainFcnDirz{1,jj}))
% end

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

%% Remove mainFcnDirz to path

% disp(" ");
% disp("Removing the original main function directories/subdirectories from path..")
% for jj=1:length(mainFcnDirz)
%     rmpath(genpath(mainFcnDirz{1,jj}))
% end

%% Close up

disp(" ");
disp("Finished...");
disp(" ");

clear; % clean up..
