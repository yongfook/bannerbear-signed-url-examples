<?php

#this code contains the placeholders YOUR_API_KEY and YOUR_SIGNED_URL_BASE_ID which are meant to be replaced with your own key / id

#Standard Example

#api_key: your project API key - keep this safe and non-public
$api_key = "YOUR_API_KEY";

#base: this signed url base
$base = "https://cdn.bannerbear.com/signedurl/YOUR_SIGNED_URL_BASE_ID/image.jpg";

#query: the query string of modifications you want to generate
$query = "?m[][name]=title&m[][text]=This+is+a+title&m[][name]=subtitle&m[][text]=This+is+a+subtitle";

#calculate the signature
$signature = md5($api_key.$base.$query);

#append the signature
echo $base.$query."&s=".$signature;


#Base64 Example
#same process as above but the query string will have encoded values
#plus the &base64=true parameter appended

function b64($string) {
	return rtrim(strtr(base64_encode($string), '+/', '-_'), '='); 
}

$query = "?m[][name]=".b64("title")."&m[][text]=".b64("This is a title")."&m[][name]=".b64("subtitle")."&m[][text]=".b64("This is a subtitle")."&base64=true";