# Maintainer: dev whale <youremail@example.com>
pkgname=aur-auto
pkgver=1.0.0
pkgrel=1
pkgdesc="🐳 Whale Lab AUR auto installer with fuzzy search and package details"
arch=('any')
url="https://github.com/Sanjaya-Danushka/whalekit"
license=('MIT')
depends=('bash' 'git' 'curl' 'jq' 'fzf')
source=("aur-auto.sh")
sha256sums=('SKIP')  # we'll update later

package() {
  install -Dm755 "aur-auto.sh" "$pkgdir/usr/bin/aur-auto"
}
