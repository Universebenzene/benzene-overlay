# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYPI_PN="ATpy"
PYTHON_COMPAT=( python3_{10..12} )
PYTHON_REQ_USE="sqlite"

inherit distutils-r1 pypi

DESCRIPTION="Astronomical tables support for Python"
HOMEPAGE="http://atpy.readthedocs.io"

RDEPEND=">=dev-python/astropy-0.2[${PYTHON_USEDEP}]
	hdf5? ( >=dev-python/h5py-1.3[${PYTHON_USEDEP}] )
	mysql? ( || ( >=dev-python/mysql-python-1.2.2[${PYTHON_USEDEP}]
		dev-python/mysqlclient[${PYTHON_USEDEP}] ) )
	postgres? ( >=dev-python/pygresql-3.8.1 )
"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	doc? (
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/astropy[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		<dev-python/astropy-3.2[${PYTHON_USEDEP}]
	)
"

IUSE="hdf5 mysql postgres sqlite examples"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="MIT"

PATCHES=( "${FILESDIR}/${P}-correct-doc-label.patch" )

distutils_enable_tests setup.py
distutils_enable_sphinx docs

python_install_all() {
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/examples"
		docinto examples
		dodoc -r examples/.
	fi

	distutils-r1_python_install_all
}
