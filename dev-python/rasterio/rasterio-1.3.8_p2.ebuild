# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="$(ver_cut 1-3).post$(ver_cut 5)"
MY_P="${PN}-${MY_PV}"

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Fast and direct raster I/O for use with Numpy and SciPy"
HOMEPAGE="https://rasterio.readthedocs.io"
SRC_URI="https://github.com/rasterio/rasterio/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples ipython plot s3"
PROPERTIES="test_network"
RESTRICT="test"

DEPEND=">=sci-libs/gdal-2.1.0:=[aux-xml(+),jpeg,png,threads(+)]
	dev-python/numpy[${PYTHON_USEDEP}]
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
BDEPEND=">=dev-python/cython-3.0.2[${PYTHON_USEDEP}]
	test? (
		>=dev-python/boto3-1.2.4[${PYTHON_USEDEP}]
		dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/shapely[${PYTHON_USEDEP}]
		sci-libs/gdal:=[aux-xml(+),hdf5,jpeg,netcdf,png,threads(+)]
		sci-libs/hdf5
	)
"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-rtd-theme

python_prepare_all() {
	use doc && { eapply "${FILESDIR}"/${PN}-1.3.6-add-import-to-confpy.patch ; \
#		sed -i "/language\ = /s/None/'en'/" docs/conf.py || die ; \
	}

	distutils-r1_python_prepare_all
}

python_compile_all() {
	# No module named 'rasterio._version'
	use doc && [[ -d ${PN} ]] && { mv {,_}${PN} || die ; }
	sphinx_compile_all
	[[ -d _${PN} ]] && { mv {_,}${PN} || die ; }
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
	[[ -d ${PN} ]] && { mv {,_}${PN} || die ; }
	epytest
	[[ -d _${PN} ]] && { mv {_,}${PN} || die ; }
}
