FROM debian:jessie
RUN groupadd -r www-data && useradd -r --create-home -g www-data www-data
ENV HTTPD_PREFIX /usr/local/apache2
ENV PATH $HTTPD_PREFIX/bin:$PATH
RUN mkdir -p "$HTTPD_PREFIX" \
	&& chown www-data:www-data "$HTTPD_PREFIX"
WORKDIR $HTTPD_PREFIX
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		libapr1 \
		libaprutil1 \
		libaprutil1-ldap \
		libapr1-dev \
		libaprutil1-dev \
		libpcre++0 \
		libssl1.0.0 \
&& rm -r /var/lib/apt/lists/*
ENV HTTPD_VERSION 2.4.18
ENV HTTPD_SHA1 5101be34ac4a509b245adb70a56690a84fcc4e7f
ENV HTTPD_BZ2_URL http://archive.apache.org/dist/httpd/httpd-$HTTPD_VERSION.tar.bz2
RUN set -x \
	&& buildDeps=' \
		bzip2 \
		ca-certificates \
		gcc \
		libpcre++-dev \
		libssl-dev \
		make \
		wget \
	' \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends $buildDeps \
	&& rm -r /var/lib/apt/lists/* \
	\
	&& wget -O httpd.tar.bz2 "$HTTPD_BZ2_URL" \
        && echo "$HTTPD_SHA1 *httpd.tar.bz2" | sha1sum -c - \
        && wget -O httpd.tar.bz2.asc "$HTTPD_BZ2_URL.asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys A93D62ECC3C8EA12DB220EC934EA76E6791485A8 \
	&& gpg --batch --verify httpd.tar.bz2.asc httpd.tar.bz2 \
	&& rm -r "$GNUPGHOME" httpd.tar.bz2.asc \
	\
	&& mkdir -p src \
	&& tar -xvf httpd.tar.bz2 -C src --strip-components=1 \
	&& rm httpd.tar.bz2 \
	&& cd src \
	\
	&& ./configure \
		--prefix="$HTTPD_PREFIX" \
		--enable-mods-shared=reallyall \
	&& make -j"$(nproc)" \
	&& make install \
	\
	&& cd .. \
	&& rm -r src \
	\
	&& sed -ri \
		-e 's!^(\s*CustomLog)\s+\S+!\1 /proc/self/fd/1!g' \
		-e 's!^(\s*ErrorLog)\s+\S+!\1 /proc/self/fd/2!g' \
		"$HTTPD_PREFIX/conf/httpd.conf" \
	\
        && apt-get purge -y --auto-remove $buildDeps
