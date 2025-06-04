# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="A clean book theme for scientific explanations and documentation with Sphinx"
HOMEPAGE="https://sphinx-book-theme.readthedocs.io"

LICENSE="BSD"
SLOT="0"
#KEYWORDS="~amd64 ~x86"
IUSE="code_style"
RESTRICT="test"	# test failed as no docutils<0.17

RDEPEND="dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	>=dev-python/docutils-0.15[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]
	~dev-python/pydata-sphinx-theme-0.7.2[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	code_style? ( dev-vcs/pre-commit )
"

distutils_enable_tests setup.py

pkg_postinst() {
	optfeature "extra sphinx support" "sci-geosciences/folium dev-python/numpy dev-python/matplotlib dev-python/ipywidgets \
		dev-python/pandas dev-python/plotly dev-python/nbclient dev-python/sphinxcontrib-bibtex dev-python/myst-nb \
		dev-python/sphinx-copybutton dev-python/sphinx-togglebutton dev-python/sphinx-thebe dev-python/ablog \
		dev-python/sphinxext-opengraph"
	optfeature "extra live-dev support" "dev-python/sphinx-autobuild dev-python/web-compile"
}
