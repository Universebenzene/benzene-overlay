# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="The bidirectional mapping library for Python"
HOMEPAGE="https://bidict.readthedocs.io"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"	# pytest-benchmark no x86

BDEPEND="test? (
		dev-python/pytest-benchmark[${PYTHON_USEDEP}]
		dev-python/hypothesis[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-copybutton dev-python/furo
