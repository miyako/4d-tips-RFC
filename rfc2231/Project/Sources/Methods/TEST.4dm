//%attributes = {}
$RFC:=cs:C1710.RFC.new()

$disposition:=$RFC.encodeRFC2231("ascii.日本語.日本語.日本語.日本語.日本語.🌀.🌀.🌀.🌀.file.name")

$header:=$RFC.encodeRFC2047("ascii.日本語.日本語.日本語.日本語.日本語.🌀.🌀.🌀.🌀.file.name")

SET TEXT TO PASTEBOARD:C523($header)