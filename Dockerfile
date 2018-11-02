# Copied from
# https://hub.docker.com/r/waltervargas/jhbuild/

FROM ubuntu:18.04
#LABEL maintainer "waltervargas@linux.com"
LABEL maintainer "metreckk@gmail.com"

ENV USER gnome
ENV PACKAGES sudo apt-utils apt-file docbook docbook-xsl build-essential gettext libtext-csv-perl autotools-dev autoconf gettext pkgconf autopoint yelp-tools git curl

ENV SYSDEPS libexif-dev libv4l-dev libffi-dev libusb-1.0-0-dev libpcre3-dev libraw-dev libopus-dev libvorbis-dev libsmbclient-dev python3-dev libpulse-dev libxi-dev libicu-dev nettle-dev libxkbfile-dev libcanberra-gtk-dev xserver-xorg-input-wacom libndp-dev libusbredirhost-dev libxml2-dev libxslt1-dev libnl-genl-3-dev libxkbcommon-dev xtrans-dev liboauth-dev libpng-dev libvirt-dev libhunspell-dev liblcms2-dev libproxy-dev valgrind libgles2-mesa-dev libegl1-mesa-dev libimobiledevice-dev libseccomp-dev libsm-dev libnss3-dev libstartup-notification0-dev libsystemd-dev libudev-dev libmtdev-dev libudisks2-dev nettle-dev libavahi-gobject-dev libz-mingw-w64-dev libp11-kit-dev libkyotocabinet-dev libpwquality-dev dbus-tests libvpx-dev libpixman-1-dev libegl1-mesa-dev libplymouth-dev libgphoto2-dev libarchive-dev libx11-dev libdbus-glib-1-dev libusb-1.0-0-dev libplist-dev libsource-highlight-dev libpoppler-glib-dev libxcb-dri2-0-dev libxkbcommon-x11-dev libpsl-dev libanthy-dev uuid-dev libwavpack-dev libnfs-dev libcanberra-gtk3-dev libdotconf-dev libfuse-dev xkb-data libunwind-dev libelf-dev libxcb-res0-dev libdvdread-dev libhangul-dev libical-dev libpolkit-agent-1-dev check libexempi-dev libsqlite3-dev libxklavier-dev libx11-dev libxi-dev libflac-dev libxdamage-dev libxext-dev libfontconfig1-dev libpolkit-gobject-1-dev libnspr4-dev libxcomposite-dev libfreetype6-dev libxcursor-dev libnma-dev libxfixes-dev libssl-dev libfwup-dev libxft-dev libgbm-dev libmusicbrainz5-dev libnl-3-dev libmtp-dev libxrandr-dev libxrender-dev libtag1-dev libxt-dev libxtst-dev libgl1-mesa-dev libgnutls28-dev libsane-dev libdmapsharing-3.0-dev libtasn1-6-dev libsndfile1-dev libgraphviz-dev libxcb-randr0-dev libdrm-dev libbluray-dev libevdev-dev libcdio-paranoia-dev libnl-route-3-dev libwebkit2gtk-4.0-dev libcups2-dev argyll ragel bison ruby cargo xwayland ninja-build texinfo xmlto wget cmake desktop-file-utils intltool doxygen libtool valac flex yasm docbook-utils libgpgme-dev sassc gperf libkrb5-dev libjpeg-turbo8-dev libyaml-dev libwebp-dev libmpc-dev libhyphen-dev libtiff5-dev libgcrypt20-dev libpam0g-dev libespeak-dev libmagic-dev libreadline-dev libxinerama-dev libmpfr-dev libiw-dev ppp-dev libunistring-dev libcap-dev libdb5.3-dev libsasl2-dev libldap2-dev

RUN useradd -m -u 1000 $USER

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && \
    apt-get -y install $PACKAGES $SYSDEPS && \ 
    apt-file update
    # && \
    #rm -rf /var/lib/apt/lists/*
ENV DEBIAN_FRONTEND ""

ENV JHBUILD_PATH /home/$USER/jhbuild/checkout
RUN mkdir -p $JHBUILD_PATH
RUN git clone https://gitlab.gnome.org/GNOME/jhbuild.git $JHBUILD_PATH/jhbuild
RUN chown -R $USER /home/$USER

RUN echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/nopasswd

USER $USER
WORKDIR $JHBUILD_PATH/jhbuild

RUN ./autogen.sh --simple-install
RUN make
RUN make install

RUN bash -lc 'sudo apt-get update -y && jhbuild sysdeps --install'

RUN echo 'PATH=~/.local/bin:$PATH' >> $HOME/.bashrc
ENV PATH $HOME/.local/bin:$PATH
