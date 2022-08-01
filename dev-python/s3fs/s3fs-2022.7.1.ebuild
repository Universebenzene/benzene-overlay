# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Convenient Filesystem interface over S3"
HOMEPAGE="http://s3fs.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="awscli boto3"
PROPERTIES="test_network"
RESTRICT="test" # Test phase runs with fails

RDEPEND="dev-python/aiobotocore[${PYTHON_USEDEP},awscli?,boto3?]
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/fsspec[${PYTHON_USEDEP}]
"
BDEPEND="test? (
		dev-python/dask[${PYTHON_USEDEP}]
		dev-python/flask[${PYTHON_USEDEP}]
		dev-python/moto[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/xarray[${PYTHON_USEDEP}]
	)
"

PATCHES=( "${FILESDIR}/${PN}-2022.5.0-fix-doc-missing-blank-line.patch" )

distutils_enable_tests pytest
distutils_enable_sphinx docs/source dev-python/sphinx_rtd_theme dev-python/numpydoc

python_prepare_all() {
	use doc && { sed -i "/github/s/PR\ \#/PR\ \%s\#/" docs/source/conf.py || die ; \
		mkdir -p docs/source/_static || die ; }

	distutils-r1_python_prepare_all
}
