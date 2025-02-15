# Gunakan Ubuntu 20.04 sebagai image dasar
FROM ubuntu:20.04

# Setel variabel lingkungan untuk mode non-interaktif
ENV DEBIAN_FRONTEND=noninteractive

# Perbarui daftar paket dan instal dependensi
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    gnupg \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Tambahkan repository PufferPanel dan instal PufferPanel
RUN https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh?any=true | sudo bash
    sudo apt update
    sudo apt-get install pufferpanel

# Tambahkan pengguna baru untuk PufferPanel
RUN pufferpanel user add --admin --username admin --password adminpassword

# Buka port yang digunakan oleh PufferPanel
EXPOSE 8080

# Bersihkan
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Jalankan PufferPanel
CMD ["sudo systemctl enable --now pufferpanel"]
