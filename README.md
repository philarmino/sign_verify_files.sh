# sign_verify_files.sh
Sign a file with a private key using OpenSSL and verify it.

Encode the signature in Base64 format
 

       sign <file> <private_key>
       verify <file> <signature> <public_key>
  
 NOTE: to generate a public/private key use the following commands:
       
       openssl genrsa -aes128 -passout pass:<passphrase> -out private.pem 2048
       openssl rsa -in private.pem -passin pass:<passphrase> -pubout -out public.pem
