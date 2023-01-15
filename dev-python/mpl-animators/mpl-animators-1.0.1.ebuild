# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1 optfeature

MY_PN="${PN/-/_}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="An interative animation framework for matplotlib"
HOMEPAGE="https://sunpy.org"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"
KEYWORDS="~amd64 ~x86"

LICENSE="BSD"
SLOT="0"

RDEPEND=">=dev-python/matplotlib-3.2.0[${PYTHON_USEDEP}]"
BDEPEND="${RDEPEND}
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	doc? ( media-gfx/graphviz )
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/astropy[${PYTHON_USEDEP}]
	)
"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-automodapi dev-python/sunpy-sphinx-theme dev-python/astropy

pkg_postinst() {
	optfeature "WCS support" ">=dev-python/astropy-4.2.0"
}
