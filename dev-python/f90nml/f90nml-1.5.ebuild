# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Fortran 90 namelist parser"
HOMEPAGE="https://f90nml.readthedocs.io"
SRC_URI+=" test? (
		https://raw.githubusercontent.com/marshallward/f90nml/v${PV}/tests/types.json -> ${P}-t-types.json
		https://raw.githubusercontent.com/marshallward/f90nml/v${PV}/tests/vector.json -> ${P}-t-vector.json
		https://raw.githubusercontent.com/marshallward/f90nml/v${PV}/tests/cogroup.yaml -> ${P}-t-cogroup.yaml
		https://raw.githubusercontent.com/marshallward/f90nml/v${PV}/tests/types.yaml -> ${P}-t-types.yaml
	)
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="yaml"

RDEPEND="yaml? ( dev-python/pyyaml[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
distutils_enable_sphinx docs/source

python_prepare_all() {
	use test && { for ejs in "${DISTDIR}"/*-t-*; do { cp ${ejs} "${S}"/tests/${ejs##*-t-} || die ; } ; done ; \
		touch "${S}"/tests/empty_file || die ; }
	distutils-r1_python_prepare_all
}
