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

$vimNamedColorMapping = @{
    'snow' = '#fffafa';
    'GhostWhite' = '#f8f8ff';
    'WhiteSmoke' = '#f5f5f5';
    'gainsboro' = '#dcdcdc';
    'FloralWhite' = '#fffaf0';
    'OldLace' = '#fdf5e6';
    'linen' = '#faf0e6';
    'AntiqueWhite' = '#faebd7';
    'PapayaWhip' = '#ffefd5';
    'BlanchedAlmond' = '#ffebcd';
    'bisque' = '#ffe4c4'
    'PeachPuff' = '#ffdab9';
    'NavajoWhite' = '#ffdead';
    'moccasin' = '#ffe4b5';
    'cornsilk' = '#fff8dc';
    'ivory' = '#fffff0';
    'LemonChiffon' = '#fffacd';
    'seashell' = '#fff5ee';
    'honeydew' = '#f0fff0';
    'MintCream' = '#f5fffa';
    'azure' = '#f0ffff';
    'AliceBlue' = '#f0f8ff';
    'lavender' = '#e6e6fa';
    'LavenderBlush' = '#fff0f5';
    'MistyRose' = '#ffe4e1';
    'white' = '#ffffff';
    'black' = '#000000';
    'DarkSlateGray' = '#2f4f4f';
    'DimGray' = '#696969';
    'SlateGray' = '#708090';
    'LightSlateGray' = '#778899';
    'gray' = '#bebebe';
    'LightGray' = '#d3d3d3';
    'MidnightBlue' = '#191970';
    'navy' = '#000080';
    'NavyBlue' = '#000080';
    'CornflowerBlue' = '#6495ed';
    'DarkSlateBlue' = '#483d8b';
    'SlateBlue' = '#6a5acd';
    'MediumSlateBlue' = '#7b68ee';
    'LightSlateBlue' = '#8470ff';
    'MediumBlue' = '#0000cd';
    'RoyalBlue' = '#4169e1';
    'blue' = '#0000ff';
    'DodgerBlue' = '#1e90ff';
    'DeepSkyBlue' = '#00bfff';
    'SkyBlue' = '#87ceeb';
    'LightSkyBlue' = '#87cefa';
    'SteelBlue' = '#4682b4';
    'LightSteelBlue' = '#b0c4de';
    'LightBlue' = '#add8e6';
    'PowderBlue' = '#b0e0e6';
    'PaleTurquoise' = '#afeeee';
    'DarkTurquoise' = '#00ced1';
    'MediumTurquoise' = '#48d1cc';
    'turquoise' = '#40e0d0';
    'cyan' = '#00ffff';
    'LightCyan' = '#e0ffff';
    'CadetBlue' = '#5f9ea0';
    'MediumAquamarine' = '#66cdaa';
    'aquamarine' = '#7fffd4';
    'DarkGreen' = '#006400';
    'DarkOliveGreen' = '#556b2f';
    'DarkSeaGreen' = '#8fbc8f';
    'SeaGreen' = '#2e8b57';
    'MediumSeaGreen' = '#3cb371';
    'LightSeaGreen' = '#20b2aa';
    'PaleGreen' = '#98fb98';
    'SpringGreen' = '#00ff7f';
    'LawnGreen' = '#7cfc00';
    'green' = '#00ff00';
    'chartreuse' = '#7fff00';
    'MediumSpringGreen' = '#00fa9a';
    'GreenYellow' = '#adff2f';
    'LimeGreen' = '#32cd32';
    'YellowGreen' = '#9acd32';
    'ForestGreen' = '#228b22';
    'OliveDrab' = '#6b8e23';
    'DarkKhaki' = '#bdb76b';
    'khaki' = '#f0e68c';
    'PaleGoldenrod' = '#eee8aa';
    'LightGoldenrodYellow' = '#fafad2';
    'LightYellow' = '#ffffe0';
    'yellow' = '#ffff00';
    'gold' = '#ffd700';
    'LightGoldenrod' = '#eedd82';
    'goldenrod' = '#daa520';
    'DarkGoldenrod' = '#b8860b';
    'RosyBrown' = '#bc8f8f';
    'IndianRed' = '#cd5c5c';
    'SaddleBrown' = '#8b4513';
    'sienna' = '#a0522d';
    'peru' = '#cd853f';
    'burlywood' = '#deb887';
    'beige' = '#f5f5dc';
    'wheat' = '#f5deb3';
    'SandyBrown' = '#f4a460';
    'tan' = '#d2b48c';
    'chocolate' = '#d2691e';
    'firebrick' = '#b22222';
    'brown' = '#a52a2a';
    'DarkSalmon' = '#e9967a';
    'salmon' = '#fa8072';
    'LightSalmon' = '#ffa07a';
    'orange' = '#ffa500';
    'DarkOrange' = '#ff8c00';
    'coral' = '#ff7f50';
    'LightCoral' = '#f08080';
    'tomato' = '#ff6347';
    'OrangeRed' = '#ff4500';
    'red' = '#ff0000';
    'HotPink' = '#ff69b4';
    'DeepPink' = '#ff1493';
    'pink' = '#ffc0cb';
    'LightPink' = '#ffb6c1';
    'PaleVioletRed' = '#db7093';
    'maroon' = '#b03060';
    'MediumVioletRed' = '#c71585';
    'VioletRed' = '#d02090';
    'magenta' = '#ff00ff';
    'violet' = '#ee82ee';
    'plum' = '#dda0dd';
    'orchid' = '#da70d6';
    'MediumOrchid' = '#ba55d3';
    'DarkOrchid' = '#9932cc';
    'DarkViolet' = '#9400d3';
    'BlueViolet' = '#8a2be2';
    'purple' = '#a020f0';
    'MediumPurple' = '#9370db';
    'thistle' = '#d8bfd8';
    'snow1' = '#fffafa';
    'snow2' = '#eee9e9';
    'snow3' = '#cdc9c9';
    'snow4' = '#8b8989';
    'seashell1' = '#fff5ee';
    'seashell2' = '#eee5de';
    'seashell3' = '#cdc5bf';
    'seashell4' = '#8b8682';
    'AntiqueWhite1' = '#ffefdb';
    'AntiqueWhite2' = '#eedfcc';
    'AntiqueWhite3' = '#cdc0b0';
    'AntiqueWhite4' = '#8b8378';
    'bisque1' = '#ffe4c4';
    'bisque2' = '#eed5b7';
    'bisque3' = '#cdb79e';
    'bisque4' = '#8b7d6b';
    'PeachPuff1' = '#ffdab9';
    'PeachPuff2' = '#eecbad';
    'PeachPuff3' = '#cdaf95';
    'PeachPuff4' = '#8b7765';
    'NavajoWhite1' = '#ffdead';
    'NavajoWhite2' = '#eecfa1';
    'NavajoWhite3' = '#cdb38b';
    'NavajoWhite4' = '#8b795e';
    'LemonChiffon1' = '#fffacd';
    'LemonChiffon2' = '#eee9bf';
    'LemonChiffon3' = '#cdc9a5';
    'LemonChiffon4' = '#8b8970';
    'cornsilk1' = '#fff8dc';
    'cornsilk2' = '#eee8cd';
    'cornsilk3' = '#cdc8b1';
    'cornsilk4' = '#8b8878';
    'ivory1' = '#fffff0';
    'ivory2' = '#eeeee0';
    'ivory3' = '#cdcdc1';
    'ivory4' = '#8b8b83';
    'honeydew1' = '#f0fff0';
    'honeydew2' = '#e0eee0';
    'honeydew3' = '#c1cdc1';
    'honeydew4' = '#838b83';
    'LavenderBlush1' = '#fff0f5';
    'LavenderBlush2' = '#eee0e5';
    'LavenderBlush3' = '#cdc1c5';
    'LavenderBlush4' = '#8b8386';
    'MistyRose1' = '#ffe4e1';
    'MistyRose2' = '#eed5d2';
    'MistyRose3' = '#cdb7b5';
    'MistyRose4' = '#8b7d7b';
    'azure1' = '#f0ffff';
    'azure2' = '#e0eeee';
    'azure3' = '#c1cdcd';
    'azure4' = '#838b8b';
    'SlateBlue1' = '#836fff';
    'SlateBlue2' = '#7a67ee';
    'SlateBlue3' = '#6959cd';
    'SlateBlue4' = '#473c8b';
    'RoyalBlue1' = '#4876ff';
    'RoyalBlue2' = '#436eee';
    'RoyalBlue3' = '#3a5fcd';
    'RoyalBlue4' = '#27408b';
    'blue1' = '#0000ff';
    'blue2' = '#0000ee';
    'blue3' = '#0000cd';
    'blue4' = '#00008b';
    'DodgerBlue1' = '#1e90ff';
    'DodgerBlue2' = '#1c86ee';
    'DodgerBlue3' = '#1874cd';
    'DodgerBlue4' = '#104e8b';
    'SteelBlue1' = '#63b8ff';
    'SteelBlue2' = '#5cacee';
    'SteelBlue3' = '#4f94cd';
    'SteelBlue4' = '#36648b';
    'DeepSkyBlue1' = '#00bfff';
    'DeepSkyBlue2' = '#00b2ee';
    'DeepSkyBlue3' = '#009acd';
    'DeepSkyBlue4' = '#00688b';
    'SkyBlue1' = '#87ceff';
    'SkyBlue2' = '#7ec0ee';
    'SkyBlue3' = '#6ca6cd';
    'SkyBlue4' = '#4a708b';
    'LightSkyBlue1' = '#b0e2ff';
    'LightSkyBlue2' = '#a4d3ee';
    'LightSkyBlue3' = '#8db6cd';
    'LightSkyBlue4' = '#607b8b';
    'SlateGray1' = '#c6e2ff';
    'SlateGray2' = '#b9d3ee';
    'SlateGray3' = '#9fb6cd';
    'SlateGray4' = '#6c7b8b';
    'LightSteelBlue1' = '#cae1ff';
    'LightSteelBlue2' = '#bcd2ee';
    'LightSteelBlue3' = '#a2b5cd';
    'LightSteelBlue4' = '#6e7b8b';
    'LightBlue1' = '#bfefff';
    'LightBlue2' = '#b2dfee';
    'LightBlue3' = '#9ac0cd';
    'LightBlue4' = '#68838b';
    'LightCyan1' = '#e0ffff';
    'LightCyan2' = '#d1eeee';
    'LightCyan3' = '#b4cdcd';
    'LightCyan4' = '#7a8b8b';
    'PaleTurquoise1' = '#bbffff';
    'PaleTurquoise2' = '#aeeeee';
    'PaleTurquoise3' = '#96cdcd';
    'PaleTurquoise4' = '#668b8b';
    'CadetBlue1' = '#98f5ff';
    'CadetBlue2' = '#8ee5ee';
    'CadetBlue3' = '#7ac5cd';
    'CadetBlue4' = '#53868b';
    'turquoise1' = '#00f5ff';
    'turquoise2' = '#00e5ee';
    'turquoise3' = '#00c5cd';
    'turquoise4' = '#00868b';
    'cyan1' = '#00ffff';
    'cyan2' = '#00eeee';
    'cyan3' = '#00cdcd';
    'cyan4' = '#008b8b';
    'DarkSlateGray1' = '#97ffff';
    'DarkSlateGray2' = '#8deeee';
    'DarkSlateGray3' = '#79cdcd';
    'DarkSlateGray4' = '#528b8b';
    'aquamarine1' = '#7fffd4';
    'aquamarine2' = '#76eec6';
    'aquamarine3' = '#66cdaa';
    'aquamarine4' = '#458b74';
    'DarkSeaGreen1' = '#c1ffc1';
    'DarkSeaGreen2' = '#b4eeb4';
    'DarkSeaGreen3' = '#9bcd9b';
    'DarkSeaGreen4' = '#698b69';
    'SeaGreen1' = '#54ff9f';
    'SeaGreen2' = '#4eee94';
    'SeaGreen3' = '#43cd80';
    'SeaGreen4' = '#2e8b57';
    'PaleGreen1' = '#9aff9a';
    'PaleGreen2' = '#90ee90';
    'PaleGreen3' = '#7ccd7c';
    'PaleGreen4' = '#548b54';
    'SpringGreen1' = '#00ff7f';
    'SpringGreen2' = '#00ee76';
    'SpringGreen3' = '#00cd66';
    'SpringGreen4' = '#008b45';
    'green1' = '#00ff00';
    'green2' = '#00ee00';
    'green3' = '#00cd00';
    'green4' = '#008b00';
    'chartreuse1' = '#7fff00';
    'chartreuse2' = '#76ee00';
    'chartreuse3' = '#66cd00';
    'chartreuse4' = '#458b00';
    'OliveDrab1' = '#c0ff3e';
    'OliveDrab2' = '#b3ee3a';
    'OliveDrab3' = '#9acd32';
    'OliveDrab4' = '#698b22';
    'DarkOliveGreen1' = '#caff70';
    'DarkOliveGreen2' = '#bcee68';
    'DarkOliveGreen3' = '#a2cd5a';
    'DarkOliveGreen4' = '#6e8b3d';
    'khaki1' = '#fff68f';
    'khaki2' = '#eee685';
    'khaki3' = '#cdc673';
    'khaki4' = '#8b864e';
    'LightGoldenrod1' = '#ffec8b';
    'LightGoldenrod2' = '#eedc82';
    'LightGoldenrod3' = '#cdbe70';
    'LightGoldenrod4' = '#8b814c';
    'LightYellow1' = '#ffffe0';
    'LightYellow2' = '#eeeed1';
    'LightYellow3' = '#cdcdb4';
    'LightYellow4' = '#8b8b7a';
    'yellow1' = '#ffff00';
    'yellow2' = '#eeee00';
    'yellow3' = '#cdcd00';
    'yellow4' = '#8b8b00';
    'gold1' = '#ffd700';
    'gold2' = '#eec900';
    'gold3' = '#cdad00';
    'gold4' = '#8b7500';
    'goldenrod1' = '#ffc125';
    'goldenrod2' = '#eeb422';
    'goldenrod3' = '#cd9b1d';
    'goldenrod4' = '#8b6914';
    'DarkGoldenrod1' = '#ffb90f';
    'DarkGoldenrod2' = '#eead0e';
    'DarkGoldenrod3' = '#cd950c';
    'DarkGoldenrod4' = '#8b6508';
    'RosyBrown1' = '#ffc1c1';
    'RosyBrown2' = '#eeb4b4';
    'RosyBrown3' = '#cd9b9b';
    'RosyBrown4' = '#8b6969';
    'IndianRed1' = '#ff6a6a';
    'IndianRed2' = '#ee6363';
    'IndianRed3' = '#cd5555';
    'IndianRed4' = '#8b3a3a';
    'sienna1' = '#ff8247';
    'sienna2' = '#ee7942';
    'sienna3' = '#cd6839';
    'sienna4' = '#8b4726';
    'burlywood1' = '#ffd39b';
    'burlywood2' = '#eec591';
    'burlywood3' = '#cdaa7d';
    'burlywood4' = '#8b7355';
    'wheat1' = '#ffe7ba';
    'wheat2' = '#eed8ae';
    'wheat3' = '#cdba96';
    'wheat4' = '#8b7e66';
    'tan1' = '#ffa54f';
    'tan2' = '#ee9a49';
    'tan3' = '#cd853f';
    'tan4' = '#8b5a2b';
    'chocolate1' = '#ff7f24';
    'chocolate2' = '#ee7621';
    'chocolate3' = '#cd661d';
    'chocolate4' = '#8b4513';
    'firebrick1' = '#ff3030';
    'firebrick2' = '#ee2c2c';
    'firebrick3' = '#cd2626';
    'firebrick4' = '#8b1a1a';
    'brown1' = '#ff4040';
    'brown2' = '#ee3b3b';
    'brown3' = '#cd3333';
    'brown4' = '#8b2323';
    'salmon1' = '#ff8c69';
    'salmon2' = '#ee8262';
    'salmon3' = '#cd7054';
    'salmon4' = '#8b4c39';
    'LightSalmon1' = '#ffa07a';
    'LightSalmon2' = '#ee9572';
    'LightSalmon3' = '#cd8162';
    'LightSalmon4' = '#8b5742';
    'orange1' = '#ffa500';
    'orange2' = '#ee9a00';
    'orange3' = '#cd8500';
    'orange4' = '#8b5a00';
    'DarkOrange1' = '#ff7f00';
    'DarkOrange2' = '#ee7600';
    'DarkOrange3' = '#cd6600';
    'DarkOrange4' = '#8b4500';
    'coral1' = '#ff7256';
    'coral2' = '#ee6a50';
    'coral3' = '#cd5b45';
    'coral4' = '#8b3e2f';
    'tomato1' = '#ff6347';
    'tomato2' = '#ee5c42';
    'tomato3' = '#cd4f39';
    'tomato4' = '#8b3626';
    'OrangeRed1' = '#ff4500';
    'OrangeRed2' = '#ee4000';
    'OrangeRed3' = '#cd3700';
    'OrangeRed4' = '#8b2500';
    'red1' = '#ff0000';
    'red2' = '#ee0000';
    'red3' = '#cd0000';
    'red4' = '#8b0000';
    'DeepPink1' = '#ff1493';
    'DeepPink2' = '#ee1289';
    'DeepPink3' = '#cd1076';
    'DeepPink4' = '#8b0a50';
    'HotPink1' = '#ff6eb4';
    'HotPink2' = '#ee6aa7';
    'HotPink3' = '#cd6090';
    'HotPink4' = '#8b3a62';
    'pink1' = '#ffb5c5';
    'pink2' = '#eea9b8';
    'pink3' = '#cd919e';
    'pink4' = '#8b636c';
    'LightPink1' = '#ffaeb9';
    'LightPink2' = '#eea2ad';
    'LightPink3' = '#cd8c95';
    'LightPink4' = '#8b5f65';
    'PaleVioletRed1' = '#ff82ab';
    'PaleVioletRed2' = '#ee799f';
    'PaleVioletRed3' = '#cd6889';
    'PaleVioletRed4' = '#8b475d';
    'maroon1' = '#ff34b3';
    'maroon2' = '#ee30a7';
    'maroon3' = '#cd2990';
    'maroon4' = '#8b1c62';
    'VioletRed1' = '#ff3e96';
    'VioletRed2' = '#ee3a8c';
    'VioletRed3' = '#cd3278';
    'VioletRed4' = '#8b2252';
    'magenta1' = '#ff00ff';
    'magenta2' = '#ee00ee';
    'magenta3' = '#cd00cd';
    'magenta4' = '#8b008b';
    'orchid1' = '#ff83fa';
    'orchid2' = '#ee7ae9';
    'orchid3' = '#cd69c9';
    'orchid4' = '#8b4789';
    'plum1' = '#ffbbff';
    'plum2' = '#eeaeee';
    'plum3' = '#cd96cd';
    'plum4' = '#8b668b';
    'MediumOrchid1' = '#e066ff';
    'MediumOrchid2' = '#d15fee';
    'MediumOrchid3' = '#b452cd';
    'MediumOrchid4' = '#7a378b';
    'DarkOrchid1' = '#bf3eff';
    'DarkOrchid2' = '#b23aee';
    'DarkOrchid3' = '#9a32cd';
    'DarkOrchid4' = '#68228b';
    'purple1' = '#9b30ff';
    'purple2' = '#912cee';
    'purple3' = '#7d26cd';
    'purple4' = '#551a8b';
    'MediumPurple1' = '#ab82ff';
    'MediumPurple2' = '#9f79ee';
    'MediumPurple3' = '#8968cd';
    'MediumPurple4' = '#5d478b';
    'thistle1' = '#ffe1ff';
    'thistle2' = '#eed2ee';
    'thistle3' = '#cdb5cd';
    'thistle4' = '#8b7b8b';
    'gray0' = '#000000';
    'gray1' = '#030303';
    'gray2' = '#050505';
    'gray3' = '#080808';
    'gray4' = '#0a0a0a';
    'gray5' = '#0d0d0d';
    'gray6' = '#0f0f0f';
    'gray7' = '#121212';
    'gray8' = '#141414';
    'gray9' = '#171717';
    'gray10' = '#1a1a1a';
    'gray11' = '#1c1c1c';
    'gray12' = '#1f1f1f';
    'gray13' = '#212121';
    'gray14' = '#242424';
    'gray15' = '#262626';
    'gray16' = '#292929';
    'gray17' = '#2b2b2b';
    'gray18' = '#2e2e2e';
    'gray19' = '#303030';
    'gray20' = '#333333';
    'gray21' = '#363636';
    'gray22' = '#383838';
    'gray23' = '#3b3b3b';
    'gray24' = '#3d3d3d';
    'gray25' = '#404040';
    'gray26' = '#424242';
    'gray27' = '#454545';
    'gray28' = '#474747';
    'gray29' = '#4a4a4a';
    'gray30' = '#4d4d4d';
    'gray31' = '#4f4f4f';
    'gray32' = '#525252';
    'gray33' = '#545454';
    'gray34' = '#575757';
    'gray35' = '#595959';
    'gray36' = '#5c5c5c';
    'gray37' = '#5e5e5e';
    'gray38' = '#616161';
    'gray39' = '#636363';
    'gray40' = '#666666';
    'gray41' = '#696969';
    'gray42' = '#6b6b6b';
    'gray43' = '#6e6e6e';
    'gray44' = '#707070';
    'gray45' = '#737373';
    'gray46' = '#757575';
    'gray47' = '#787878';
    'gray48' = '#7a7a7a';
    'gray49' = '#7d7d7d';
    'gray50' = '#7f7f7f';
    'gray51' = '#828282';
    'gray52' = '#858585';
    'gray53' = '#878787';
    'gray54' = '#8a8a8a';
    'gray55' = '#8c8c8c';
    'gray56' = '#8f8f8f';
    'gray57' = '#919191';
    'gray58' = '#949494';
    'gray59' = '#969696';
    'gray60' = '#999999';
    'gray61' = '#9c9c9c';
    'gray62' = '#9e9e9e';
    'gray63' = '#a1a1a1';
    'gray64' = '#a3a3a3';
    'gray65' = '#a6a6a6';
    'gray66' = '#a8a8a8';
    'gray67' = '#ababab';
    'gray68' = '#adadad';
    'gray69' = '#b0b0b0';
    'gray70' = '#b3b3b3';
    'gray71' = '#b5b5b5';
    'gray72' = '#b8b8b8';
    'gray73' = '#bababa';
    'gray74' = '#bdbdbd';
    'gray75' = '#bfbfbf';
    'gray76' = '#c2c2c2';
    'gray77' = '#c4c4c4';
    'gray78' = '#c7c7c7';
    'gray79' = '#c9c9c9';
    'gray80' = '#cccccc';
    'gray81' = '#cfcfcf';
    'gray82' = '#d1d1d1';
    'gray83' = '#d4d4d4';
    'gray84' = '#d6d6d6';
    'gray85' = '#d9d9d9';
    'gray86' = '#dbdbdb';
    'gray87' = '#dedede';
    'gray88' = '#e0e0e0';
    'gray89' = '#e3e3e3';
    'gray90' = '#e5e5e5';
    'gray91' = '#e8e8e8';
    'gray92' = '#ebebeb';
    'gray93' = '#ededed';
    'gray94' = '#f0f0f0';
    'gray95' = '#f2f2f2';
    'gray96' = '#f5f5f5';
    'gray97' = '#f7f7f7';
    'gray98' = '#fafafa';
    'gray99' = '#fcfcfc';
    'gray100' = '#ffffff';
    'DarkGray' = '#a9a9a9';
    'DarkBlue' = '#00008b';
    'DarkCyan' = '#008b8b';
    'DarkMagenta' = '#8b008b';
    'DarkRed' = '#8b0000';
    'LightGreen' = '#90ee90';
}

