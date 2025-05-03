# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=standalone
PYPI_PN="${PN/-bin}"
MY_PN="${PYPI_PN/dm-}"
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1 pypi

DESCRIPTION="Tree is a library for working with nested data structures."
HOMEPAGE="https://tree.readthedocs.io"
SRC_URI="https://github.com/google-deepmind/tree/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz
	$(python_gen_useflags python3_12)? ( $(pypi_wheel_url ${PYPI_PN} ${PV} "cp312" "cp312-manylinux_2_17_x86_64.manylinux2014_x86_64") )
	$(python_gen_useflags python3_11)? ( $(pypi_wheel_url ${PYPI_PN} ${PV} "cp311" "cp311-manylinux_2_17_x86_64.manylinux2014_x86_64") )

"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="!dev-python/dm-tree"
BDEPEND="test? (
		>=dev-python/absl-py-0.6.1[${PYTHON_USEDEP}]
		>=dev-python/attrs-18.2.0[${PYTHON_USEDEP}]
		>=dev-python/numpy-1.15.4[${PYTHON_USEDEP}]
		>=dev-python/wrapt-1.11.2[${PYTHON_USEDEP}]
	)
"

S="${WORKDIR}/${MY_PN}-${PV}"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-rtd-theme

python_compile() {
	local _pyver=${EPYTHON/python}
	distutils_wheel_install "${BUILD_DIR}/install" \
		"${DISTDIR}"/$(pypi_wheel_name "${PYPI_PN}" "${PV}" "cp${_pyver/.}" "cp${_pyver/.}-manylinux_2_17_x86_64.manylinux2014_x86_64")
}

python_compile_all() {
	# cannot import name '_tree' from partially initialized module 'tree'
	use doc && [[ -d ${MY_PN} ]] && { mv {,_}${MY_PN} || die ; }
	sphinx_compile_all
	[[ -d _${MY_PN} ]] && { mv {_,}${MY_PN} || die ; }
}

python_test() {
	# cannot import name '_tree' from partially initialized module 'tree'
	[[ -d ${MY_PN} ]] && { mv {,_}${MY_PN} || die ; }
	epytest
	[[ -d _${MY_PN} ]] && { mv {_,}${MY_PN} || die ; }
}
