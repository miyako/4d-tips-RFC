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
	
Function _max_line_length($idx : Integer)->$length : Integer
	
	$length:=76-Length:C16("\tfilename*=;")-Length:C16(String:C10($idx))
	
	If ($idx=0)
		$length:=$length-Length:C16(This:C1470.tag())
	End if 
	
Function encode($str : Text)->$disposition : Text
	
	$filename:=New collection:C1472
	
	$_str:=$str
	
	While (Length:C16($str)#0)
		
		$escaped:=This:C1470._escape($_str)
		
		var $pos; $len : Integer
		
		While (Match regex:C1019("([^%]|%[:hex_digit:]{2})+"; $escaped; 1; $pos; $len))
			
			If ($len<This:C1470._max_line_length($filename.length))
				This:C1470._append_line($filename; $escaped)
				$str:=Delete string:C232($str; 1; Length:C16($_str))
				$_str:=$str
			Else 
				$_str:=Delete string:C232($_str; Length:C16($_str); 1)  //trim end
			End if 
			$escaped:=This:C1470._escape($_str)
		End while 
		
	End while 
	
	$filename.unshift("attachment")
	
	$disposition:=$filename.join(";\r\n\t")