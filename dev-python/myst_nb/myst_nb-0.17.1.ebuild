# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{9..11} )

MY_PN=${PN/_/-}
MY_P=${MY_PN}-${PV}

inherit distutils-r1 optfeature

DESCRIPTION="Parse and execute ipynb files in Sphinx"
HOMEPAGE="https://myst-nb.readthedocs.io"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="code_style"
RESTRICT="test"	# Test phase runs with fails

RDEPEND="dev-python/importlib_metadata[${PYTHON_USEDEP}]
	dev-python/ipython[${PYTHON_USEDEP}]
	dev-python/jupyter-cache[${PYTHON_USEDEP}]
	dev-python/nbclient[${PYTHON_USEDEP}]
	dev-python/myst_parser[${PYTHON_USEDEP}]
	dev-python/nbformat[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	code_style? ( dev-vcs/pre-commit )
"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests nose

pkg_postinst() {
	optfeature "extra rtd support" "dev-python/alabaster dev-python/altair dev-python/bokeh dev-python/ipykernel \
		dev-python/ipywidgets>=8 dev-python/jupytext dev-python/numpy dev-python/matplotlib<3.6 dev-python/pandas \
		dev-python/plotly dev-python/sphinx-book-theme dev-python/sphinx-copybutton dev-python/sphinx_design \
		dev-python/sphinxcontrib-bibtex dev-python/sympy>=1.10.1"
}
