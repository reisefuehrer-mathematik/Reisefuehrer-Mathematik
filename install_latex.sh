wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar xvzf install-tl-unx.tar.gz
cd cd install-tl-20210727/
sudo perl install-tl
# enter i
rm -r install-tl-20210727/
rm install-tl-unx.tar.gz
echo "export PATH=\$PATH:/usr/local/texlive/2021/bin/x86_64-linux" >> ~/.bashrc