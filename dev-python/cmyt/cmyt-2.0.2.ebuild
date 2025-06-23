# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="A collection of Matplotlib colormaps from the yt project"
HOMEPAGE="https://github.com/yt-project/cmyt"
SRC_URI="https://github.com/yt-project/cmyt/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/matplotlib-3.8.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.26.0[${PYTHON_USEDEP}]
"
BDEPEND="test? (
		>=dev-python/pytest-mpl-0.13[${PYTHON_USEDEP}]
		>=dev-python/colorspacious-1.1.2[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
