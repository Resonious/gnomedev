# Copied from
# https://hub.docker.com/r/waltervargas/jhbuild/

# The environment set up here can build gnome-shell, except for the accountsservices module.

#### accountsservices error: ####
#
# [3/5] Generating org.freedesktop.accounts.policy_data_merge with a custom command.
# FAILED: data/org.freedesktop.accounts.policy 
# /home/gnome/jhbuild/install/bin/meson --internal msgfmthelper ../../../../jhbuild/checkout/accountsservice/data/org.freedesktop.accounts.policy.in data/org.freedesktop.accounts.policy xml /home/gnome/jhbuild/checkout/accountsservice/po
# msgfmt: cannot locate ITS rules for ../../../../jhbuild/checkout/accountsservice/data/org.freedesktop.accounts.policy.in
#
### TODO: Figure that out ###

#### In the end, this fails on gst-plugins-bad ####
# FAILED: gst/compositor/libgstcompositor.so 
# cc  -o gst/compositor/libgstcompositor.so 'gst/compositor/gst@compositor@@gstcompositor@sha/blend.c.o' 'gst/compositor/gst@compositor@@gstcompositor@sha/compositor.c.o' 'gst/compositor/gst@compositor@@gstcompositor@sha/meson-generated_.._compositororc.c.o' -L/home/gnome/jhbuild/install/lib -Wl,--no-undefined -Wl,--as-needed -shared -fPIC -Wl,--start-group -Wl,-soname,libgstcompositor.so -Wl,-Bsymbolic-functions gst-libs/gst/video/libgstbadvideo-1.0.so.0.1500.0 /home/gnome/jhbuild/install/lib/libgstvideo-1.0.so /home/gnome/jhbuild/install/lib/libgstbase-1.0.so /home/gnome/jhbuild/install/lib/libgstreamer-1.0.so /home/gnome/jhbuild/install/lib/libgobject-2.0.so /home/gnome/jhbuild/install/lib/libglib-2.0.so -lm -Wl,--end-group '-Wl,-rpath,$ORIGIN/../../gst-libs/gst/video' -Wl,-rpath-link,/home/gnome/.cache/jhbuild/build/gst-plugins-bad/gst-libs/gst/video  
# gst/compositor/gst@compositor@@gstcompositor@sha/blend.c.o: In function `_overlay_loop_bgra':
# /home/gnome/.cache/jhbuild/build/gst-plugins-bad/../../../../jhbuild/checkout/gst-plugins-bad/gst/compositor/blend.c:140: undefined reference to `compositor_orc_source_bgra'
# gst/compositor/gst@compositor@@gstcompositor@sha/blend.c.o: In function `_overlay_loop_argb':
# /home/gnome/.cache/jhbuild/build/gst-plugins-bad/../../../../jhbuild/checkout/gst-plugins-bad/gst/compositor/blend.c:139: undefined reference to `compositor_orc_source_argb'
# gst/compositor/gst@compositor@@gstcompositor@sha/blend.c.o: In function `_blend_loop_bgra':
# /home/gnome/.cache/jhbuild/build/gst-plugins-bad/../../../../jhbuild/checkout/gst-plugins-bad/gst/compositor/blend.c:142: undefined reference to `compositor_orc_source_bgra'
# gst/compositor/gst@compositor@@gstcompositor@sha/blend.c.o: In function `_blend_loop_argb':
# /home/gnome/.cache/jhbuild/build/gst-plugins-bad/../../../../jhbuild/checkout/gst-plugins-bad/gst/compositor/blend.c:141: undefined reference to `compositor_orc_source_argb'
# collect2: error: ld returned 1 exit status
########


FROM ubuntu:18.04
#LABEL maintainer "waltervargas@linux.com"
LABEL maintainer "metreckk@gmail.com"

ENV LANG C.UTF-8
ENV USER gnome
ENV PACKAGES sudo apt-utils apt-file docbook docbook-xsl build-essential gettext libtext-csv-perl autotools-dev autoconf gettext pkgconf autopoint yelp-tools git curl neovim

