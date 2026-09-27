# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=meson-python
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Data storage buffer compression and transformation codecs"
HOMEPAGE="http://numcodecs.readthedocs.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="crc32c examples google_crc32c msgpack zfpy"

DEPEND="app-arch/lz4:=
	app-arch/zstd:=
	dev-libs/c-blosc:=[lz4,snappy,zlib,zstd]
	>=dev-python/numpy-2.0[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	crc32c? ( >=dev-python/crc32c-2.7[${PYTHON_USEDEP}] )
	google_crc32c? ( >=dev-python/google-crc32c-1.5[${PYTHON_USEDEP}] )
	msgpack? ( dev-python/msgpack[${PYTHON_USEDEP}] )
	zfpy? ( dev-libs/zfp[python] )
"
BDEPEND=">=dev-python/setuptools-scm-6.2[${PYTHON_USEDEP}]
	>=dev-python/cython-3.1[${PYTHON_USEDEP}]
	doc? ( dev-libs/zfp[python] )
	test? (
		dev-libs/zfp[python]
		dev-python/importlib-metadata[${PYTHON_USEDEP}]
		dev-python/msgpack[${PYTHON_USEDEP}]
		dev-python/pyzstd[${PYTHON_USEDEP}]
	)
"
PDEPEND="test? ( >=dev-python/zarr-3[${PYTHON_USEDEP}] )"

PATCHES=(
	"${FILESDIR}/0001-${P}-Allow-building-against-a-system-Zlib.patch"
	"${FILESDIR}/0002-${P}-Re-add-Snappy-to-tests.patch"
)

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-issues dev-python/numpydoc \
	dev-python/pydata-sphinx-theme \
	dev-python/myst-parser \
	">=dev-python/zarr-3"

python_prepare_all() {
	use test && { sed -i "s/--cov=numcodecs --cov-report xml //" pyproject.toml || die ; }
	sed -i "/None = None/a import zfpy as _zfpy" src/${PN}/zfpy.py || die
	rm -r c-blosc || die

	distutils-r1_python_prepare_all
}

python_configure_all() {
	DISTUTILS_ARGS=(
		-Dsystem_blosc=enabled
		-Dsystem_zstd=enabled
		-Dsystem_lz4=enabled
		-Dsystem_zlib=enabled
	)
}

python_install_all() {
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/notebooks"
		docinto notebooks
		dodoc -r notebooks/.
	fi

	distutils-r1_python_install_all
}