$normalBg = '';
$normalFg = '';

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

            if ($guifg -notmatch '#' -and $guifg -ne $null) {
                $guifg = $vimNamedColorMapping[$guifg];
            }

            if ($name -match 'normal') {
                $normalFg = $guifg;
            }
        }

        if ($_ -match 'guibg=(?<guibg>[#A-Za-z0-9]+)') {
            $guibg = $matches['guibg']

            if ($guibg -notmatch '#' -and $guibg -ne $null) {
                $guibg = $vimNamedColorMapping[$guibg];
            }

            if ($name -match 'normal') {
                $normalBg = $guibg;
            }
        }

        # only save the setting if it has a name *and* a gui color specified (lets us ignore cterm settings for now)
        if ($name -ne $null -and ($guifg -ne $null -or $guibg -ne $null)) {
            Write-Debug "Recording Vim Colors: $name, $guifg, $guibg"

            $output = New-Object PSObject -Property @{
                Name = $name
                Foreground = $guifg
                Background = $guibg
            }

            $output
        }
    }
}

function toVsColor {
    param ($color)
    
    if ($color -eq 'bg') {
        $color = $normalBg;
        Write-Debug 'Using normal background color';
    }

    if ($color -eq 'fg') {
        $color = $normalFg;
        Write-Debug 'Using normal foreground color';
    }

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
        Write-Debug "Attempting to map $vimMapping"
        $vimSetting = $vim | where { $_.Name -eq $vimMapping }

        if ($vimSetting -ne $null) {
            Write-Debug "Found $vimSetting in mappings"

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
