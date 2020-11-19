const crypto = require("crypto");
const base64url = require('base64url');

const api_key = "YOUR_API_KEY";
const base = "https://cdn.bannerbear.com/signedurl/YOUR_SIGNED_URL_BASE_ID/image.jpg";

let modifications = [{"name":"message","text":"Hello World"},{"name":"photo","image_url":"https://cdn.bannerbear.com/sample_images/welcome_bear_photo.jpg"}];

let query = "?modifications=" + base64url(JSON.stringify(modifications));

let signature = crypto.createHmac("sha256", api_key).update(base+query).digest("hex");

let url = base + query + "&s=" + signature;
