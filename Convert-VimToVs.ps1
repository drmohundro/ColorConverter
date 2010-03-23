param (
    [string] $pathToVim
)

<#
--- from http://vimdoc.sourceforge.net/htmldoc/syntax.html#{group-name} ---
--- see also http://vimdoc.sourceforge.net/htmldoc/syntax.html#highlight-default ---

	*Comment	any comment

	*Constant	any constant
	 String		a string constant: "this is a string"
	 Character	a character constant: 'c', '\n'
	 Number		a number constant: 234, 0xff
	 Boolean	a boolean constant: TRUE, false
	 Float		a floating point constant: 2.3e10

	*Identifier	any variable name
	 Function	function name (also: methods for classes)

	*Statement	any statement
	 Conditional	if, then, else, endif, switch, etc.
	 Repeat		for, do, while, etc.
	 Label		case, default, etc.
	 Operator	"sizeof", "+", "*", etc.
	 Keyword	any other keyword
	 Exception	try, catch, throw

	*PreProc	generic Preprocessor
	 Include	preprocessor #include
	 Define		preprocessor #define
	 Macro		same as Define
	 PreCondit	preprocessor #if, #else, #endif, etc.

	*Type		int, long, char, etc.
	 StorageClass	static, register, volatile, etc.
	 Structure	struct, union, enum, etc.
	 Typedef	A typedef

	*Special	any special symbol
	 SpecialChar	special character in a constant
	 Tag		you can use CTRL-] on this
	 Delimiter	character that needs attention
	 SpecialComment	special things inside a comment
	 Debug		debugging statements

	*Underlined	text that stands out, HTML links

	*Ignore		left blank, hidden

	*Error		any erroneous construct

	*Todo		anything that needs extra attention; mostly the
			keywords TODO FIXME and XXX
#>

$mapping = @{
    'Plain Text' = 'Normal';
    'Selected Text' = 'Visual';
    'Inactive Selected Text' =  '';
    'Indicator Margin' =  '';
    'Line Numbers' = 'LineNr';
    'Brace Matching (Highlight)' = 'Delimeter';
    'Brace Matching (Rectangle)' = 'Delimiter';
    'Code Snippet Dependent Field' =  '';
    'Code Snippet Field' =  '';
    'Collapsible Text' =  '';
    'Comment' = 'Comment';
    'Compiler Error' =  '';
    'CSS Comment' = 'Comment'; 
    'CSS Keyword' = 'Keyword';
    'CSS Property Name' = 'Identifier';
    'CSS Property Value' = 'String';
    'CSS Selector' =  '';
    'CSS String Value' = 'String';
    'Disassembly Symbol' =  '';
    'HTML Attribute' =  '';
    'HTML Attribute Value' = 'String';
    'HTML Comment' = 'Comment';
    'HTML Element Name' = 'Identifier';
    'HTML Entity' = '';
    'HTML Operator' = '';
    'HTML Server-Side Script' = '';
    'HTML Tag Delimiter' = '';
    'Identifier' = 'Normal'; # changed from Identifier
    'Keyword' = 'Keyword';
    'Memory Changed' = '';
    'Number' = 'Number';
    'Operator' = 'Operator';
    'Other Error' = '';
    'Preprocessor Keyword' = '';
    'Refactoring Background' = '';
    'Refactoring Current Field' = '';
    'Refactoring Dependent Field' = '';
    'Smart Tag' = '';
    'SQL DML Marker' = '';
    'Stale Code' = '';
    'String' = 'String';
    'String(C# @ Verbatim)' = 'String';
    'User Types' = 'Type'; # changed from ''
    'User Types(Delegates)' = 'Type'; # changed from ''
    'User Types(Enums)' = 'Type'; # changed from ''
    'User Types(Interfaces)' = 'Type'; # changed from ''
    'User Types(Value types)' = 'Type'; # changed from ''
    'XML Attribute' = '';
    'XML Attribute Quotes' = '';
    'XML Attribute Value' = 'String';
    'XML CData Section' = '';
    'XML Comment' = 'Comment';
    'XML Delimiter' = '';
    'XML Doc Attribute' = '';
    'XML Doc Comment' = 'Comment';
    'XML Doc Tag' = '';
    'XML Keyword' = 'Keyword';
    'XML Name' = 'Identifier';
    'XML Tag Delimiter' = '';
    'XML Text' = '';
    'XSLT Keyword' = 'Keyword';
    'XAML Attribute' = '';
    'XAML Attribute Quotes' = '';
    'XAML Attribute Value' = 'String';
    'XAML CData Section' = '';
    'XAML Comment' = 'Comment';
    'XAML Delimiter' = '';
    'XAML Keyword' = 'Keyword';
    'XAML Name' = 'Identifier';
    'XAML Text' = '';
    'XAML Markup Extension Class' = '';
    'XAML Markup Extension Parameter Name' = 'Identifier';
    'XAML Markup Extension Parameter Value' = 'String';
}

function parseVim {
    param ($pathToVim)
    $vim = Get-Content $pathToVim

    $hilines = $vim | where { $_ -match '^(\s+)?(hi|highlight) \w+\s+' }

    $hilines | foreach {
        $matches = $Null
        $name = $Null
        $guifg = $Null
        $guibg = $Null

        if ($_ -match '(hi|highlight) (?<name>\w+)') {
            $name = $matches['name']
        }

        if ($_ -match 'guifg=(?<guifg>[#A-Za-z0-9]+)') {
            $guifg = $matches['guifg']
        }

        if ($_ -match 'guibg=(?<guibg>[#A-Za-z0-9]+)') {
            $guibg = $matches['guibg']
        }

        $output = New-Object PSObject -Property @{
            Name = $name
            Foreground = $guifg
            Background = $guibg
        }

        $output
    }
}

function toVsColor {
    param ($color)

    $red = $color[1..2] -join ''
    $green = $color[3..4] -join ''
    $blue = $color[5..6] -join ''

    "#00$blue$green$red".ToUpper()
}

$vim = parseVim $pathToVim
$colorSchemeName = [System.IO.Path]::GetFileNameWithoutExtension($pathToVim)

Push-Location '~/Documents/Visual Studio 2008/Settings'
$xml = [xml] (Get-Content (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Path) 'BaseColorSettings.vssettings'))

# Text Editor guid is {A27B4E24-A735-4D1D-B8E7-9716E1E3D8E0}
$items = $xml.UserSettings.Category.Category.FontsAndColors.Categories.Category | 
    where { $_.Guid -eq '{A27B4E24-A735-4D1D-B8E7-9716E1E3D8E0}' }

$items.GetElementsByTagName('Item') | foreach {
    $item = $_

    $vimMapping = $mapping[$item.Name]
    if ($vimMapping -ne '') {
        $vimSetting = $vim | where { $_.Name -eq $vimMapping }

        if ($vimSetting -ne $null) {
            if ($item.Foreground -ne $Null -and $vimSetting.Foreground -ne $Null) {
                $item.Foreground = toVsColor $vimSetting.Foreground
            }

            if ($item.Background -ne $null -and $vimSetting.Background -ne $Null) {
                $item.Background = toVsColor $vimSetting.Background
            }

            Write-Debug "Mapping $($item.Name): Foreground $($item.Foreground) Background $($item.Background)"
        }
    }
}

$pathToSave = Join-Path $pwd "$colorSchemeName.vssettings"

$xml.Save($pathToSave)

"$pathToSave was created."
Pop-Location
