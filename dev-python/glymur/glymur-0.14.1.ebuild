# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Tools for accessing JPEG2000 files"
HOMEPAGE="https://glymur.readthedocs.org"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/setuptools-scm-8.0[${PYTHON_USEDEP}]
	test? (
		sci-libs/gdal[python]
		dev-python/scikit-image[${PYTHON_USEDEP}]
		media-libs/openjpeg:2
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs/source dev-python/numpydoc dev-python/sphinx-rtd-theme

python_prepare_all() {
	sed -i "s/'MIT'/{ text = 'MIT' }/" pyproject.toml || die
	use doc && { mkdir docs/source/_static || die ; }
	# NO RECORD files in *.dist-info
#	use test && { sed -e "/os_release/s/and/or/" -e "/os_release/s/id/ID/" \
#		-e "/platform.system/s/linux/Linux/" -i tests/fixtures.py || die ; }
	distutils-r1_python_prepare_all
}
