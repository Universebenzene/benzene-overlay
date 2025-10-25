# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Add source, edit, history, annotate links to GitHub or BitBucket"
HOMEPAGE="https://github.com/westurner/sphinxcontrib-srclinks"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# No usable test phases

RDEPEND=">=dev-python/sphinx-0.6[${PYTHON_USEDEP}]"

#distutils_enable_tests nose

python_install() {
	distutils-r1_python_install
	rm -r "${ED%/}"/$(python_get_sitedir)/*-nspkg.pth || die
}
