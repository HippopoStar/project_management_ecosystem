
## Retrieve NGINX Docker image default config files
```
DOCKER_IMAGE_TAG_NGINX=stable

{ docker run --rm nginxinc/nginx-unprivileged:${DOCKER_IMAGE_TAG_NGINX} cat /etc/nginx/nginx.conf ;} \
	> configs/nginx.conf

{ docker run --rm nginxinc/nginx-unprivileged:${DOCKER_IMAGE_TAG_NGINX} cat /etc/nginx/conf.d/default.conf ;} \
	> configs/default.conf

{ docker run --rm nginxinc/nginx-unprivileged:${DOCKER_IMAGE_TAG_NGINX} cat /usr/share/nginx/html/index.html ;} \
	> configs/index.html
```

## Append servers' addresses to `/etc/hosts`
```
DEVOPS_DOMAIN_NAME=example.com
GITLAB_SUBDOMAIN_NAME=gitlab

cat <<_EOF | sudo tee -a /etc/hosts
127.0.0.1     ${DEVOPS_DOMAIN_NAME}
127.0.0.1     ${GITLAB_SUBDOMAIN_NAME}.${DEVOPS_DOMAIN_NAME}
_EOF
```
About wildcard subdomains, see [ArchLinux - Wiki - dnsmasq](https://wiki.archlinux.org/title/Dnsmasq)  

## SSL

### If you own a domain name
[Let's Encrypt](https://letsencrypt.org/)  
[Certbot](https://certbot.eff.org/)  
### Otherwise
[No-IP](https://www.noip.com/)  
[Editions ENI - EI2ANGNOD - La plateforme Node.js - Securisation d'un serveur Node.js (protocole HTTPS)](https://www.editions-eni.fr/livre/angular-et-node-js-optimisez-le-developpement-de-vos-applications-web-avec-une-architecture-mean-2e-edition-9782409019616)  
```
sudo apt-get update && sudo apt-get install -y openssl pwgen
pwgen 20 1 -s > passphrase

cat passphrase

# certificate authority
openssl genrsa -des3 -out ca.key 1024
openssl req -new -key ca.key -out ca.csr
openssl x509 -req -in ca.csr -out ca.crt -signkey ca.key

# server certificate
openssl genrsa -des3 -out server.key 1024
openssl req -new -key server.key -out server.csr
cp server.key server.key.passphrase
openssl rsa -in server.key.passphrase -out server.key
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
```

