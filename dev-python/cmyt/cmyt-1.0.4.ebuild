# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="A collection of Matplotlib colormaps from the yt project"
HOMEPAGE="https://github.com/yt-project/cmyt"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/colorspacious-1.1.2[${PYTHON_USEDEP}]
	>=dev-python/cryptography-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/more-itertools-8.4[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-3.10.0.2[${PYTHON_USEDEP}]
"
BDEPEND="test? ( dev-python/pytest-mpl[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	cp {"${FILESDIR}"/${P}-,"${S}"/}LICENSE || die
	distutils-r1_python_prepare_all
}

python_install() {
	rm -r "${BUILD_DIR}"/install/$(python_get_sitedir)/tests || die
	distutils-r1_python_install
}
