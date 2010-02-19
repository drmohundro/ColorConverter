param (
    [string] $pathToVim
)

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
    'Operator' = '';
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
    'User Types' = 'Identifier'; # changed from ''
    'User Types(Delegates)' = 'Constant'; # changed from ''
    'User Types(Enums)' = 'Constant'; # changed from ''
    'User Types(Interfaces)' = 'Constant'; # changed from ''
    'User Types(Value types)' = 'Constant'; # changed from ''
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
    $vim = get-content $pathToVim

    $hilines = $vim | where { $_ -match '^(\s+)?hi \w+\s+' }

    $hilines | %{
        $matches = $Null
        $name = $Null
        $guifg = $Null
        $guibg = $Null

        if ($_ -match 'hi (?<name>\w+)') {
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

pushd '~/Documents/Visual Studio 2008/Settings'
$xml = [xml] $(get-content ./Exported-2010-02-19.vssettings)

# Text Editor guid is {A27B4E24-A735-4D1D-B8E7-9716E1E3D8E0}
$items = $xml.usersettings.category.category.fontsandcolors.categories.category | 
    where { $_.Guid -eq '{A27B4E24-A735-4D1D-B8E7-9716E1E3D8E0}' }

$items.GetElementsByTagName('Item') | foreach {
    $item = $_

    $vimMapping = $mapping[$item.Name]
    if ($vimMapping -ne '') {
        $vimSetting = $vim | where { $_.Name -eq $vimMapping }

        if ($vimSetting -ne $null) {
            # TODO: still need to turn color from RGB to BGR

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
popd
