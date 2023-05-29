# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="Fortran 90 namelist parser"
HOMEPAGE="https://f90nml.readthedocs.io"
SRC_URI+=" test? (
		https://raw.githubusercontent.com/marshallward/f90nml/v${PV}/tests/types.json -> ${P}--types.json
		https://raw.githubusercontent.com/marshallward/f90nml/v${PV}/tests/vector.json -> ${P}--vector.json
		https://raw.githubusercontent.com/marshallward/f90nml/v${PV}/tests/cogroup.yaml -> ${P}--cogroup.yaml
		https://raw.githubusercontent.com/marshallward/f90nml/v${PV}/tests/types.yaml -> ${P}--types.yaml
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
	use test && { for ejs in "${DISTDIR}"/*--*; do { cp ${ejs} "${S}"/tests/${ejs##*--} || die ; } ; done ; \
		touch "${S}"/tests/empty_file || die ; }
	distutils-r1_python_prepare_all
}
