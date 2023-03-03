Class constructor
	
	This:C1470.encoding:="utf-8"
	This:C1470.language:="ja"
	
	This:C1470.tag:=Formula:C1597(This:C1470.encoding+"'"+This:C1470.language+"'")
	
Function _escape($str : Text)->$escaped : Text
	
	var $i : Integer
	var $shouldEscape : Boolean
	var $data : Blob
	
	For ($i; 1; Length:C16($str))
		
		$char:=Substring:C12($str; $i; 1)
		$code:=Character code:C91($char)
		
		$shouldEscape:=False:C215
		
		Case of 
			: ($code=45)
			: ($code=46)
			: ($code>47) & ($code<58)
			: ($code>63) & ($code<91)
			: ($code=95)
			: ($code>96) & ($code<123)
			: ($code=126)
			Else 
				$shouldEscape:=True:C214
		End case 
		
		If ($shouldEscape)
			CONVERT FROM TEXT:C1011($char; This:C1470.encoding; $data)
			For ($j; 0; BLOB size:C605($data)-1)
				$hex:=String:C10($data{$j}; "&x")
				$escaped:=$escaped+"%"+Substring:C12($hex; Length:C16($hex)-1)
			End for 
		Else 
			$escaped:=$escaped+$char
		End if 
		
	End for 
	
Function _max_line_length($idx : Integer)->$max_line_length : Text
	
	$length:=76-Length:C16("\tfilename*=;")-Length:C16(String:C10($idx))
	
	If ($idx=0)
		$length:=$length-Length:C16(This:C1470.tag())
	End if 
	
	$max_line_length:=String:C10($length)
	
Function _append_line($filename : Collection; $str : Text)
	
	$line:="filename*"+String:C10($filename.length)+"="
	
	If ($filename.length=0)
		$line:=$line+This:C1470.tag()
	End if 
	
	$line:=$line+$str
	
	$filename.push($line)
	
Function encodeRFC2231($str : Text)->$disposition : Text
	
	$escaped:=This:C1470._escape($str)
	
	$filename:=New collection:C1472
	
	ARRAY LONGINT:C221($pos; 0)
	ARRAY LONGINT:C221($len; 0)
	
	While (Match regex:C1019("([^%]|%[:hex_digit:]{2}){1,"+This:C1470._max_line_length($filename.length)+"}"; $escaped; 1; $pos; $len))
		This:C1470._append_line($filename; Substring:C12($escaped; $pos{0}; $len{0}))
		$escaped:=Delete string:C232($escaped; $pos{0}; $len{0})
	End while 
	
	$filename.unshift("attachment")
	
	$disposition:=$filename.join(";\r\n\t")
	