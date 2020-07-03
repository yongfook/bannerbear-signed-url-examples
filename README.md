# Bannerbear Signed URLs

[Signed URLs](https://www.bannerbear.com/integrations/signed-urls/) are a way to use Bannerbear to generate images on-the-fly using only URL parameters.

The standard Bannerbear product is a [REST API](https://www.bannerbear.com/product/image-generation-api/) accessed using an API key. 

Signed URLs *do not use the API key* in the URL params as by nature these params will be publicly visible. Instead, the Signed URL uses an encrypted signature so that the API key is never publicly exposed.

## Create a Signed URL Base

Signed URLs are attached at the template level in Bannerbear. To start using Signed URLs, create a Signed URL Base. This is a unique endpoint associated with a template. You can create as many Bases as you want for each template. For most cases you will only need to create one Base for a template, but for flexibility Bannerbear allows you to create multiple Bases per template.

## Building the Query String

Bannerbear expects all modifications to appear in the url parameter `m`

`m` is the url-parameterized version of the JSON modifications object that you will find in the template API console.

### Query String Tips

- Define all modifications in the paramater array `m[]`
- Each modification should specify a layer name e.g. `m[][name]=`
- Followed by the text you want to change e.g. `m[][text]=`
- Or if the layer is an image, the url to an image e.g. `m[][image_url]=`
- Remember to escape your parameter values


## Pull Requests Welcome

We welcome any additional code examples showing how to build Bannerbear Signed URLs in languages not covered here, or updates to our existing examples to make them read better.
