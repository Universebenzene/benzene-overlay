# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Relaxed test discovery/organization for pytest"
HOMEPAGE="https://github.com/bitprophet/pytest-relaxed"
SRC_URI="https://github.com/bitprophet/pytest-relaxed/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND=">=dev-python/pytest-7[${PYTHON_USEDEP}]
	dev-python/decorator[${PYTHON_USEDEP}]
"

distutils_enable_tests --install pytest
# require releases, which depends on semantic-version<2.7
#distutils_enable_sphinx docs
