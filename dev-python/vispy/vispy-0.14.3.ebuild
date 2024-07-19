# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

DATA_COM="5a3db8447d3e13ed402545662f20f5ff191a6d42"
DATA_DATE="20190506"
DATA_URI="https://github.com/vispy/demo-data/raw/${DATA_COM}"

inherit distutils-r1 pypi virtualx xdg-utils

DESCRIPTION="Interactive visualization in Python"
HOMEPAGE="http://vispy.org"
SRC_URI+=" doc? (
		${DATA_URI}/mona_lisa/mona_lisa_sm.png -> ${PN}-${DATA_DATE}-d-mona_lisa_sm.png
		${DATA_URI}/spot/spot.obj.gz -> ${PN}-${DATA_DATE}-d-spot.obj.gz
		${DATA_URI}/spot/spot.png -> ${PN}-${DATA_DATE}-d-spot.png
		${DATA_URI}/volume/stent.npz -> ${PN}-${DATA_DATE}-d-stent.npz
		${DATA_URI}/orig/triceratops.obj.gz -> ${PN}-${DATA_DATE}-d-triceratops.obj.gz
		${DATA_URI}/orig/crate.npz -> ${PN}-${DATA_DATE}-d-crate.npz
		${DATA_URI}/brain/mri.npz -> ${PN}-${DATA_DATE}-d-mri.npz
	)
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"	# no x86 KEYWORD for meshio PyQt6 pyside6
IUSE="examples glfw io ipython-static pyglet +pyqt5 pyqt6 pyside2 pyside6 sdl2 wx"
PROPERTIES="test_network"
RESTRICT="test"
REQUIRED_USE="|| ( pyglet pyqt5 pyqt6 pyside2 pyside6 sdl2 wx )
	pyside2? ( || ( $(python_gen_useflags python3_{10,11}) ) )
	wx? ( || ( $(python_gen_useflags python3_{10,11}) ) )"	# pyside2 about to be dropped

DEPEND="dev-python/numpy:=[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-python/freetype-py[${PYTHON_USEDEP}]
	dev-python/hsluv[${PYTHON_USEDEP}]
	dev-python/kiwisolver[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	glfw? ( dev-python/glfw[${PYTHON_USEDEP}] )
	io? (
		dev-python/meshio[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
	)
	ipython-static? ( dev-python/ipython[${PYTHON_USEDEP}] )
	pyglet? ( >=dev-python/pyglet-1.2[${PYTHON_USEDEP}] )
	pyqt5? ( dev-python/PyQt5[${PYTHON_USEDEP},gui,testlib,widgets] )
	pyqt6? ( dev-python/PyQt6[${PYTHON_USEDEP},gui,testlib,widgets] )
	pyside2? ( $(python_gen_cond_dep '
		dev-python/pyside2[${PYTHON_USEDEP},gui,testlib,widgets]
	' python3_{10,11}) )
	pyside6? ( dev-python/pyside6[${PYTHON_USEDEP},gui,testlib,widgets] )
	sdl2? ( dev-python/PySDL2[${PYTHON_USEDEP}] )
	wx? ( $(python_gen_cond_dep 'dev-python/wxpython[${PYTHON_USEDEP}]' python3_{10,11}) )
"
BDEPEND=">=dev-python/cython-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/setuptools-scm-7.1[${PYTHON_USEDEP}]
	doc? (
		media-libs/fontconfig
		virtual/opengl
	)
	test? (
		dev-python/imageio[${PYTHON_USEDEP}]
		dev-python/meshio[${PYTHON_USEDEP}]
		dev-python/networkx[${PYTHON_USEDEP}]
		dev-python/numpydoc[${PYTHON_USEDEP}]
		dev-python/pyopengl[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
		dev-python/sphinx-gallery[${PYTHON_USEDEP}]
		media-libs/fontconfig
		virtual/opengl
	)
"
#dev-python/setuptools_scm_git_archive[${PYTHON_USEDEP}]

distutils_enable_tests pytest
distutils_enable_sphinx doc dev-python/sphinx-gallery \
	dev-python/sphinxcontrib-apidoc \
	dev-python/pydata-sphinx-theme \
	dev-python/imageio \
	dev-python/myst-parser \
	dev-python/networkx \
	dev-python/numpydoc \
	dev-python/pyopengl \
	dev-python/pytest

python_prepare_all() {
	use doc && { eapply "${FILESDIR}"/${PN}-0.14.0-use-local-demo-data.patch ; \
		for dat in "${DISTDIR}"/*-d-*; do { cp ${dat} "${S}"/examples/scene/${dat##*-d-} || die ; } ; done ; \
		cp {"${DISTDIR}"/${PN}-${DATA_DATE}-d-,"${S}"/examples/plotting/}mri.npz || die ; }
	xdg_environment_reset

	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		use doc && [[ -d ${PN} ]] && { mv {,_}${PN} || die ; }
		# SANDBOX ACCESS DENIED:  open_wr:       /dev/fuse
		addpredict /dev/fuse
		virtx sphinx_compile_all
		[[ -d _${PN} ]] && { mv {_,}${PN} || die ; }
	fi
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
	virtx epytest "${BUILD_DIR}"
}
