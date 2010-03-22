To install flagship docs
1. Go to where you want to install Flagship Docs
rowez@Midgard:~$ cd /var/rails/rowez/
2. Run git clone git://github.com/wtg/flagship_docs.git
rowez@Midgard:/var/rails/rowez$ git clone git://github.com/wtg/flagship_docs.git
3. Run git submodule init and git submodule update 
rowez@Midgard:/var/rails/rowez$ cd flagship_docs/
rowez@Midgard:/var/rails/rowez/flagship_docs$ git submodule init
rowez@Midgard:/var/rails/rowez/flagship_docs$ git submodule update
4. create a symbolic link if rails app not in your web directory
rowez@Midgard:/var/rails/rowez/flagship_docs$ cd /var/www/rowez/
rowez@Midgard:/var/www/rowez$ ln -s /var/rails/rowez/flagship_docs/public/ ./flagship_docs
rowez@Midgard:/var/www/rowez$ cd /var/rails/rowez/flagship_docs
5. create an .htaccess file in your /public directory (passenger only)
rowez@Midgard:/var/rails/rowez/flagship_docs$ nano ./public/.htaccess
PassengerEnabled on
RailsEnv development
RailsBaseURI /rowez/flagship_docs
6. Copy in  ldap_initializer.rb
rowez@Midgard:/var/rails/rowez/flagship_docs$ cp ../flagship_docs/config/initializers/ldap_initializer.rb ./config/initializers/
7. create a database.yml in your /config directory
rowez@Midgard:/var/rails/rowez/flagship_docs$ nano ./config/database.yml
# MySQL.  Versions 4.1 and 5.0 are recommended.
#
# Install the MySQL driver:
#   gem install mysql
# On Mac OS X:
#   sudo gem install mysql -- --with-mysql-dir=/usr/local/mysql
# On Mac OS X Leopard:
#   sudo env ARCHFLAGS="-arch i386" gem install mysql -- --with-mysql-config=/usr/local/mysql/bin/mysql_config
#       This sets the ARCHFLAGS environment variable to your native architecture
# On Windows:
#   gem install mysql
#       Choose the win32 build.
#       Install MySQL and put its /bin directory on your path.
#
# And be sure to use new-style password hashing:
#   http://dev.mysql.com/doc/refman/5.0/en/old-client.html
development:
  adapter: mysql
  encoding: utf8
  reconnect: false
  database: flagship
  pool: 5
  username: 
  password: 
  socket: /var/run/mysqld/mysqld.sock

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  adapter: mysql
  encoding: utf8
  reconnect: false
  database: flagship
  pool: 5
  username: 
  password: 
  socket: /var/run/mysqld/mysqld.sock

production:
  adapter: mysql
  encoding: utf8
  reconnect: false
  database: flagship
  pool: 5
  username: 
  password: 
  socket: /var/run/mysqld/mysqld.sock
8. restart app
