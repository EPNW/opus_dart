FROM ubuntu:bionic

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
RUN git clone --branch v1.3.1 https://github.com/xiph/opus.git
RUN cd opus \
	&& ./autogen.sh \
	&& ./configure --disable-extra-programs --disable-doc \
	&& make \
	&& make install

# Uncomment for Windows cross compile
RUN  DEBIAN_FRONTENTD="noninteractive" apt-get install -y mingw-w64 && cd opus && make clean && ./configure --host=x86_64-w64-mingw32 --disable-extra-programs --disable-doc --enable-shared && make && cp -r .libs ../opus_dlls

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
	&& pub get
	
# Set entrypoint
ENTRYPOINT ["dart","./example/info.dart"]

