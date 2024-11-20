# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="${PV%_p*}"
MY_P="${PN}-${MY_PV}"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{{10..13},13t} pypy3 )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1 pypi

EGIT_COMMIT="8def1b4dcf2ef6b4a34bffdfacea0018a78b06b6"
DESCRIPTION="Unittest extension with automatic test suite discovery and easy test authoring"
HOMEPAGE="
	https://pypi.org/project/nose/
	https://nose.readthedocs.io/en/latest/
	https://github.com/nose-devs/nose
"
SRC_URI="$(pypi_sdist_url "${PN}" ${MY_PV})"
S="${WORKDIR}/${MY_P}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x64-solaris"
IUSE="examples test"
PROPERTIES="test_network"
RESTRICT="test"

BDEPEND="
	test? (
		$(python_gen_cond_dep '
			dev-python/coverage[${PYTHON_USEDEP}]
		' python3_{8..10} pypy3)
		$(python_gen_cond_dep '
			dev-python/twisted[${PYTHON_USEDEP}]
		' python3_{8..10})
	)
"

PATCHES=(
	# https://gitlab.archlinux.org/archlinux/packaging/packages/python-nose/-/blob/main/PKGBUILD
	"${FILESDIR}"/${P}-coverage4.patch
	"${FILESDIR}"/${P}-py35.patch
	"${FILESDIR}"/${P}-unicode.patch
	"${FILESDIR}"/${P}-readunicode.patch
	"${FILESDIR}"/${P}-py36.patch
	"${FILESDIR}"/${P}-py38.patch
	"${FILESDIR}"/${P}-no-use_2to3.patch
	"${FILESDIR}"/${P}-py311.patch
	"${FILESDIR}"/${P}-py311-doctest.patch
	"${FILESDIR}"/${P}-py312.patch
	"${FILESDIR}"/${P}-2to3.patch
	"${FILESDIR}"/${P}-setuptools74.patch
)

src_prepare() {
	# failing to find configuration file
	sed -e 's/test_cover_options_config_file/_&/' \
		-i unit_tests/test_cover_plugin.py || die

	distutils-r1_src_prepare
}

python_test() {
	esetup.py build_tests
	"${EPYTHON}" selftest.py ||
		die "Tests fail with ${EPYTHON}"
}

src_install() {
	distutils-r1_src_install
	use examples && dodoc -r examples
	mv "${ED%/}"/usr/{,share/}man || die
}
