FROM ubuntu:jammy
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install --no-install-recommends -y curl wget apt-transport-https gnupg ca-certificates gnupg1 gnupg2 curl dirmngr software-properties-common apt-file  && \
    add-apt-repository ppa:oibaf/graphics-drivers && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv 76F1A20FF987672F && \
    rm -rf /var/lib/apt/lists/*

RUN curl -o - https://dl.winehq.org/wine-builds/Release.key | apt-key add -
RUN wget -qO - https://packages.lunarg.com/lunarg-signing-key-pub.asc | apt-key add - &&\
    echo "deb https://dl.winehq.org/wine-builds/ubuntu/ jammy main" > /etc/apt/sources.list.d/winehq.list &&\ 
    wget -qO /etc/apt/sources.list.d/lunarg-vulkan-1.3.211-focal.list https://packages.lunarg.com/vulkan/1.3.211/lunarg-vulkan-1.3.211-focal.list
RUN apt-get update && \
    apt-get dist-upgrade -y &&\
    apt-get install --no-install-recommends -y gcc-11 vulkan-sdk winehq-staging winehq-staging meson mingw-w64 mingw-w64-i686-dev mingw-w64-x86-64-dev unzip build-essential git unzip wget libllvm13 llvm-13 llvm-13-dev llvm-13-runtime && \
    rm -rf /var/lib/apt/lists/*

RUN update-alternatives --set x86_64-w64-mingw32-gcc /usr/bin/x86_64-w64-mingw32-gcc-posix && \
    update-alternatives --set x86_64-w64-mingw32-g++ /usr/bin/x86_64-w64-mingw32-g++-posix && \
    update-alternatives --set i686-w64-mingw32-gcc /usr/bin/i686-w64-mingw32-gcc-posix && \
    update-alternatives --set i686-w64-mingw32-g++ /usr/bin/i686-w64-mingw32-g++-posix

WORKDIR /root/build
RUN mkdir -p /root/out/dxvk-master
ADD build.sh /root/build.sh
CMD ["/root/build.sh"]
