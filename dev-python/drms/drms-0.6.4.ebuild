# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Access HMI, AIA and MDI data with Python from the public JSOC DRMS server"
HOMEPAGE="https://docs.sunpy.org/projects/drms"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"
PROPERTIES="test_network"
RESTRICT="test
	examples? ( network-sandbox )"
REQUIRED_USE="examples? ( doc )"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
"

BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	doc? ( media-gfx/graphviz )
	test? (
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
		dev-python/astropy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-automodapi \
	dev-python/sphinx-changelog \
	dev-python/sphinx-gallery \
	dev-python/sunpy-sphinx-theme \
	dev-python/astropy

python_prepare_all() {
	sed -i "/20201101/s/20201101/$(date -d yesterday +%Y%m%d)/" examples/skip_export_from_id.py || die

	distutils-r1_python_prepare_all
}

python_install_all() {
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/examples"
		docinto examples
		dodoc -r examples/.
	fi

	distutils-r1_python_install_all
}

python_test() {
	JSOC_EMAIL="jsoc@sunpy.org" epytest #--email "jsoc@sunpy.org"
}