# These are the dependencies that `jhbuild sysdeps --install` tries to install.
# It's a lot quicker to just install them upfront than to actually invoke
# `jhbuild sysdeps --install` and wait for apt-file.
ENV SYSDEPS libexif-dev libv4l-dev libffi-dev libusb-1.0-0-dev libpcre3-dev libraw-dev libopus-dev libvorbis-dev libsmbclient-dev python3-dev libpulse-dev libxi-dev libicu-dev nettle-dev libxkbfile-dev libcanberra-gtk-dev xserver-xorg-input-wacom libndp-dev libusbredirhost-dev libxml2-dev libxslt1-dev libnl-genl-3-dev libxkbcommon-dev xtrans-dev liboauth-dev libpng-dev libvirt-dev libhunspell-dev liblcms2-dev libproxy-dev valgrind libgles2-mesa-dev libegl1-mesa-dev libimobiledevice-dev libseccomp-dev libsm-dev libnss3-dev libstartup-notification0-dev libsystemd-dev libudev-dev libmtdev-dev libudisks2-dev nettle-dev libavahi-gobject-dev libz-mingw-w64-dev libp11-kit-dev libkyotocabinet-dev libpwquality-dev dbus-tests libvpx-dev libpixman-1-dev libegl1-mesa-dev libplymouth-dev libgphoto2-dev libarchive-dev libx11-dev libdbus-glib-1-dev libusb-1.0-0-dev libplist-dev libsource-highlight-dev libpoppler-glib-dev libxcb-dri2-0-dev libxkbcommon-x11-dev libanthy-dev uuid-dev libwavpack-dev libnfs-dev libcanberra-gtk3-dev libdotconf-dev libfuse-dev xkb-data libunwind-dev libelf-dev libxcb-res0-dev libdvdread-dev libhangul-dev libical-dev libpolkit-agent-1-dev check libexempi-dev libsqlite3-dev libxklavier-dev libx11-dev libxi-dev libflac-dev libxdamage-dev libxext-dev libfontconfig1-dev libpolkit-gobject-1-dev libnspr4-dev libxcomposite-dev libfreetype6-dev libxcursor-dev libnma-dev libxfixes-dev libssl-dev libfwup-dev libxft-dev libgbm-dev libmusicbrainz5-dev libnl-3-dev libmtp-dev libxrandr-dev libxrender-dev libtag1-dev libxt-dev libxtst-dev libgl1-mesa-dev libgnutls28-dev libsane-dev libdmapsharing-3.0-dev libtasn1-6-dev libsndfile1-dev libgraphviz-dev libxcb-randr0-dev libdrm-dev libbluray-dev libevdev-dev libcdio-paranoia-dev libnl-route-3-dev libwebkit2gtk-4.0-dev libcups2-dev argyll ragel bison ruby cargo xwayland ninja-build texinfo xmlto wget cmake desktop-file-utils intltool doxygen libtool valac flex yasm docbook-utils libgpgme-dev sassc gperf libkrb5-dev libjpeg-turbo8-dev libyaml-dev libwebp-dev libmpc-dev libhyphen-dev libtiff5-dev libgcrypt20-dev libpam0g-dev libespeak-dev libmagic-dev libreadline-dev libxinerama-dev libmpfr-dev libiw-dev ppp-dev libunistring-dev libcap-dev libdb5.3-dev libsasl2-dev libldap2-dev iptables python3-pip bash-completion

RUN useradd -m -u 1000 $USER

# Install dependancies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && \
    apt-get -y install $PACKAGES $SYSDEPS && \ 
    apt-file update
RUN cargo install mozjs
RUN pip3 install setuptools
ENV DEBIAN_FRONTEND ""

# Build certain dependancies from source
ENV DEPS_PATH /home/$USER/deps
RUN git clone https://github.com/rockdaboot/libpsl.git $DEPS_PATH/libpsl
RUN (cd $DEPS_PATH/libpsl && ./autogen.sh && ./configure && make install)

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
