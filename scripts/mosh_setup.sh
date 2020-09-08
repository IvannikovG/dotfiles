sudo apt install debhelper  autotools-dev protobuf-compiler libprotobuf-dev dh-autoreconf pkg-config libutempter-dev zlib1g-dev libncurses5-dev libssl-dev bash-completion locales
git clone https://github.com/mobile-shell/mosh
cd mosh
./autogen.sh
./configure
make
sudo make install
cd ..
rm -rf mosh
