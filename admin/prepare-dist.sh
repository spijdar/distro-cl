# just used by distro maintainers to build a release

rm -Rf /tmp/distro-cl
git clone --recursive https://github.com/hughperkins/distro-cl /tmp/distro-cl
rm -Rf /tmp/distro-cl/.git
find /tmp/distro-cl -name '.git' | xargs -L1 rm 
cd /tmp
tar -cjf torch-cl-v$1.tar.bz2 distro-cl

