# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Powerful dict subclass(es) with aliasing & attribute access"
HOMEPAGE="https://github.com/bitprophet/lexicon"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="test? ( dev-python/pytest-relaxed[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
# releases requires semantic-version<2.7
#distutils_enable_sphinx docs dev-python/releases
