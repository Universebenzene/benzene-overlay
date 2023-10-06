# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

COMMIT="5ffb2abacfcd665d9aca891b84db4cb921e1174d"

inherit distutils-r1

DESCRIPTION="Preparing inputs to and reading outputs from Stan"
HOMEPAGE="https://github.com/WardBrian/stanio"
SRC_URI="https://github.com/WardBrian/${PN}/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz "

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/pandas[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${PN}-${COMMIT}"

distutils_enable_tests pytest
