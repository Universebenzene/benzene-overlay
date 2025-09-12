# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="CommonMark compliant Markdown formatter"
HOMEPAGE="https://mdformat.readthedocs.io"
SRC_URI="https://github.com/hukkin/mdformat/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/markdown-it-py-1.0.0[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/furo dev-python/accessible-pygments dev-python/myst-parser
