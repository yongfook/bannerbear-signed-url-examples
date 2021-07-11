<?php

#this code contains the placeholders YOUR_API_KEY and YOUR_SIGNED_URL_BASE_ID which are meant to be replaced with your own key / id

########################################################

#api_key: your project API key - keep this safe and non-public
$api_key = "YOUR_API_KEY";

#base: this signed url base
$base = "https://ondemand.bannerbear.com/signedurl/YOUR_SIGNED_URL_BASE_ID/image.jpg";

#modifications: grab this JSON from your template API Console and modify as needed
$modifications = '[{"name":"photo","image_url":"https://cdn.bannerbear.com/sample_images/welcome_bear_photo.jpg"},{"name":"text","text":"Hello World"}]';

#create the query string
$query = "?modifications=" . rtrim(strtr(base64_encode($modifications), '+/', '-_'), '=');

#calculate the signature
$signature = hash_hmac('sha256', $base.$query, $api_key);

#append the signature

#Signed URL
echo $base . $query."&s=" . $signature;
