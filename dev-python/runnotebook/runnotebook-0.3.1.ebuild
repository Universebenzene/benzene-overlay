# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYPI_PN="RunNotebook"
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="IPython notebook sphinx extensions"
HOMEPAGE="https://github.com/ngoldbaum/RunNotebook"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/ngoldbaum/${PYPI_PN}.git"
	inherit git-r3
else
	inherit pypi
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD"
SLOT="0"
RESTRICT="test"	# No usable test phases

RDEPEND="dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/jupyter[${PYTHON_USEDEP}]
	dev-python/nbconvert[${PYTHON_USEDEP}]
	dev-python/nbformat[${PYTHON_USEDEP}]
"

#distutils_enable_tests nose
#distutils_enable_sphinx example/source dev-python/sphinx-bootstrap-theme dev-python/matplotlib dev-python/sympy
