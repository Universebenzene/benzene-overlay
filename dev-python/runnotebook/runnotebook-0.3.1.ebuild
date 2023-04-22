# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

MY_PN="RunNotebook"
MY_P=${MY_PN}-${PV}

DESCRIPTION="IPython notebook sphinx extensions"
HOMEPAGE="https://github.com/ngoldbaum/RunNotebook"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/ngoldbaum/${MY_PN}.git"
	inherit git-r3
else
	SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/jupyter[${PYTHON_USEDEP}]
	dev-python/nbconvert[${PYTHON_USEDEP}]
	dev-python/nbformat[${PYTHON_USEDEP}]
"

distutils_enable_tests nose
#distutils_enable_sphinx example/source dev-python/sphinx-bootstrap-theme dev-python/matplotlib dev-python/sympy
