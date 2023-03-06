Class extends RFC

Class constructor
	
	Super:C1705()
	
Function tag()->$tag : Text
	
	$tag:="=?"+This:C1470.encoding+"?B?"
	
Function _append_line($filename : Collection; $str : Text)
	
	$line:=This:C1470.tag()+$str+"?="
	
	$filename.unshift($line)
	
Function _max_line_length()->$length : Integer
	
	$length:=76-Length:C16("\t=?B?=")
	
Function encode($str : Text)->$value : Text
	
	$filename:=New collection:C1472
	
	$_str:=$str
	
	var $pos; $len : Integer
	
	While (Length:C16($_str)#0)
		For ($len; Length:C16($_str); 0; -1)
			$pos:=Length:C16($_str)-$len+1
			$encoded:=This:C1470._encode(Substring:C12($_str; $pos))
			If (Length:C16($encoded)<This:C1470._max_line_length())
				This:C1470._append_line($filename; $encoded)
				$_str:=Delete string:C232($_str; $pos; $len)
			End if 
			If (Length:C16($_str)=0)
				$len:=0  //break
			End if 
		End for 
	End while 
	
	$value:=$filename.join("\r\n\t")
	