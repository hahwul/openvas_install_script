echo "OpenVAS Scanner Install Script on debian.."
echo "Code by Hahwul / www.hahwul.com
echo "\n"
echo "Install Path"
echo "Ex) path : /opt/openvas/"
echo "Default:  $path"
path="~"
echo -n "> path : ";read path

apt-get update
apt-get install build-essential cmake bison flex libpcap-dev \
pkg-config libgnutls-dev libglib2.0-dev libgpgme11-dev uuid-dev \
sqlfairy xmltoman doxygen libssh-dev libksba-dev libldap2-dev \
libsqlite3-dev libmicrohttpd-dev libxml2-dev libxslt1-dev \
xsltproc clang rsync rpm nsis alien sqlite3 gnupg haveged
cd $path &&
wget http://wald.intevation.org/frs/download.php/1638/openvas-libraries-7.0.1.tar.gz &&
tar xvf openvas-libraries-7.0.1.tar.gz &&
cd openvas-libraries-7.0.1 &&
cmake . &&
make &&
make doc &&
make install
cd $path &&
wget http://wald.intevation.org/frs/download.php/1640/openvas-scanner-4.0.1.tar.gz &&
tar xvf openvas-scanner-4.0.1.tar.gz &&
cd openvas-scanner-4.0.1 &&
cmake . &&
make &&
make doc &&
make install
cd $path &&
wget http://wald.intevation.org/frs/download.php/1653/openvas-manager-5.0.1.tar.gz &&
tar xvf openvas-manager-5.0.1.tar.gz &&
cd openvas-manager-5.0.1 &&
cmake . &&
make &&
make doc &&
make install
cd $path &&
wget http://wald.intevation.org/frs/download.php/1639/greenbone-security-assistant-5.0.0.tar.gz &&
tar xvf greenbone-security-assistant-5.0.0.tar.gz &&
cd greenbone-security-assistant-5.0.0 &&
cmake . &&
make &&
make doc &&
make install
cd $path &&
wget http://wald.intevation.org/frs/download.php/1633/openvas-cli-1.3.0.tar.gz &&
tar xvf openvas-cli-1.3.0.tar.gz &&
cd openvas-cli-1.3.0 &&
cmake . &&
make &&
make doc &&
make install
ldconfig
cd $path &&
wget --no-check-certificate https://svn.wald.intevation.org/svn/openvas/trunk/tools/openvas-check-setup &&
chmod +x openvas-check-setup &&
./openvas-check-setup --v7
openvas-mkcert
openvas-nvt-sync
openvas-scapdata-sync
openvas-certdata-sync
openvas-mkcert-client -n -i
wget http://www.openvas.org/OpenVAS_TI.asc
gpg --homedir=/usr/local/etc/openvas/gnupg --gen-key
gpg --homedir=/usr/local/etc/openvas/gnupg --import OpenVAS_TI.asc
gpg --homedir=/usr/local/etc/openvas/gnupg --lsign-key 48DB4530
echo "nasl_no_signature_check = no" >> /usr/local/etc/openvas/openvassd.conf
wget http://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xml &&
openvas-portnames-update service-names-port-numbers.xml &&
rm service-names-port-numbers.xml
openvasmd --create-user=adminuser --role=Admin
echo "--------------Finish--------------"
echo "Excute OpenVAS." 
echo "# openvassd"
echo "# openvasmd --rebuild --progress"
echo "End Script. bye." 

