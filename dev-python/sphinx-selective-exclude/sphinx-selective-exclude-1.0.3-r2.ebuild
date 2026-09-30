# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Sphinx selective rendition extensions"
HOMEPAGE="https://github.com/pfalcon/sphinx_selective_exclude"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PDEPEND="dev-python/sphinx[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}"/${PN}-description-file.patch )

distutils_enable_tests import-check

python_prepare_all() {
	sed -e "s:import sphinx:from sphinx.directives.other import Only:" \
		-e "/EagerOnly/s:sphinx.directives.other.::" -i ${PN//-/_}/eager_only.py || die
	distutils-r1_python_prepare_all
}
