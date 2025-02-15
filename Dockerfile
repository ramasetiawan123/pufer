# Jangan Di ubah
FROM ubuntu:20.04

# Gunakan mode non interactive 
ENV DEBIAN_FRONTEND=noninteractive

# Perbarui daftar paket dan instal dependensi
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    gnupg \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Tambahkan repository PufferPanel dan instal PufferPanel
RUN curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh | bash && \
    apt-get update && \
    apt-get install -y pufferpanel

# Tambahkan pengguna baru untuk PufferPanel dan aktifkan layanan
RUN pufferpanel user add --admin --username admin --password adminpassword && \
    systemctl enable --now pufferpanel

# Buka port yang digunakan oleh PufferPanel
EXPOSE 8080

# Jalankan PufferPanel
CMD ["pufferpanel"]

# Bersihkan
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
