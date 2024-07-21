FROM ubuntu:noble

# Install dependencies
RUN apt-get update \
	&& DEBIAN_FRONTENTD="noninteractive" apt-get install -y --no-install-recommends \
	apt-transport-https \
	wget \
	gnupg \
	ca-certificates \
	git \
	autoconf \
	automake \
	libtool \
	gcc \
	make

# Build opus
WORKDIR /app
RUN git clone --branch v1.5.2 https://github.com/xiph/opus.git

RUN cd opus \
	&& ./autogen.sh \
	&& ./configure --disable-extra-programs --disable-doc \
	&& make \
	&& make install \
	&& cd ..

# Uncomment for Windows cross compile
RUN  DEBIAN_FRONTENTD="noninteractive" apt-get install -y mingw-w64 \
	&& cd opus \
	&& make clean \
	&& ./configure --host=x86_64-w64-mingw32 --disable-extra-programs --disable-doc --enable-shared \
	&& make \
	&& mkdir ../opus_dlls/ && cp ./.libs/libopus-0.dll ../opus_dlls/libopus.x64.dll \
	&& make clean \
	&& ./configure --host=i686-w64-mingw32 --disable-extra-programs --disable-doc --enable-shared \
	&& make \
	&& cp ./.libs/libopus-0.dll ../opus_dlls/libopus.x86.dll \
	&& cd ..

# Install dart
RUN sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' \
	&& sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list' \
	&& apt-get update \
	&& DEBIAN_FRONTENTD="noninteractive" apt-get install -y --no-install-recommends \
	dart
ENV PATH="$PATH:/usr/lib/dart/bin"

# Copy app
COPY . .
RUN rm -rf .packages \
	&& dart pub get
	
# Set entrypoint
ENTRYPOINT ["dart","./example/bin/info.dart"]

