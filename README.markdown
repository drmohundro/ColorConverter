# About ColorConverter

This project began as an attempt to bring some of my favorite vim color schemes over to Visual Studio. See [my blog post on creating the script for details](http://www.mohundro.com/blog/2010/03/29/ConvertingVIMColorSchemesToVisualStudioColorSchemes.aspx).

Currently, the code exists only as a powershell script, though I have plans to add a GUI to view color schemes and possibly allow editing/tweaking of schemes before exporting them.

## Usage

Convert-VimToVs.ps1 only takes on argument, the path to the vim color script. Here is a sample run:

    Convert-VimToVs ~/.vim/colors/wombat.vim

The resulting file in this case would be saved to `~/Documents/Visual Studio 2008/Settings/wombat.vssettings`. It can then be imported into Visual Studio like any other theme setting.

## Questions?

Visit my [website](http://www.mohundro.com/blog) and shoot me a line.
