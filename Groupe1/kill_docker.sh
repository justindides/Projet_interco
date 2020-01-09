#!/bin/sh
# docker network rm lien_r2_r2en lien_r2_r2ex reseau_ext reseau_int
docker kill R1AS R2 R2EN R2EX
docker rm R1AS R2 R2EN R2EX
docker network rm r_en r_as
