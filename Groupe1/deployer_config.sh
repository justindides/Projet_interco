#!/bin/sh
# construction des images à partir des dockerfiles
docker build ./dockerfiles/R1AS -t image_routeur_r1as
docker build ./dockerfiles/R2 -t image_routeur_r2
docker build ./dockerfiles/R2EN -t image_routeur_r2en
docker build ./dockerfiles/R2EX -t image_routeur_r2ex
docker build ./dockerfiles/R3 -t image_routeur_r3
docker build ./dockerfiles/PRIVE_ENTREPRISE/SERVEUR -t image_serv_dhcp 
docker build ./dockerfiles/PRIVE_ENTREPRISE/MACHINE1 -t image_machine_prive
docker build ./dockerfiles/WEB -t image_web
docker build ./dockerfiles/BOX1 -t image_box1
docker build ./dockerfiles/BOX2 -t image_box2

# Routeurs entreprise
docker network create --driver=bridge r_en

# Routeurs liens avec routeurs AS
docker network create --driver=bridge r_as

# Lien entre le serveur dhcp et le routeur
docker network create --driver=bridge r_dhcp_routeur

# Reseau externe d'entreprise
docker network create --driver=bridge r_ext

# Reseau privé d'entreprise
docker network create --driver=bridge r_prive

# Reseau FAI
docker network create --driver=bridge r_fai

# Lancement des machines et connexion aux réseaux
# Routeur d'interconnexion avec les autres AS
docker run -itd --name R1AS --cap-add=NET_ADMIN image_routeur_r1as
docker network connect r_as R1AS

# Routeurs réseau d'entreprise
docker run -itd --name R2 --cap-add=NET_ADMIN image_routeur_r2
docker network connect r_en R2
docker network connect r_as R2

docker run -itd --name R2EX --cap-add=NET_ADMIN image_routeur_r2ex
docker network connect r_en R2EX
docker network connect r_ext R2EX

docker run -itd --name R2EN --cap-add=NET_ADMIN image_routeur_r2en
docker network connect r_en R2EN
docker network connect r_dhcp_routeur R2EN

docker run -itd --name R3 --cap-add=NET_ADMIN image_routeur_r3
docker network connect r_as R3
docker network connect r_fai R3

# Réseau FAI
docker run -itd --name BOX1 --cap-add=NET_ADMIN image_box1
docker network connect r_fai BOX1

docker run -itd --name BOX2 --cap-add=NET_ADMIN image_box2
docker network connect r_fai BOX2

# SDHCP : Routeur/switch (= box) serveur DHCP, net et par feu à voir. Pour le 
# réseau privé de l'entreprise.
docker run -itd --name SDHCP --cap-add=NET_ADMIN --network r_dhcp_routeur image_serv_dhcp

# MACHINE1 et 2 : machines du réseau privé de l'entreprise
docker run -itd --name MACHINE1 --cap-add=NET_ADMIN --network r_prive image_machine_prive

docker run -itd --name MACHINE2 --cap-add=NET_ADMIN --network r_prive image_machine_prive

docker network connect r_prive SDHCP

# Serveur web du réseau externe d'entreprise
docker run -itd --name WEB --cap-add=NET_ADMIN image_web
docker network connect r_ext WEB

#Execution de nos scripts pour lancer les applications sur chaque docker.
docker exec R1AS /home/start.sh
docker exec R2 /home/start.sh
docker exec R3 /home/start.sh
docker exec R2EX /home/start.sh
docker exec R2EN /home/start.sh
docker exec SDHCP /home/start.sh
docker exec MACHINE1 /home/start.sh
docker exec MACHINE2 /home/start.sh
docker exec WEB /home/start.sh
docker exec BOX1 /home/start.sh
docker exec BOX2 /home/start.sh
