#Install dependencies
echo $HOME

cat /etc/passwd
pwd
echo $HOME
git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build
echo "export PATH=$HOME/.rbenv/bin:$PATH" >> $HOME/.bashrc
export PATH=$HOME/.rbenv/bin:$PATH
cat $HOME/.bashrc
. $HOME/.bashrc
echo "path = $PATH"
rbenv init - >> $HOME/.bashrc

. $HOME/.bashrc

git clone https://github.com/sstephenson/rbenv-gem-rehash.git $HOME/.rbenv/plugins/rbenv-gem-rehash
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
rbenv install 2.2.2
rbenv global 2.2.2
echo "gem: --no-ri --no-rdoc" > $HOME/.gemrc
ruby -v
gem install bundler
gem install rails -v 4.2.1
gem install passenger
passenger-config --root

# Nginx
wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz 
tar xvf nginx-${NGINX_VERSION}.tar.gz 
rm -f nginx-${NGINX_VERSION}.tar.gz
# Naxsi
wget https://github.com/nbs-system/naxsi/archive/master.zip && unzip master.zip && rm master.zip

# Compiling nginx with Naxsi
cd nginx-${NGINX_VERSION} 
configure \
         --conf-path=/etc/nginx/nginx.conf \
         --add-module=../naxsi-master/naxsi_src/ \
         --error-log-path=/var/log/nginx/error.log \
         --http-client-body-temp-path=/var/lib/nginx/body \
         --http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
         --http-log-path=/var/log/nginx/access.log \
         --http-proxy-temp-path=/var/lib/nginx/proxy \
         --lock-path=/var/lock/nginx.lock \
         --pid-path=/var/run/nginx.pid \
         --with-http_ssl_module \
         --without-mail_pop3_module \
         --without-mail_smtp_module \
         --without-mail_imap_module \
         --without-http_uwsgi_module \
         --without-http_scgi_module \
         --with-http_gzip_static_module \
         --with-ipv6 --prefix=/usr

cd nginx-${NGINX_VERSION} && make && make install
