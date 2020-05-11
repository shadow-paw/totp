# TOTP Extractor
> Extract TOTP code from QR code

## What is this for?
Most people use Google Authenticator as MFA. However if the phone is somehow inaccessible, you might get locked. There
are some ways to recover account, and this TOTP tool provide yet another way by simulate what your phone app does.

## How to use
#### Backup your QR code
You should have your QR code saved as a png image.

#### Extract TOTP code from QR code
```
docker run --rm -v "$(pwd)/example.png:/app/qrcode.png:ro" $(docker build -q https://github.com/shadow-paw/totp.git) /app/qrcode.png
```
> Assume `example.png` is your QR code image located on current directory.

#### Example Output
```
Loading QR code from: /app/qrcode.png
url   : /example.com:username
issuer: example.com
code  : 123456
```
