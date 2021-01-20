# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="Reproject astronomical images with Python"
HOMEPAGE="https://reproject.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
	doc? ( http://data.astropy.org/galactic_center/gc_2mass_k.fits
		http://data.astropy.org/galactic_center/gc_msx_e.fits
		http://data.astropy.org/allsky/ligo_simulated.fits.gz
		https://irsa.ipac.caltech.edu:443/cgi-bin/2MASS/IM/nph-im?ds=asky&atdir=/ti05&dh=990502s&scan=135&name=ki1350080.fits -> ki1350080.fits
		https://irsa.ipac.caltech.edu:443/cgi-bin/2MASS/IM/nph-im?ds=asky&atdir=/ti05&dh=990502s&scan=135&name=ki1350092.fits -> ki1350092.fits
		https://irsa.ipac.caltech.edu:443/cgi-bin/2MASS/IM/nph-im?ds=asky&atdir=/ti05&dh=990502s&scan=142&name=ki1420186.fits -> ki1420186.fits
		https://irsa.ipac.caltech.edu:443/cgi-bin/2MASS/IM/nph-im?ds=asky&atdir=/ti05&dh=990502s&scan=142&name=ki1420198.fits -> ki1420198.fits
		https://irsa.ipac.caltech.edu:443/cgi-bin/2MASS/IM/nph-im?ds=asky&atdir=/ti05&dh=990502s&scan=143&name=ki1430080.fits -> ki1430080.fits
		https://irsa.ipac.caltech.edu:443/cgi-bin/2MASS/IM/nph-im?ds=asky&atdir=/ti05&dh=990502s&scan=143&name=ki1430092.fits -> ki1430092.fits
		https://irsa.ipac.caltech.edu:443/cgi-bin/2MASS/IM/nph-im?ds=asky&atdir=/ti05&dh=990502s&scan=144&name=ki1440186.fits -> ki1440186.fits
		https://irsa.ipac.caltech.edu:443/cgi-bin/2MASS/IM/nph-im?ds=asky&atdir=/ti05&dh=990502s&scan=144&name=ki1440198.fits -> ki1440198.fits
	)
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"
RESTRICT="!test? ( test )"
#RESTRICT="network-sandbox"	# To use intersphinx linking

RDEPEND=">=dev-python/astropy-3.2[${PYTHON_USEDEP}]
	>=dev-python/astropy-healpix-0.2[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.1[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.13[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/extension-helpers[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		dev-python/pyvo[${PYTHON_USEDEP}]
	)
	test? (
		${RDEPEND}
		dev-python/pytest-astropy[${PYTHON_USEDEP}]
		sci-libs/shapely[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	"${FILESDIR}"/0001-${P}-fix-mosaicking-doc.patch
	"${FILESDIR}"/0002-${P}-doc-use-local-fits.patch
)

#distutils_enable_sphinx docs dev-python/sphinx-astropy dev-python/pyvo

python_prepare_all() {
	use doc && { cp "${DISTDIR}"/*.fits* "${S}"/docs || die ; }

#	Disable intersphinx
#	sed -i '/^SPHINXOPTS/s/$/& -D disable_intersphinx=1/' "${S}"/docs/Makefile || die
	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		pushd docs || die
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/lib \
			emake html
		popd || die
		HTML_DOCS=( docs/_build/html/. )
	fi
}

python_test() {
	pytest -vv "${BUILD_DIR}/lib" || die "Tests fail with ${EPYTHON}"
}
