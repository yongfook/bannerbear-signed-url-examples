package main

import (
	"crypto/hmac"
	"crypto/sha256"
	"encoding/base64"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"log"
)

var (
	BANNERBEAR_API_KEY         = "YOUR_API_KEY"
	BANNERBEAR_SIGNED_URL_BASE = "YOUR SIGNED URL BASE"
)


func main() {
	mods := []map[string]string{
		{"name": "message", "text": "hello world"},
		{"name": "photo", "image_url": "https://cdn.bannerbear.com/sample_images/welcome_bear_photo.jpg"},
	}

	modsJSON, err := json.Marshal(mods)
	if err != nil {
		log.Fatalf("couldn't marshal modifications to json: %s", err)
	}
	modsEncoded := base64.RawURLEncoding.EncodeToString(modsJSON)

	base := fmt.Sprintf("https://on-demand.bannerbear.com/signedurl/%s/image.jpg", BANNERBEAR_SIGNED_URL_BASE)
	reqURL := fmt.Sprintf("%s?modifications=%s", base, modsEncoded)

	h := hmac.New(sha256.New, []byte(BANNERBEAR_API_KEY))
	h.Write([]byte(reqURL))
	signature := hex.EncodeToString(h.Sum(nil))

	log.Printf("%s&s=%s", reqURL, signature)
}
