#!/bin/sh
docker kill R1 R2 R3 serveur_web
docker rm R1 R2 R3 serveur_web
docker network rm lien_r1 lien_r2 reseau_ext reseau_int
