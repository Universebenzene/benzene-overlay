# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

H5PY_EXPV="3.14.0"
H5PY_EXP_URI="https://raw.githubusercontent.com/h5py/h5py/${H5PY_EXPV}/examples"

inherit distutils-r1

DESCRIPTION="h5py distributed - Python client library for HDF Rest API"
HOMEPAGE="https://github.com/HDFGroup/h5pyd"
SRC_URI="https://github.com/HDFGroup/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz
	doc? (
		${H5PY_EXP_URI}/bytesio.py -> h5py-${H5PY_EXPV}-e-bytesio.py
		${H5PY_EXP_URI}/swmr_inotify_example.py -> h5py-${H5PY_EXPV}-e-swmr_inotify_example.py
	)
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aws azure examples google hdf5"
RESTRICT="test"	# need h5serv for testing

RDEPEND=">=dev-python/numpy-2.0.0_rc1[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
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

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/furo dev-python/accessible-pygments

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

python_test() {
	mkdir -p "${T}"/.test || die
	H5PYD_TEST_FOLDER="${T}/.test" epytest
}
