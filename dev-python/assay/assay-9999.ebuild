# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_SETUPTOOLS=no
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Attempt to write a Python testing framework I can actually stand"
HOMEPAGE="https://github.com/brandon-rhodes/assay"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/brandon-rhodes/${PN}.git"
	inherit git-r3
else
	inherit pypi
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="all-rights-reserved"
SLOT="0"
IUSE="test"
RESTRICT="bindist mirror test"	# Test phase runs with fails

BDEPEND="test? ( dev-python/pyflakes[${PYTHON_USEDEP}] )"

#python_prepare() {
#   DISTUTILS_IN_SOURCE_BUILD is not supported in PEP517 mode
#	sed -i -e "/python2/d" -e "s/python3/${EPYTHON}/" test.sh || die
#}

python_prepare_all() {
	use test && { sed -i -e "/python2/d" test.sh || die ; }
	distutils-r1_python_prepare_all
}

python_test() {
	./test.sh || die "Tests failed with ${EPYTHON}"
}
