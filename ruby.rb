#this code contains the placeholders YOUR_API_KEY and YOUR_SIGNED_URL_BASE_ID which are meant to be replaced with your own key / id

#Standard Example

#api_key: your project API key - keep this safe and non-public
api_key = "YOUR_API_KEY"

#base: this signed url base
base = "https://cdn.bannerbear.com/signedurl/YOUR_SIGNED_URL_BASE_ID/image.jpg"

#query: the query string of modifications you want to generate
query = "?m[][name]=title&m[][text]=This+is+a+title&m[][name]=subtitle&m[][text]=This+is+a+subtitle"

#calculate the signature
digest = OpenSSL::Digest.new('sha256')

signature = OpenSSL::HMAC.hexdigest(digest, api_key + base + query)

#append the signature
return base + query + "&s=" + signature


#Base64 Example
#same process as above but the query string will have encoded values
#plus the &base64=true parameter appended

def b64(string)
	Base64.urlsafe_encode64(string, :padding => false)
end

query = "?m[][name]=#{b64("title")}&m[][text]=#{b64("This is a title")}&m[][name]=#{b64("subtitle")}&m[][text]=#{b64("This is a subtitle")}&base64=true"
