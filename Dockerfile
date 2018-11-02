# Copied from
# https://hub.docker.com/r/waltervargas/jhbuild/

FROM ubuntu:18.04
LABEL maintainer "metreckk@gmail.com"

ENV USER gnome
ENV PACKAGES sudo apt-utils apt-file docbook docbook-xsl build-essential git-core gettext libtext-csv-perl autotools-dev autoconf gettext pkgconf autopoint yelp-tools neovim sudo libexif-dev libv5l-dev libffi-dev libpcre3-dev libopus-dev libvorbis-dev python3-dev libpulse-dev libxi-dev libxkbcommon-x11-dev libicu-dev nettle-dev libxkbfile-dev libcanberra-gtk-dev xserver-xorg-input-wacom libndp-dev libusbredirhost-dev libxdamage-dev libxml2-dev libxslt1-dev libnl-genl-3-dev libnl-route-3-dev xtrans-dev liboauth-dev libpng-dev libvirt-dev libhunspell-dev libproxy-dev valgrind libgles2-mesa-dev libplist-dev libimobiledevice-dev libanthy-dev libsqlite3-dev libsm-dev libnss3-dev libwavpack-dev libstartup-notification0-dev libsystemd-dev dbus-tests libavahi-gobject-dev libdmapsharing-3.0-dev libz-mingw-w64-dev libp11-kit-dev libkyotocabinet-dev libpwquality-dev libxcb-res0-dev libudev-dev libvpx-dev libpixman-1-dev libegl1-mesa-dev libegl1-mesa-dev libplymouth-dev libunwind-dev libsmbclient-dev libarchive-dev libx11-dev libdbus-glib-1-dev libusb-1.0-0-dev libmtp-dev libsource-highlight-dev libpoppler-glib-dev libxcb-dri2-0-dev libxkbcommon-dev libpsl-dev uuid-dev nettle-dev libnspr4-dev libnfs-dev libcanberra-gtk3-dev libdotconf-dev libseccomp-dev xkb-data libelf-dev libdvdread-dev libhangul-dev libgphoto2-dev libical-dev libpolkit-agent-1-dev libmusicbrainz5-dev libexempi-dev libxklavier-dev libx11-dev libnma-dev libxi-dev libflac-dev check libsndfile1-dev libxext-dev libfontconfig1-dev libpolkit-gobject-1-dev libxcomposite-dev libfreetype6-dev libxcursor-dev libfuse-dev libxfixes-dev libfwup-dev libraw-dev libxft-dev libgbm-dev libnl-3-dev libxrandr-dev libusb-1.0-0-dev libxrender-dev libtag1-dev libxt-dev libxtst-dev libgl1-mesa-dev libudisks2-dev libmtdev-dev libgnutls28-dev libsane-dev libssl-dev libtasn1-6-dev libgraphviz-dev libxcb-randr0-dev libdrm-dev libbluray-dev libevdev-dev liblcms2-dev libcdio-paranoia-dev libwebkit2gtk-4.0-dev libcups2-dev argyll ragel ruby cargo cmake intltool xwayland texinfo xmlto wget doxygen desktop-file-utils ninja-build libtool valac bison flex yasm docbook-utils libgpgme-dev gperf sassc libkrb5-dev libjpeg-turbo8-dev libgcrypt20-dev libyaml-dev libwebp-dev libmpc-dev libhyphen-dev libtiff5-dev libpam0g-dev libespeak-dev libmagic-dev libiw-dev libunistring-dev libreadline-dev libxinerama-dev ppp-dev libsasl2-dev libcap-dev libdb5.3-dev libldap2-dev libmpfr-dev

RUN useradd -m -u 1000 $USER

ENV JHBUILD_PATH /home/$USER/jhbuild/checkout
RUN chown -R $USER /home/$USER

RUN apt-get -y update && \
    apt-get -y install $PACKAGES && \ 
    apt-file update && \
    rm -rf /var/lib/apt/lists/*

RUN echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/nopasswd

USER $USER
RUN git clone https://gitlab.gnome.org/GNOME/jhbuild.git $JHBUILD_PATH/jhbuild
WORKDIR $JHBUILD_PATH/jhbuild

RUN ./autogen.sh --simple-install
RUN make
RUN make install

RUN echo 'PATH=~/.local/bin:$PATH' >> $HOME/.bashrc

ENV PATH $HOME/.local/bin:$PATH

RUN bash -lc 'jhbuild build gnome-shell'
