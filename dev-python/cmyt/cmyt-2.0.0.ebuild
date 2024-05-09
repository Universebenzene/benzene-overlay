# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="A collection of Matplotlib colormaps from the yt project"
HOMEPAGE="https://github.com/yt-project/cmyt"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/matplotlib-3.5.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.19.3[${PYTHON_USEDEP}]
"
BDEPEND="test? (
		>=dev-python/pytest-mpl-0.13[${PYTHON_USEDEP}]
		>=dev-python/colorspacious-1.1.2[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_install() {
	rm -r "${BUILD_DIR}"/install/$(python_get_sitedir)/tests || die
	distutils-r1_python_install
}
