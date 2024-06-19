==================================================
Batch Script for File Archiving with FreeArc
==================================================

## Overview

This batch script automates the process of archiving files using FreeArc with user-selected compression parameters and levels. It simplifies the creation of compressed archives while allowing customization of compression strength and archive size.

## Features

- **User-Friendly Interface**: Simple prompts guide users through selecting archive and file paths, compression settings, and archive sizes.
  
- **Custom Compression Levels**: Choose from a range of compression levels, from maximum compression for smaller file sizes to faster compression options for quicker operations.

- **Flexible Archive Sizes**: Select from preset archive sizes (2GB, 2.5GB, 4.5GB, 5GB, 7GB) to suit your storage or transfer requirements.

- **Automated Archiving**: Files within specified folders are automatically archived into separate archives based on subfolder names.

- **Cleanup Process**: Temporary files and directories are automatically removed after archiving, ensuring a tidy workspace.

## Usage

1. **Setup**

   - Ensure your console supports UTF-8 encoding (`chcp 65001`).
   - Set the path to the FreeArc executable (`FreeArcPath`) in the script.

2. **Input Paths**

   - Enter the path for the archive folder (`ArchivePath`).
   - Specify the folder containing files to be archived (`FilesPath`).

3. **Validation**

   - Paths are validated to ensure they exist and are correctly formatted.
   - Errors in path specifications prompt informative messages to guide correction.

4. **Archive Size Selection**

   - Choose a size from available options (2GB, 2.5GB, 4.5GB, 5GB, 7GB).
   - Selected sizes are converted to bytes (`ArchiveSizeBytes`) for accurate archive creation.

5. **Compression Level Selection**

   - Select a compression level (Maximum, Very High, High, Medium, Low, Very Low).
   - Each level adjusts compression intensity to balance between speed and file size reduction.

6. **Archiving Process**

   - Files in each subfolder of `FilesPath` are archived with the chosen parameters.
   - Archives (`data-<subfolder>.arc`) are created in the specified archive directory (`ArchivePath`).

7. **Finalization**

   - Completed archives are moved from the temporary directory to the main archive directory.
   - Temporary directories are deleted to maintain workspace cleanliness and efficiency.

8. **Completion**

   - The script concludes with a summary of the archiving and cleanup process.
   - Users receive confirmation of successful completion, ensuring files are securely archived and space is efficiently managed.

## Usage Tips

- Ensure accurate path entry to prevent errors during execution.
- Customize compression and archive size selections based on your specific needs.
- Monitor script output for progress updates and final completion messages.

==================================================
