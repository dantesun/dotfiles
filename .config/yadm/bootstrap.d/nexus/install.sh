#!/bin/bash
set -e
cd "$(dirname "$0")"
pkgname=nexus-oss

_version=3.49.0
_patch=02
_full_name=nexus-$_version-$_patch
[ -f $pkgname.tar.gz ] || {
  curl -L -o $pkgname.tar.gz "https://download.sonatype.com/nexus/3/$_full_name-unix.tar.gz"
}

sudo install -Dm644 $pkgname.sysusers "/usr/lib/sysusers.d/$pkgname.conf"
sudo systemd-sysusers $pkgname.conf

_home_dir=/var/lib/$pkgname
sudo [ -d _home_dir ] || {
  sudo install -dm750 $pkgname "$_home_dir"
  sudo tar xf $pkgname.tar.gz -C $_home_dir
  sudo chown -R nexus:nexus $_home_dir
}

_executable=/usr/bin/$pkgname
sudo [ -x $_executable ] || {
(
cat <<__EOF
#!/bin/bash
exec $_home_dir/$_full_name/bin/nexus "\$@"
__EOF
) | sudo tee $_executable > /dev/null

sudo chmod 750 $_executable
}
sudo install -Dm644 $pkgname.service "/usr/lib/systemd/system/$pkgname.service"
sudo systemctl daemon-reload
sudo systemctl enable $pkgname.service
