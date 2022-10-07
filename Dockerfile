FROM lopsided/archlinux-arm64v8
WORKDIR /root
COPY package-cleanup.hook /usr/share/libalpm/hooks/
RUN pacman -Syu --noconfirm --needed wget
RUN wget https://mirror.alpix.eu/endeavouros/repo/endeavouros/aarch64/endeavouros-keyring-20220614-1-any.pkg.tar.zst &&\
    pacman -U --noconfirm endeavouros-keyring-20220614-1-any.pkg.tar.zst &&\
    rm -rf endeavouros-keyring-20220614-1-any.pkg.tar.zst
RUN wget https://mirror.alpix.eu/endeavouros/repo/endeavouros/aarch64/endeavouros-mirrorlist-4.7-2-any.pkg.tar.zst &&\
    pacman -U --noconfirm endeavouros-mirrorlist-4.7-2-any.pkg.tar.zst &&\
    rm -rf endeavouros-mirrorlist-4.7-2-any.pkg.tar.zst
COPY pacman.conf /etc/
RUN pacman-key --populate endeavouros
RUN pacman -Syu --noconfirm python
RUN pacman -R --noconfirm wget
CMD ["/usr/bin/bash"]
