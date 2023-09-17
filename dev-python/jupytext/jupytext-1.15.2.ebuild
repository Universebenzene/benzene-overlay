# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="Jupyter notebooks as Markdown documents, Julia, Python or R scripts"
HOMEPAGE="https://jupytext.readthedocs.io"
SRC_URI="https://github.com/mwouts/jupytext/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	$(pypi_wheel_url)
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="rst2md"
RESTRICT="test"	# Test phase runs with fails

RDEPEND=">=dev-python/markdown-it-py-1.0.0[${PYTHON_USEDEP}]
	dev-python/mdit-py-plugins[${PYTHON_USEDEP}]
	dev-python/nbformat[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/toml[${PYTHON_USEDEP}]
	rst2md? ( dev-python/sphinx-gallery[${PYTHON_USEDEP}] )
"

BDEPEND="test? (
		dev-python/autopep8[${PYTHON_USEDEP}]
		dev-python/black[${PYTHON_USEDEP}]
		dev-python/flake8[${PYTHON_USEDEP}]
		dev-python/GitPython[${PYTHON_USEDEP}]
		dev-python/isort[${PYTHON_USEDEP}]
		dev-python/myst-parser[${PYTHON_USEDEP}]
		dev-python/nbconvert[${PYTHON_USEDEP}]
		dev-python/notebook[${PYTHON_USEDEP}]
		dev-python/sphinx-gallery[${PYTHON_USEDEP}]
		dev-vcs/pre-commit
		virtual/pandoc
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-copybutton dev-python/myst-parser

python_compile() {
	distutils_wheel_install "${BUILD_DIR}/install" \
		"${DISTDIR}/$(pypi_wheel_name)"
}

python_install_all() {
	distutils-r1_python_install_all
	mv "${ED%/}"/{usr/,}etc || die
}
