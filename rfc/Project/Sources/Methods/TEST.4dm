//%attributes = {}
$RFC:=cs:C1710.RFC2231.new()

$disposition:=$RFC.encode("ascii.日本語.日本語.日本語.日本語.日本語.🌀.🌀.🌀.🌀.file.name")

SET TEXT TO PASTEBOARD:C523($disposition)

$RFC:=cs:C1710.RFC2047.new()

$filename:=$RFC.encode("ascii.日本語.日本語.日本語.日本語.日本語.🌀.🌀.🌀.🌀.file.name")

SET TEXT TO PASTEBOARD:C523($filename)