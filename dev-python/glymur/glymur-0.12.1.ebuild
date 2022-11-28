# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

MY_PN=${PN^}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Tools for accessing JPEG2000 files"
HOMEPAGE="https://glymur.readthedocs.org"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
"

S="${WORKDIR}/${MY_P}"

# no tests data since 0.12.1
#distutils_enable_tests pytest
# no docs dir since 0.12.1
#distutils_enable_sphinx docs/source dev-python/numpydoc dev-python/sphinx_rtd_theme
