Class constructor
	
	This:C1470.encoding:="utf-8"
	This:C1470.language:="ja"
	
Function _encode($str : Text)->$encoded : Text
	
	var $data : Blob
	
	CONVERT FROM TEXT:C1011($str; This:C1470.encoding; $data)
	
	BASE64 ENCODE:C895($data; $encoded)
	
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
	