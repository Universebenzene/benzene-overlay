# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )

inherit distutils-r1 xdg-utils

DESCRIPTION="Helpers for Astropy and Affiliated packages"
HOMEPAGE="https://astropy-helpers.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

python_prepare() {
	eapply "${FILESDIR}/${P}-${EPYTHON}-system-path.patch"

	sed -e '/import ah_bootstrap/d' \
		-i setup.py || die "Removing ah_bootstrap failed"
	xdg_environment_reset
}
