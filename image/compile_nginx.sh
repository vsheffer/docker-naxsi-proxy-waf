NGINX_VERSION=1.8.0
apt-get install -y libcurl4-openssl-dev
cd /root
wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz 
tar xvf nginx-${NGINX_VERSION}.tar.gz 
rm -f nginx-${NGINX_VERSION}.tar.gz

# Naxsi
wget https://github.com/nbs-system/naxsi/archive/master.zip && unzip master.zip && rm master.zip

ls -l

# Compiling nginx with Naxsi
cd nginx-${NGINX_VERSION} 
pwd

echo "Hello"
ls -l

PASSENGER_NGINX_DIR=`passenger-config --root`/src/nginx_module/
echo "PASSENGER_NGINX_DIR = $PASSENGER_NGINX_DIR"

./configure \
         --conf-path=/etc/nginx/nginx.conf \
         --add-module=../naxsi-master/naxsi_src/ \
         --add-module=$PASSENGER_NGINX_DIR \
         --error-log-path=/var/log/nginx/error.log \
         --http-client-body-temp-path=/var/lib/nginx/body \
         --http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
         --http-log-path=/var/log/nginx/access.log \
         --http-proxy-temp-path=/var/lib/nginx/proxy \
         --lock-path=/var/lock/nginx.lock \
         --pid-path=/var/run/nginx.pid \
         --with-http_ssl_module \
         --with-http_realip_module \
         --without-mail_pop3_module \
         --without-mail_smtp_module \
         --without-mail_imap_module \
         --without-http_uwsgi_module \
         --without-http_scgi_module \
         --with-http_gzip_static_module \
         --with-ipv6 --prefix=/usr

make && make install

mkdir /var/lib/nginx
