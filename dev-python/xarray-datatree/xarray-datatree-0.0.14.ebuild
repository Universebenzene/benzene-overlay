# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Hierarchical tree-like data structures for xarray"
HOMEPAGE="https://xarray-datatree.readthedocs.io"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/xarray-2023.12.0[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/check-manifest[${PYTHON_USEDEP}]
	>=dev-python/setuptools-scm-7.0[${PYTHON_USEDEP}]
	test? (
		dev-python/h5netcdf[${PYTHON_USEDEP}]
		dev-python/netcdf4[${PYTHON_USEDEP}]
		dev-python/zarr[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs/source dev-python/sphinx-autosummary-accessors \
	dev-python/sphinx-copybutton \
	dev-python/sphinx-book-theme \
	dev-python/sphinxcontrib-srclinks \
	dev-python/sphinxext-opengraph \
	dev-python/nbsphinx \
	dev-python/ipython

python_prepare_all() {
	sed -i "/build-system/a build-backend = \"setuptools.build_meta\"" pyproject.toml || die

	distutils-r1_python_prepare_all
}

pkg_postinst() {
	optfeature "allow file I/O" "dev-python/h5netcdf dev-python/netcdf4 dev-python/zarr"
}
