docker run -p 3306:3306 \
  --name global-mysql \
  -v $PWD/conf:/etc/mysql/conf.d \
  -v $PWD/logs:/logs \
  -v $PWD/data:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=root \
  -d mysql:5.7 \
  --skip-name-resolve

# https://www.nuomiphp.com/t/61a973de9aee9d5ac04dc9d6.html
# https://dominoweb.draco.res.ibm.com/reports/rc25482.pdf

wget https://boostorg.jfrog.io/artifactory/main/release/1.77.0/source/boost_1_77_0.tar.bz2
tar -vxf boost_1_77_0.tar.bz2
cd boost_1_77_0
./bootstrap.sh --prefix=/usr/
./b2
sudo ./b2 install

export cc=clang-15
export cxx=clang++-15
sudo apt-get install  -y libzstd-dev \
                        libeditline-dev \
                        libldap2-dev \
                        libsasl2-dev libldap2-dev \
                        libedit \
                        libedit-dev \
                        liblz4-dev \
                        libprotobuf-dev \
                        libprotoc-dev \
                        libcurl4-openssl-dev \
                        libncurses-dev \
                        bisonc++ \
                        libsasl2-dev \
                        libldap-common \
                        libevent-dev \
                        libudev-dev
wget https://mirrors.huaweicloud.com/mysql/Downloads/MySQL-8.0/mysql-boost-8.0.29.tar.gz
tar -vxf mysql-boost-8.0.29.tar.gz
cd mysql-8.0.29
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
  -DMYSQL_DATADIR=/data/mysql \
  -DMYSQL_UNIX_ADDR=/data/mysql/mysql.sock \
  -DWITH_INNOBASE_STORAGE_ENGINE=1 \
  -DWITH_EXTRA_CHARSETS=all \
  -DDEFAULT_CHARSET=utf8mb4 \
  -DDEFAULT_COLLATION=utf8mb4_unicode_ci \
  -DWITH_BOOST=boost/boost_1_77_0/

make

make install
