# pipeCleaner

Functions for cleaning up and organizing MATLAB program pipelines in an automated manner prior to deployment.

## Overview

**pipeCleaner** is a lightweight toolkit for automating the organization and export of MATLAB pipelines. It identifies all user-defined functions and scripts required by one or more main entry-point functions using MATLAB's built-in static dependency analysis, then saves those dependencies to a clean, portable output directory structure. This is useful for preparing a finalized version of a MATLAB project for sharing, publication, or archiving.

Key features:

- Automatically discovers and copies all dependent `.m` files
- Allows grouping of files into custom subdirectories based on path tags
- Supports exclusion of specified directories (e.g., toolboxes)
- Optional dry-run preview mode

## Dependencies

- MATLAB R2021a or newer
- Required Toolbox:
  - MATLAB (base)

This tool relies on the `matlab.codetools.requiredFilesAndProducts` function, which is built into MATLAB R2021a+.

## Installation

### macOS and Linux

Open a terminal and run the following commands:

```bash
# Change directory to desired install location
cd ~/Documents/MATLAB

# Clone the repository
git clone https://github.com/ejduwell/pipeCleaner.git

# Add it to your MATLAB path (inside MATLAB):
addpath(genpath('~/Documents/MATLAB/pipeCleaner'))
savepath
```

### Windows

1. Open MATLAB
2. In the Command Window, run:

```matlab
cd('C:\Users\YourUsername\Documents\MATLAB')
system('git clone https://github.com/ejduwell/pipeCleaner.git')
# Add it to your MATLAB path:
addpath(genpath('~/Documents/MATLAB/pipeCleaner'))
savepath
```

Alternatively, download the ZIP from GitHub, extract it into your MATLAB path.

## Usage

The main function you will update and run is `pipelineCleaner.m`, located in the root of this repository.

Open `pipelineCleaner.m`, scroll to the **Set Parameters** section, and modify the fields as needed for your project. You may want to save copies under different names per project.

### Parameters Breakdown

#### `mainFcnz`

A cell array of entry-point function filenames that form the core of your pipeline.

**Example:**

```matlab
mainFcnz = {
    "myMainScript_v1.m",
    "mySecondStageScript.m"
};
```

#### `mainFcnDirz`

Directories where your pipeline functions are located. These will be added to the MATLAB path during analysis.

**Example:**

```matlab
mainFcnDirz = {
    "/home/user/projects/myPipeline/code",
    "/home/user/projects/myPipeline/utils"
};
```

#### `dirs2exclude`

Full directory paths that should be excluded from dependency scanning (e.g., MATLAB toolboxes or third-party code).

**Example:**

```matlab
dirs2exclude = {
    "/home/user/Documents/MATLAB/Psychtoolbox"
};
```

#### `pathTagsIn` and `codeSubDirsOut`

Custom routing: If a dependency file's full path contains a substring from `pathTagsIn`, it is saved in the corresponding subdirectory specified by `codeSubDirsOut`.

**Example:**

```matlab
pathTagsIn = {
    "filter", "scramble", "utils"
};

codeSubDirsOut = {
    "filterFcns", "scrambleFcns", "utilityFcns"
};
```

Files not matching any tag go into `miscFcns`.

#### `outputDirParent` and `outputDir`

Where to save the organized output.

**Example:**

```matlab
outputDirParent = "/home/user/projects/finalized";
outputDir = "myPipelineCleaned";
```

#### `onlyLocal` and `dryRun`

- `onlyLocal`: If true, restricts search to files under your home directory
- `dryRun`: If true, no files are copied; only prints a preview

**Example:**

```matlab
onlyLocal = true;
dryRun = true;
```

#### `genPrgrmDirz` and `prgrmSubDirz`

Creates additional directories under the output directory to help you scaffold or organize further manually.

**Example:**

```matlab
genPrgrmDirz = 1;
prgrmSubDirz = {
    "analysis", "analysis/results", "figures"
};
```

### Suggestions/Tips

- Start by running `pipelineCleaner` with `dryRun = true` to preview dependencies.
- Use path snippets printed in dry-run output to build `pathTagsIn` for organizing your export.
- Consider saving a project-specific copy of `pipelineCleaner.m` to reuse later.
- If you find this useful, please give the GitHub repository a ⭐ and help spread the word!

---

Happy pipeline cleaning!

Ethan Duwell, PhD\
June 2025
