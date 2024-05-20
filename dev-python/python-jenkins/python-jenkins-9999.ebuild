# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Python bindings for the remote Jenkins API"
HOMEPAGE="https://python-jenkins.readthedocs.io"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://opendev.org/jjb/${PN}.git"
	inherit git-r3
else
	inherit pypi
	KEYWORDS="~amd64"	# multiprocess no x86
fi

LICENSE="BSD"
SLOT="0"
RESTRICT="test"	# object has no attribute 'j'

RDEPEND="dev-python/multi_key_dict[${PYTHON_USEDEP}]
	>=dev-python/pbr-0.8.2[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/six-1.3.0[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/pbr[${PYTHON_USEDEP}]
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/multiprocess[${PYTHON_USEDEP}]
		dev-python/requests-mock[${PYTHON_USEDEP}]
		dev-python/testscenarios[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx doc/source

python_prepare_all() {
	use doc && { sed -i "/version_info/s/jenkins/python-jenkins/" jenkins/version.py || die ; }

	distutils-r1_python_prepare_all
}
