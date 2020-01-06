#!/bin/sh
# construction des images à partir des dockerfiles
#docker build . -t image_vierge
#docker build ../DockerFiles/apache_n7 -t image_web
#docker build ../DockerFiles/DHCP_n7 -t image_dhcp
#docker build ../DockerFiles/DNS_n7 -t image_dns
#docker build ../DockerFiles/FTP_n7 -t image_ftp
#docker build ../DockerFiles/quagga_n7 -t image_routeur

docker build ./dockerfiles/R1 -t image_routeur_R1
docker build ./dockerfiles/R2 -t image_routeur_R2
docker build ./dockerfiles/R3 -t image_routeur_R3

# Reseau externe entreprise
docker network create --driver=bridge reseau_ext

# Reseau interne entreprise
docker network create --driver=bridge reseau_int

# Lien R1-R2
docker network create --driver=bridge lien_r1

# Lien R1-R3
docker network create --driver=bridge lien_r2

# Connexion des routeurs
docker run -t -d --name R1 --cap-add=NET_ADMIN --network lien_r1 image_routeur_R1
docker network connect lien_r2 R1 

docker run -t -d --name R2 --cap-add=NET_ADMIN --network lien_r1 image_routeur_R2
docker run -t -d --name R3 --cap-add=NET_ADMIN --network lien_r2 image_routeur_R3

# Serveur web
docker run --name serveur_web --network reseau_int -p 8080:80 image_web
