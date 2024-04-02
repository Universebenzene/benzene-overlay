# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="A Sphinx extension to embed videos from YouTube"
HOMEPAGE="https://sphinxcontrib-youtube.readthedocs.io"
SRC_URI="https://github.com/sphinx-contrib/youtube/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc doc-demo"
RESTRICT="doc-demo? ( network-sandbox ) test"	# No usable test phases
REQUIRED_USE="doc-demo? ( doc )"

RDEPEND=">=dev-python/sphinx-0.6[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"
BDEPEND="doc? (
		${RDEPEND}
		dev-python/sphinx-copybutton[${PYTHON_USEDEP}]
		dev-python/furo[${PYTHON_USEDEP}]
	)
"

S="${WORKDIR}/youtube-${PV}"

#distutils_enable_tests nose
# Could not import extension sphinx.builders.epub3 (exception: No module named 'sphinxcontrib.serializinghtml')
#distutils_enable_sphinx docs/source dev-python/sphinx-copybutton dev-python/furo

python_prepare_all() {
	use doc && { mkdir -p docs/source/_static || die ; }
	use doc-demo || eapply "${FILESDIR}"/${P}-remove-doc-demo.patch
	sed -i 's/1.1.0/1.2.0/' setup.py || die

	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake -C docs html
		HTML_DOCS=( docs/build/html/. )
	fi
}
