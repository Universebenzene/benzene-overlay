# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )
PYTHON_REQ_USE="threads(+)"

MY_PN="${PN%x}"
MY_PV="${PV}x"
MY_P="${MY_PN}-${MY_PV}"

inherit distutils-r1

DESCRIPTION="A self-contained cryptographic library for Python"
HOMEPAGE="
	https://www.pycryptodome.org/
	https://github.com/Legrandin/pycryptodome/
	https://pypi.org/project/pycryptodome/
"
SRC_URI="
	https://github.com/Legrandin/pycryptodome/archive/v${MY_PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="BSD-2 Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-libs/gmp:=
	>=dev-libs/libtomcrypt-1.18.2-r1:=
"
BDEPEND="
	$(python_gen_cond_dep 'dev-python/cffi[${PYTHON_USEDEP}]' 'python*')
"
RDEPEND="
	${DEPEND}
	${BDEPEND}
"

S="${WORKDIR}/${MY_P}"

PATCHES=( "${FILESDIR}/pycryptodome-3.10.1-system-libtomcrypt.patch")

distutils_enable_sphinx Doc dev-python/sphinx-autodoc-typehints dev-python/sphinxcontrib-jquery

python_prepare_all() {
	# make sure we're unbundling it correctly
	rm -r src/libtom || die

	distutils-r1_python_prepare_all
}

python_test() {
	local -x PYTHONPATH=${S}/test_vectors:${PYTHONPATH}
	"${EPYTHON}" - <<-EOF || die
		import sys
		from Cryptodome import SelfTest
		SelfTest.run(verbosity=2, stream=sys.stdout)
	EOF

	# TODO: run cmake tests from src/test?
}
