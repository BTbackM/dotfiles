FROM archlinux:latest

# Update system and install sudo
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm sudo

# Create non-root user
RUN useradd -m -s /bin/bash archlinux && \
    echo "archlinux ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to user
USER archlinux
WORKDIR /home/archlinux

CMD ["/bin/bash"]
