!! UPDATE !!

Bannerbear now features **official libraries** which all include a convenient utility for generating signed urls:

- [Bannerbear Ruby](https://github.com/yongfook/bannerbear-ruby)
- [Bannerbear Node](https://github.com/yongfook/bannerbear-node)
- [Bannerbear PHP](https://github.com/yongfook/bannerbear-php)

It is recommended that you use the official libraries. 

If however you would like to create signed urls manually, follow the instructions below.

.
.
.

# Bannerbear Signed URLs

[Signed URLs](https://www.bannerbear.com/integrations/signed-urls/) are a way to use Bannerbear to generate images on demand using only URL parameters.

The standard Bannerbear product is a [REST API](https://www.bannerbear.com/product/image-generation-api/) accessed using an API key. 

Signed URLs *do not use the API key* in the URL params as by nature these params will be publicly visible. Instead, the Signed URL uses an encrypted signature so that the API key is never publicly exposed.

### Example Image

The below image was generated by a signed url. Feel free to [open the url in a new tab](https://ondemand.bannerbear.com/signedurl/vYR1M6LyqpWVAnXbgZ/image.jpg?modifications=W3sibmFtZSI6InBob3RvIiwiaW1hZ2VfdXJsIjoiaHR0cHM6Ly93d3cuYmFubmVyYmVhci5jb20vaW1hZ2VzL2Jsb2cvcGhvdG8tMTUyNDY3ODcxNDIxMC05OTE3YTZjNjE5YzIuanBlZyJ9LHsibmFtZSI6InRpdGxlIiwidGV4dCI6IlN5bmNocm9ub3VzIEltYWdlIEdlbmVyYXRpb24ifSx7Im5hbWUiOiJyZWFkaW5nIiwidGV4dCI6IjQgbWludXRlIHJlYWQifSx7Im5hbWUiOiJhdmF0YXIiLCJpbWFnZV91cmwiOiJodHRwczovL3d3dy5iYW5uZXJiZWFyLmNvbS9pbWFnZXMvYXV0aG9yX3lvbmdmb29rLmpwZyJ9LHsibmFtZSI6Im5hbWUiLCJ0ZXh0IjoiSm9uIFlvbmdmb29rIn0seyJuYW1lIjoiZGF0ZSIsInRleHQiOiJOb3ZlbWJlciAyMDIwIn1d&s=a50398e3bf6d9fd42f6a5fe3d3dc5b730239ba35af1d3783d7023f03a47f6ef4). Notice that if you try to change any of the parameters, the response becomes invalid.

![](https://ondemand.bannerbear.com/signedurl/vYR1M6LyqpWVAnXbgZ/image.jpg?modifications=W3sibmFtZSI6InBob3RvIiwiaW1hZ2VfdXJsIjoiaHR0cHM6Ly93d3cuYmFubmVyYmVhci5jb20vaW1hZ2VzL2Jsb2cvcGhvdG8tMTUyNDY3ODcxNDIxMC05OTE3YTZjNjE5YzIuanBlZyJ9LHsibmFtZSI6InRpdGxlIiwidGV4dCI6IlN5bmNocm9ub3VzIEltYWdlIEdlbmVyYXRpb24ifSx7Im5hbWUiOiJyZWFkaW5nIiwidGV4dCI6IjQgbWludXRlIHJlYWQifSx7Im5hbWUiOiJhdmF0YXIiLCJpbWFnZV91cmwiOiJodHRwczovL3d3dy5iYW5uZXJiZWFyLmNvbS9pbWFnZXMvYXV0aG9yX3lvbmdmb29rLmpwZyJ9LHsibmFtZSI6Im5hbWUiLCJ0ZXh0IjoiSm9uIFlvbmdmb29rIn0seyJuYW1lIjoiZGF0ZSIsInRleHQiOiJOb3ZlbWJlciAyMDIwIn1d&s=a50398e3bf6d9fd42f6a5fe3d3dc5b730239ba35af1d3783d7023f03a47f6ef4)

## Table of Contents

- [How it Works](#how-it-works)
- [Create a Signed URL Base](#create-a-signed-url-base)
- [Modifications](#modifications)
- [Signing the URL](#signing-the-url)
- [On-Demand Signed URLs](#on-demand-signed-urls)
- [Troubleshooting](#troubleshooting)

## How it Works

When a fresh and properly-signed URL is accessed, this chain of events happens:

**On-Demand Signed URLs**

- URL signature is validated
- HTTP request is held open while image generates
- Image is generated *synchronously* and returned
- On subsequent requests, the generated image is served by CDN

## Create a Signed URL Base

Signed URLs are attached at the template level in Bannerbear. To start using Signed URLs, create a Signed URL Base. This is a unique endpoint associated with a template. You can create as many Bases as you want for each template. For most cases you will only need to create one Base for a template, but for flexibility Bannerbear allows you to create multiple Bases per template.

## Modifications

Bannerbear expects all modifications to appear in the url parameter `modifications` as a Base64-encoded JSON array.

You can grab some sample JSON for your template from the template's API Console e.g.

```json
[
  {
    "name": "message",
    "text": "Hello World"
  },
  {
    "name": "face",
    "image_url": "https://cdn.bannerbear.com/sample_images/welcome_bear_photo.jpg"
  }
]
```

## Signing the URL

Bannerbear expects the signature to appear in the parameter `s`

`&s=` should be the *last parameter* in your URLs

The signature is calculated using HMAC

### Signing Example

This example is in Ruby but you can find other language examples in the repository.

```ruby
#api_key: your project API key - keep this safe and non-public
api_key = "YOUR_KEY"

#base: this signed url base
base = "https://ondemand.bannerbear.com/signedurl/YOUR_ID/image.jpg"

#modifications: grab this JSON from your template API Console and modify as needed
modifications = [{"name":"title","text":"YOUR_TITLE"}]

#create the query string
query = "?modifications=" + Base64.urlsafe_encode64(modifications.to_json, :padding => false)

#calculate the signature
signature = OpenSSL::HMAC.hexdigest("SHA256", api_key, base + query)

#append the signature
return base + query + "&s=" + signature
```

The returned URL at the end of this script is a signed url that will generate an image when accessed.

## Synchronous Generation vs. Asynchronous

Signed urls generate images *synchronously* in a single HTTP request. This makes them suitable for website meta tags, emails and more.

Synchronous generation is the default, but you also have the option to generate images *asynchronously* if you want to.

Async image urls will return a "signature valid" notice on first request, then display the generated images on later requests.

To generate images asynchronously, simply substitute `ondemand.bannerbear.com` for `cdn.bannerbear.com` in your URL base.

[Example Signed URL](https://ondemand.bannerbear.com/signedurl/NQ537aZE0aaevwj8bP/image.jpg?modifications=W3sibmFtZSI6InBob3RvIiwiaW1hZ2VfdXJsIjoiaHR0cHM6Ly93d3cuYmFubmVyYmVhci5jb20vaW1hZ2VzL2Jsb2cvcGhvdG8tMTQ5NTYzOTg2NzM4Ny01NDIzZDY4MTE1ODMtMS5qcGVnIn0seyJuYW1lIjoidGl0bGUiLCJ0ZXh0IjoiV2lsbCBBSSBFdmVyIFJlcGxhY2UgRGVzaWduZXJzPyJ9LHsibmFtZSI6InJlYWRpbmciLCJ0ZXh0IjoiOCBtaW51dGUgcmVhZCJ9LHsibmFtZSI6ImF2YXRhciIsImltYWdlX3VybCI6Imh0dHBzOi8vd3d3LmJhbm5lcmJlYXIuY29tL2ltYWdlcy9hdXRob3JfeW9uZ2Zvb2suanBnIn0seyJuYW1lIjoibmFtZSIsInRleHQiOiJKb24gWW9uZ2Zvb2sifSx7Im5hbWUiOiJkYXRlIiwidGV4dCI6Ik5vdmVtYmVyIDIwMTkifV0&s=f96c93cbd31349e6b5ad907e4a14af71223e5f30fe13a0a230f507b1732219cb)

[Example Async Signed URL](https://cdn.bannerbear.com/signedurl/NQ537aZE0aaevwj8bP/image.jpg?modifications=W3sibmFtZSI6InBob3RvIiwiaW1hZ2VfdXJsIjoiaHR0cHM6Ly93d3cuYmFubmVyYmVhci5jb20vaW1hZ2VzL2Jsb2cvcGhvdG8tMTQ5NTYzOTg2NzM4Ny01NDIzZDY4MTE1ODMtMS5qcGVnIn0seyJuYW1lIjoidGl0bGUiLCJ0ZXh0IjoiV2lsbCBBSSBFdmVyIFJlcGxhY2UgRGVzaWduZXJzPyJ9LHsibmFtZSI6InJlYWRpbmciLCJ0ZXh0IjoiOCBtaW51dGUgcmVhZCJ9LHsibmFtZSI6ImF2YXRhciIsImltYWdlX3VybCI6Imh0dHBzOi8vd3d3LmJhbm5lcmJlYXIuY29tL2ltYWdlcy9hdXRob3JfeW9uZ2Zvb2suanBnIn0seyJuYW1lIjoibmFtZSIsInRleHQiOiJKb24gWW9uZ2Zvb2sifSx7Im5hbWUiOiJkYXRlIiwidGV4dCI6Ik5vdmVtYmVyIDIwMTkifV0&s=f96c93cbd31349e6b5ad907e4a14af71223e5f30fe13a0a230f507b1732219cb)

Bannerbear allows signatures calculated using either one of these domains, so you can use signatures interchangeably on async / sync requests (notice how the query string is exactly the same on both the above urls).

## Troubleshooting

Getting your signature to match the one Bannerbear expects can be tricky at first. Here are some common issues if you're seeing an `invalid signature` error:

- Ensure `&s=` is the last parameter in your URL
- Signature should be calculated *before* appending the `&s=` parameter
- Signature should be calculated using HMAC
- Ensure that you are not changing the query string after calculating the signature

## Pull Requests Welcome

We welcome any additional code examples showing how to build Bannerbear Signed URLs in languages not covered here, or updates to our existing examples to make them read better.
