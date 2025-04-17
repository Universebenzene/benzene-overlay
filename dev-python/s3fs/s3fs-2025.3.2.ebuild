# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Convenient Filesystem interface over S3"
HOMEPAGE="http://s3fs.readthedocs.io"
SRC_URI+=" doc? ( https://github.com/fsspec/s3fs/raw/${PV}/docs/source/conf.py -> ${P}-conf.py )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="awscli boto3"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND=">=dev-python/aiobotocore-2.7.0[${PYTHON_USEDEP},awscli?,boto3?]
	dev-python/aiohttp[${PYTHON_USEDEP}]
	>=dev-python/fsspec-2024.12.0[${PYTHON_USEDEP}]
"
BDEPEND="test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/dask[${PYTHON_USEDEP}]
		dev-python/moto[${PYTHON_USEDEP}]
		dev-python/xarray[${PYTHON_USEDEP}]
		<dev-python/zarr-3[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs/source dev-python/sphinx-rtd-theme

python_prepare_all() {
	use doc && { mkdir -p docs/source/_static || die ; \
		cp {"${DISTDIR}"/${P}-,"${S}"/docs/source/}conf.py || die ; }

	distutils-r1_python_prepare_all
}
