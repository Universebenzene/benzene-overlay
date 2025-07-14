# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..13} )

MY_PN=MyST-NB
MY_P=${MY_PN}-${PV}

inherit distutils-r1 optfeature

DESCRIPTION="Parse and execute ipynb files in Sphinx"
HOMEPAGE="https://myst-nb.readthedocs.io"
SRC_URI="https://github.com/executablebooks/MyST-NB/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="code_style"
RESTRICT="test"	# Test phase runs with fails

RDEPEND="dev-python/importlib-metadata[${PYTHON_USEDEP}]
	dev-python/ipython[${PYTHON_USEDEP}]
	dev-python/ipykernel[${PYTHON_USEDEP}]
	>=dev-python/jupyter-cache-0.5[${PYTHON_USEDEP}]
	>=dev-python/myst-parser-1.0.0[${PYTHON_USEDEP}]
	dev-python/nbclient[${PYTHON_USEDEP}]
	>=dev-python/nbformat-5.0[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	>=dev-python/sphinx-5[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	code_style? ( dev-vcs/pre-commit )
"
BDEPEND="test? (
		dev-python/pytest-param-files[${PYTHON_USEDEP}]
		dev-python/pytest-regressions[${PYTHON_USEDEP}]
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/jupytext[${PYTHON_USEDEP}]
		dev-python/ipywidgets[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/nbconvert[${PYTHON_USEDEP}]
		dev-python/nbdime[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/sympy[${PYTHON_USEDEP}]
	)
"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "extra rtd support" "dev-python/alabaster dev-python/altair dev-python/bokeh \
		dev-python/ipywidgets>=8 dev-python/jupytext dev-python/numpy dev-python/matplotlib dev-python/pandas \
		dev-python/plotly dev-python/sphinx-book-theme dev-python/sphinx-copybutton dev-python/sphinx-design \
		dev-python/sphinxcontrib-bibtex dev-python/sympy>=1.10.1 dev-python/sphinx-autodoc-typehints"
}
