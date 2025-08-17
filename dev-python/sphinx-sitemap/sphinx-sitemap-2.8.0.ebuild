# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Sitemap generator for Sphinx"
HOMEPAGE="https://sphinx-sitemap.readthedocs.io"
SRC_URI="https://github.com/jdillard/sphinx-sitemap/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/sphinx-last-updated-by-git[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/gitpython[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
distutils_enable_sphinx docs/source dev-python/sphinx-contributors \
	dev-python/sphinxemoji \
	dev-python/sphinxext-opengraph \
	dev-python/accessible-pygments \
	dev-python/furo

python_prepare_all() {
	use doc && { sed -i -e "/check_output/d" -e "/decode/c current_tag = 'v${PV}'" docs/source/conf.py || die ; }

	distutils-r1_python_prepare_all
}
