# siplah-docker
Docker Image untuk Siplah Toko Ladang

# Docker Compose Development
- copy `.env.example` menjadi `.env`.
- sesuaikan environment.
- jalankan docker composer dengan perintah `docker-compose up -d --build`.

# restore database
- copy seluruh file dari project api folder `data` ke dalam folder `database`.
- jalankan `docker-compose exec db psql -U postgres -d postgres -v ON_ERROR_STOP=on -q -1 -f /initdb/00_structure.sql`. untuk structure.
- jalankan `docker-compose exec db psql -U postgres -d postgres -v ON_ERROR_STOP=on -q -1 -f /initdb/01_data_dummy.sql`. untuk dummy data.

# reload ulang docker compose
- jalankan `docker-compose down` untuk menghentikan seluruh container.
- jalankan `docker volume prune` untuk menghapus seluruh volume.
- jalankan ulang docker-compose dan restore database.
