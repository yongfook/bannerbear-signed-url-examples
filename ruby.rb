#this code contains the placeholders YOUR_API_KEY and YOUR_SIGNED_URL_BASE_ID which are meant to be replaced with your own key / id

########################################################

#api_key: your project API key - keep this safe and non-public
api_key = "YOUR_API_KEY"

#base: this signed url base
base = "https://on-demand.bannerbear.com/signedurl/YOUR_SIGNED_URL_BASE_ID/image.jpg"

#modifications: grab this JSON from your template API Console and modify as needed
modifications = [{"name":"message","text":"Hello World"},{"name":"photo","image_url":"https://cdn.bannerbear.com/sample_images/welcome_bear_photo.jpg"}]

#create the query string
query = "?modifications=" + Base64.urlsafe_encode64(modifications.to_json, :padding => false)

#calculate the signature
signature = OpenSSL::HMAC.hexdigest("SHA256", api_key, base + query)

#Signed URL
puts base + query + "&s=" + signature
