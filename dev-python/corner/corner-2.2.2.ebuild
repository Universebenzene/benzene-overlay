# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 optfeature

DESCRIPTION="Make scatter matrix corner plots"
HOMEPAGE="https://corner.readthedocs.io"
SRC_URI="https://github.com/dfm/corner.py/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"	# arviz no x86
IUSE="arviz"
RESTRICT="test"	# matplotlib.testing.exceptions.ImageComparisonFailure: images not close

RDEPEND=">=dev-python/matplotlib-2.1[${PYTHON_USEDEP}]
	arviz? ( >=dev-python/arviz-0.9[${PYTHON_USEDEP}] )"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		>=dev-python/arviz-0.9[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
	)
"

S="${WORKDIR}/${PN}.py-${PV}"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-book-theme \
	dev-python/myst-nb \
	dev-python/arviz

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

pkg_postinst() {
	optfeature "optional dependency" dev-python/scipy
}
