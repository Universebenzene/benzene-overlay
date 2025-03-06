# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Faster zlib gzip compatible (de)compression by python bindings for ISA-L library"
HOMEPAGE="https://python-isal.readthedocs.io"
SRC_URI="https://github.com/pycompression/python-isal/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/isa-l"
DEPEND="${RDEPEND}"
BDEPEND=">=dev-python/versioningit-1.1.0[${PYTHON_USEDEP}]
	test? ( dev-python/pytest-timeout[${PYTHON_USEDEP}] )
"

S="${WORKDIR}/python-${P}"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-argparse dev-python/sphinx-rtd-theme

EPYTEST_IGNORE=(
	# FileNotFoundError: [Errno 2] No such file or directory: '-vv'
	benchmark_scripts/memory_leak_test.py
	# ModuleNotFoundError: No module named 'test'
	tests/test_gzip_compliance.py
	tests/test_zlib_compliance.py
)

python_prepare_all() {
	echo "Version: ${PV}" > "${S}"/PKG-INFO || die
	echo "__version__ = \"${PV}\"" > "${S}"/src/isal/_version.py || die
	use doc && { mkdir -p docs/_static || die ; }
#		sed -i "s/display_version/version_selector/" docs/conf.py || die ; }

	distutils-r1_python_prepare_all
}

python_configure_all() {
	export PYTHON_ISAL_LINK_DYNAMIC=1
}
