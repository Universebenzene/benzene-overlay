# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Use Jupyter in mkdocs websites"
HOMEPAGE="https://mkdocs-jupyter.danielfrg.com"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">dev-python/ipykernel-6.0.0[${PYTHON_USEDEP}]
	>dev-python/jupytext-1.13.8[${PYTHON_USEDEP}]
	>dev-python/mkdocs-material-9.0.0[${PYTHON_USEDEP}]
	>=dev-python/nbconvert-7.2.9[${PYTHON_USEDEP}]
	>dev-python/pygments-2.12.0[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

python_prepare_all() {
	# remove dep on pytest-cov
	sed -i -e "/--cov/d" pyproject.toml || die

	distutils-r1_python_prepare_all
}
