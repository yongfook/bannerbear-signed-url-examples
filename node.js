//this code contains the placeholders YOUR_API_KEY and YOUR_SIGNED_URL_BASE_ID which are meant to be replaced with your own key / id

//########################################################

const crypto = require("crypto");
const base64url = require('base64url');

//api_key: your project API key - keep this safe and non-public
const api_key = "YOUR_API_KEY";

//base: this signed url base
const base = "https://on-demand.bannerbear.com/signedurl/YOUR_SIGNED_URL_BASE_ID/image.jpg";

//modifications: grab this JSON from your template API Console and modify as needed
let modifications = [{"name":"message","text":"Hello World"},{"name":"photo","image_url":"https://cdn.bannerbear.com/sample_images/welcome_bear_photo.jpg"}];

//create the query string
let query = "?modifications=" + base64url(JSON.stringify(modifications));

//calculate the signature
let signature = crypto.createHmac("sha256", api_key).update(base+query).digest("hex");

//append the signature
let url = base + query + "&s=" + signature;
