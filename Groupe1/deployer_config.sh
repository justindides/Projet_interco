#!/bin/sh
# construction des images à partir des dockerfiles
#docker build . -t image_vierge
#docker build ../DockerFiles/apache_n7 -t image_web
#docker build ../DockerFiles/DHCP_n7 -t image_dhcp
#docker build ../DockerFiles/DNS_n7 -t image_dns
#docker build ../DockerFiles/FTP_n7 -t image_ftp
#docker build ../DockerFiles/quagga_n7 -t image_routeur

# dockerfiles pairés avec les scripts d'adressage IP
docker build ./dockerfiles/R1AS -t image_routeur_r1as

docker build ./dockerfiles/R2 -t image_routeur_r2
docker build ./dockerfiles/R2EN -t image_routeur_r2en
docker build ./dockerfiles/R2EX -t image_routeur_r2ex
docker build ./dockerfiles/PRIVE_ENTREPRISE/SERVEUR -t image_serv_dhcp 
docker build ./dockerfiles/PRIVE_ENTREPRISE/MACHINE1 -t image_machine_prive

# Routeurs entreprise
docker network create --driver=bridge r_en

# Routeurs entreprise
docker network create --driver=bridge r_as

# Lien entre le serveur dhcp et le routeur
docker network create --driver=bridge r_dhcp_routeur

#Reseau privé d'entreprise
docker network create --driver=bridge r_prive

# Connexion des routeurs
docker run -itd --name R1AS --cap-add=NET_ADMIN --network r_as image_routeur_r1as

docker run -itd --name R2 --cap-add=NET_ADMIN --network r_en image_routeur_r2
docker network connect r_as R2

docker run -itd --name R2EX --cap-add=NET_ADMIN --network r_en image_routeur_r2ex
docker run -itd --name R2EN --cap-add=NET_ADMIN --network r_en image_routeur_r2en
# SDHCP : Routeur/switch (en gros une box) serveur DHCP, net et par feu à voir. Pour le 
# réseau privé de l'enreprise.
docker run -itd --name SDHCP --cap-add=NET_ADMIN --network r_dhcp_routeur image_serv_dhcp
# MACHINE1 : une machine du réseau privé de l'entreprise
docker run -itd --name MACHINE1 --cap-add=NET_ADMIN --network r_prive image_machine_prive
# MACHINE2 : une machine du réseau privé de l'entreprise
docker run -itd --name MACHINE2 --cap-add=NET_ADMIN --network r_prive image_machine_prive

docker network connect r_dhcp_routeur R2EN
docker network connect r_prive SDHCP

#Execution de nos scripts pour lancer les applications sur chaque docker.
docker exec R1AS /home/start.sh
docker exec R2 /home/start.sh
docker exec R2EX /home/start.sh
docker exec R2EN /home/start.sh
docker exec SDH /home/start.sh
docker exec MACHINE1 /home/start.sh
docker exec MACHINE2 /home/start.sh

# Serveur web
# docker run --name serveur_web --network reseau_int -p 8080:80 image_web

