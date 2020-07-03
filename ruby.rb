#this code contains the placeholders YOUR_API_KEY and YOUR_SIGNED_URL_BASE_ID which are meant to be replaced with your own key / id

#standard example

#api_key: your project API key - keep this safe and non-public
api_key = "YOUR_API_KEY"

#base: this signed url base
base = "https://cdn.bannerbear.com/signedurl/YOUR_SIGNED_URL_BASE_ID/image.jpg"

#query: the query string of modifications you want to generate
query = "?m[][name]=title&m[][text]=This+is+a+title&m[][name]=subtitle&m[][text]=This+is+a+subtitle"

#calculate the signature
signature = Digest::MD5.hexdigest(api_key + base + query)

#append the signature
return base + query + "&s=" + signature


#base64 example