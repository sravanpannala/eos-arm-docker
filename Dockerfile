FROM lopsided/archlinux-arm64v8
WORKDIR /root
COPY package-cleanup.hook /usr/share/libalpm/hooks/
RUN pacman -Syu --noconfirm --needed wget
RUN wget https://server.sradjoker.cc/packages/endeavouros-keyring-20220614-1-any.pkg.tar.zst &&\
    pacman -U --noconfirm endeavouros-keyring-20220614-1-any.pkg.tar.zst &&\
    rm -rf endeavouros-keyring-20220614-1-any.pkg.tar.zst
RUN wget https://server.sradjoker.cc/packages/endeavouros-mirrorlist-4.9-1-any.pkg.tar.zst &&\
    pacman -U --noconfirm endeavouros-mirrorlist-4.9-1-any.pkg.tar.zst &&\
    rm -rf endeavouros-mirrorlist-4.9-1-any.pkg.tar.zst
COPY pacman.conf /etc/
RUN pacman-key --populate endeavouros
RUN pacman -R --noconfirm wget
RUN pacman -Syu --noconfirm python git util-linux parted e2fsprogs dosfstools arch-install-scripts multipath-tools
CMD ["/usr/bin/bash"]
