# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Fast and direct raster I/O for use with Numpy and SciPy"
HOMEPAGE="https://rasterio.readthedocs.io"
SRC_URI="https://github.com/rasterio/rasterio/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples ipython plot s3"
PROPERTIES="test_network"
RESTRICT="test"

DEPEND=">=sci-libs/gdal-2.1.0:=[aux-xml(+),jpeg,png,threads(+)]
	>=dev-python/numpy-1.21[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}
	dev-python/affine[${PYTHON_USEDEP}]
	dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	>=dev-python/click-4.0[${PYTHON_USEDEP}]
	dev-python/click-plugins[${PYTHON_USEDEP}]
	>=dev-python/cligj-0.5[${PYTHON_USEDEP}]
	>=dev-python/snuggs-1.4.1[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	ipython? ( >=dev-python/ipython-2.0[${PYTHON_USEDEP}] )
	plot? ( dev-python/matplotlib[${PYTHON_USEDEP}] )
	s3? ( >=dev-python/boto3-1.2.4[${PYTHON_USEDEP}] )
"
BDEPEND=">=dev-python/cython-0.29.29[${PYTHON_USEDEP}]
	test? (
		>=dev-python/boto3-1.2.4[${PYTHON_USEDEP}]
		dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/shapely[${PYTHON_USEDEP}]
		sci-libs/gdal:=[aux-xml(+),jpeg,netcdf,png,threads(+)]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-rtd-theme

python_prepare_all() {
	use doc && { eapply "${FILESDIR}"/${P}-add-import-to-confpy.patch ; \
#		sed -i "/language\ = /s/None/'en'/" docs/conf.py || die ; \
	}

	distutils-r1_python_prepare_all
}

python_compile_all() {
	# No module named 'rasterio._version'
	use doc && [[ -d ${PN} ]] && { mv ${PN} _${PN} || die ; }
	sphinx_compile_all
	[[ -d _${PN} ]] && { mv _${PN} ${PN} || die ; }
}

python_install_all() {
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/examples"
		docinto examples
		dodoc -r examples/.
	fi

	distutils-r1_python_install_all
}

python_test() {
	# No module named 'rasterio._version'
	[[ -d ${PN} ]] && { mv ${PN} _${PN} || die ; }
	epytest
	[[ -d _${PN} ]] && { mv _${PN} ${PN} || die ; }
}
