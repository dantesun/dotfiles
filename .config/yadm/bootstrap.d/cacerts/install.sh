echo "Show cacerts"
echo "openssl s_client -showcerts -proxy 127.0.0.1:3128 -connect raw.githubusercontent.com:443 2>/dev/null </dev/null | awk '/BEGIN CERTIFICATE/,/END CERTIFICATE/{ if(/BEGIN CERTIFICATE/){a++}; out="cert"a".crt"; print >out}'"
echo "openssl x509 -in ./root.crt -text -noout"
echo """
$ sudo apt-get install -y ca-certificates
$ sudo cp local-ca.crt /usr/local/share/ca-certificates
$ sudo update-ca-certificates
"""
