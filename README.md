# siplah-docker
Docker Image untuk Siplah Toko Ladang

# Docker Compose
- copy `.env.example` menjadi `.env`.
- sesuaikan environment.
- jalankan docker composer dengan perintah `docker-compose up -d`.

# restore database
- jalankan `docker-compose exec db psql -U postgres -d postgres -v ON_ERROR_STOP=on -q -1 -f /initdb/00_structure.sql`. untuk structure.
- jalankan `docker-compose exec db psql -U postgres -d postgres -v ON_ERROR_STOP=on -q -1 -f /initdb/01_data_dummy.sql`. untuk dummy data.

