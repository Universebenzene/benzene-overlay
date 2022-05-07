# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Access HMI, AIA and MDI data with Python from the public JSOC DRMS server"
HOMEPAGE="https://docs.sunpy.org/projects/drms"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

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

BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]
	doc? (
		media-gfx/graphviz
	)
	test? (
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
		dev-python/astropy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs \
	dev-python/sphinx-automodapi \
	dev-python/sphinx-changelog \
	dev-python/sphinx-gallery \
	dev-python/sunpy-sphinx-theme \
	dev-python/astropy

python_configure_all() {
	sed "/# html_static_path/c html_static_path = ['$(python_get_sitedir)/sunpy_sphinx_theme/sunpy/static']" \
		-i docs/conf.py || die
}

python_prepare_all() {
	sed -i "/^os.environ/c os.environ[\"JSOC_EMAIL\"] = \"universebenzene@gmail.com\"" docs/conf.py || die
	sed -i "/20201101/s/20201101/$(date +%Y%m%d)/" examples/export_from_id.py || die
	mkdir -p changelog || die

	distutils-r1_python_prepare_all
}

python_test() {
	epytest --email "universebenzene@gmail.com"
}
