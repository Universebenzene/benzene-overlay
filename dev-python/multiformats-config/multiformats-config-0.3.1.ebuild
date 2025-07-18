# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Pre-loading configuration module for the 'multiformats' package"
HOMEPAGE="https://github.com/hashberg-io/multiformats-config"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# No usable test phases

BDEPEND=">=dev-python/setuptools-scm-6.2[${PYTHON_USEDEP}]"
PDEPEND="dev-python/multiformats[${PYTHON_USEDEP}]"

#distutils_enable_tests nose
