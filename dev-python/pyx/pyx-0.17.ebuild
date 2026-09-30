# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="Python package for the generation of encapsulated PostScript figures"
#MY_PN="PyX"
#MY_P=${MY_PN}-${PV}
HOMEPAGE="
	https://github.com/pyx-project/pyx
	https://pyx-project.org/
	https://pypi.org/project/PyX/"
#SRC_URI="https://github.com/pyx-project/${PN}/releases/download/${PV}/${MY_P}.tar.gz -> ${P}.gh.tar.gz"
SRC_URI="https://github.com/pyx-project/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

#S="${WORKDIR}"/${MY_P}
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND="dev-python/pillow[${PYTHON_USEDEP}]
	virtual/tex-base
	virtual/latex-base
	dev-texlive/texlive-basic
"
BDEPEND="doc? (
		dev-python/sphinx[latex,${PYTHON_USEDEP}]
		dev-python/sphinx-selective-exclude[${PYTHON_USEDEP}]
	)
	test? (
		app-text/ghostscript-gpl
		dev-python/sphinx[latex,${PYTHON_USEDEP}]
		dev-python/sphinx-selective-exclude[${PYTHON_USEDEP}]
		dev-python/testfixtures[${PYTHON_USEDEP}]
	)
"

#PATCHES=( "${FILESDIR}"/pyx-0.14.1-unicode-latex.patch )

#python_check_deps() {
#	use doc || return 0
#	python_has_version "dev-python/sphinx[latex,${PYTHON_USEDEP}]" \
#		"dev-python/sphinx-selective-exclude[${PYTHON_USEDEP}]"
#}

#src_prepare() {
#	sed -i \
#		-e 's/^build_t1code=.*/build_t1code=1/' \
#		-e 's/^build_pykpathsea=.*/build_pykpathsea=1/' \
#		setup.cfg || die "setup.cfg fix failed"
#	distutils-r1_src_prepare
#}

python_prepare_all() {
	# https://github.com/pyx-project/pyx/issues/39
	sed -i 's|methods = local internal pykpathsea kpsewhich|methods = local internal recursivedir pykpathsea kpsewhich|' pyx/data/pyxrc || die
	echo "recursivedir = /usr/share/texmf-dist/fonts/type1/public/amsfonts/" >> pyx/data/pyxrc || die
	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		local -x VARTEXFONTS="${T}"/fonts
		PYTHONPATH="${WORKDIR}"/${P}-${EPYTHON/./_}/install/usr/lib/${EPYTHON}/site-packages \
			emake -C "${S}"/manual latexpdf
		PYTHONPATH="${WORKDIR}"/${P}-${EPYTHON/./_}/install/usr/lib/${EPYTHON}/site-packages \
			emake -C "${S}"/faq latexpdf
	fi
}

python_install_all() {
	use doc && dodoc manual/_build/latex/manual.pdf faq/_build/latex/pyxfaq.pdf
	distutils-r1_python_install_all
}

python_test() {
	emake -C test unit functional svg doctest
}
