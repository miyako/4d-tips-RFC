Class extends RFC

Class constructor
	
	Super:C1705()
	
Function tag()->$tag : Text
	
	$tag:=This:C1470.encoding+"'"+This:C1470.language+"'"
	
Function _append_line($filename : Collection; $str : Text)
	
	$line:="filename*"+String:C10($filename.length)+"="
	
	If ($filename.length=0)
		$line:=$line+This:C1470.tag()
	End if 
	
	$line:=$line+$str
	
	$filename.push($line)
	
Function _max_line_length($idx : Integer)->$max_line_length : Text
	
	$length:=76-Length:C16("\tfilename*=;")-Length:C16(String:C10($idx))
	
	If ($idx=0)
		$length:=$length-Length:C16(This:C1470.tag())
	End if 
	
	$max_line_length:=String:C10($length)
	
Function encode($str : Text)->$disposition : Text
	
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