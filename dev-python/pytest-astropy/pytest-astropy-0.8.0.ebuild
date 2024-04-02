# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="Metapackage for all the testing machinery used by the Astropy Project"
HOMEPAGE="https://github.com/astropy/pytest-astropy"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# No usable test phases
RDEPEND=">=dev-python/hypothesis-5.1[${PYTHON_USEDEP}]
	>=dev-python/pytest-astropy-header-0.1.2[${PYTHON_USEDEP}]
	>=dev-python/pytest-arraydiff-0.1[${PYTHON_USEDEP}]
	>=dev-python/pytest-doctestplus-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/pytest-openfiles-0.3.1[${PYTHON_USEDEP}]
	>=dev-python/pytest-remotedata-0.3.1[${PYTHON_USEDEP}]
	>=dev-python/pytest-filter-subpackage-0.1[${PYTHON_USEDEP}]
	>=dev-python/pytest-cov-2.0[${PYTHON_USEDEP}]
	>=dev-python/pytest-4.6.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
#BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"
