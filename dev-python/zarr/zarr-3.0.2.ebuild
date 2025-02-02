# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="An implementation of chunked, compressed, N-dimensional arrays for Python"
HOMEPAGE="http://zarr.readthedocs.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
#IUSE="examples optional remote"
IUSE="optional remote"

RDEPEND=">=dev-python/donfig-0.8[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.25[${PYTHON_USEDEP}]
	>=dev-python/numcodecs-0.14[${PYTHON_USEDEP},crc32c]
	>=dev-python/packaging-22.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.9[${PYTHON_USEDEP}]
	optional? (
		dev-python/rich[${PYTHON_USEDEP}]
		dev-python/universal-pathlib[${PYTHON_USEDEP}]
	)
	remote? ( >=dev-python/fsspec-2023.10.0[${PYTHON_USEDEP}] )
"
BDEPEND="dev-python/hatch-vcs[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/flask-cors[${PYTHON_USEDEP}]
		dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/moto[${PYTHON_USEDEP}]
		dev-python/rich[${PYTHON_USEDEP}]
		dev-python/s3fs[${PYTHON_USEDEP}]
		dev-python/universal-pathlib[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
#distutils_enable_sphinx docs dev-python/numpydoc \
#	dev-python/sphinx-autoapi \
#	dev-python/sphinx-copybutton \
#	dev-python/sphinx-design \
#	dev-python/sphinx-issues \
#	dev-python/sphinx-reredirects \
#	dev-python/pydata-sphinx-theme

#python_install_all() {
#	if use examples; then
#		docompress -x "/usr/share/doc/${PF}/notebooks"
#		docinto notebooks
#		dodoc -r notebooks/.
#	fi
#
#	distutils-r1_python_install_all
#}
