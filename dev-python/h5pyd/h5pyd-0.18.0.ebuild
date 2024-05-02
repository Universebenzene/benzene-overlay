# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

H5PY_EXPV="3.10.0"
H5PY_EXP_URI="https://raw.githubusercontent.com/h5py/h5py/${H5PY_EXPV}/examples"
COMMIT="094f0b2b7e2a777f6dc1a6f60851cc856067d9a2"

inherit distutils-r1

DESCRIPTION="h5py distributed - Python client library for HDF Rest API"
HOMEPAGE="https://github.com/HDFGroup/h5pyd"
SRC_URI="https://github.com/HDFGroup/${PN}/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz
	doc? (
		${H5PY_EXP_URI}/bytesio.py -> h5py-${H5PY_EXPV}-e-bytesio.py
		${H5PY_EXP_URI}/swmr_inotify_example.py -> h5py-${H5PY_EXPV}-e-swmr_inotify_example.py
		${H5PY_EXP_URI}/swmr_multiprocess.py -> h5py-${H5PY_EXPV}-e-swmr_multiprocess.py
	)
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aws azure examples google hdf5"
RESTRICT="test"	# need h5serv for testing

RDEPEND=">=dev-python/numpy-1.17.3[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/pyjwt[${PYTHON_USEDEP}]
	dev-python/requests-unixsocket[${PYTHON_USEDEP}]
	aws? ( dev-python/s3fs[${PYTHON_USEDEP}] )
	azure? (
		dev-python/adal[${PYTHON_USEDEP}]
		dev-python/msrestazure[${PYTHON_USEDEP}]
	)
	google? (
		dev-python/google-api-python-client[${PYTHON_USEDEP}]
		dev-python/google-auth[${PYTHON_USEDEP}]
		dev-python/google-auth-oauthlib[${PYTHON_USEDEP}]
	)
	hdf5? ( dev-python/h5py[${PYTHON_USEDEP}] )
"
BDEPEND="dev-python/pkgconfig[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}-${COMMIT}"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/furo

python_prepare_all() {
	use doc && { for epy in "${DISTDIR}"/*-e-*; do { cp ${epy} "${S}"/examples/${epy##*-e-} || die ; } ; done ; \
		sed -i -e "/GH/s/GH/GH\%s/" -e "/PR/s/PR/PR\%s/" docs/conf.py || die ; }
	use test && eapply "${FILESDIR}"/${PN}-0.10.3-fix-h5type-test.patch

	distutils-r1_python_prepare_all
}

python_install_all() {
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/examples"
		docinto examples
		dodoc -r examples/.
	fi

	distutils-r1_python_install_all
}
