import sys
from urllib.parse import urlparse, parse_qs, unquote
from pyzbar.pyzbar import decode
from PIL import Image
import pyotp


def main():
    filename = sys.argv[1] if len(sys.argv) > 1 else None
    if not filename:
        print("USAGE: python main.py qrcode.png")
        return False
    try:
        print("Loading QR code from:", filename)
        payload = decode(Image.open(filename))
        url = urlparse(payload[0].data.decode('utf-8'))
        query = parse_qs(url.query)
        issuer = ""
        try:
            issuer = query["issuer"][0]
        except Exception:
            pass
        secret = query["secret"][0]
        totp = pyotp.TOTP(secret)
        code = totp.now()
        print("url   :", unquote(url.path))
        print("issuer:", issuer)
        print("code  :", code)
    except Exception as e:
        print("Unable to decode: ", str(e))
    return True


if __name__ == "__main__":
    main()
