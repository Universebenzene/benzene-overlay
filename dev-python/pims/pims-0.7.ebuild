# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature

DESCRIPTION="Python Image Sequence"
HOMEPAGE="https://soft-matter.github.io/pims"
SRC_URI="https://github.com/soft-matter/pims/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/imageio[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.19[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	>=dev-python/slicerator-0.9.8[${PYTHON_USEDEP}]
	dev-python/tifffile[${PYTHON_USEDEP}]
"

BDEPEND="test? ( dev-python/scikit-image[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

pkg_postinst() {
	optfeature "basic image reading" dev-python/matplotlib
	optfeature "basic image reading" dev-python/scikit-image
	optfeature "ipython display of images" dev-python/jinja2
	optfeature "ipython display of images & improved TIFF support" dev-python/pillow
	optfeature "video formats such as AVI, MOV" "dev-python/pyav media-video/ffmpeg"
	optfeature "interface with bioformats to support many microscopy formats" dev-python/jpype
	optfeature "alterative TIFF support" dev-python/tifffile
	optfeature "movie editing" dev-python/moviepy
	optfeature "improved Nikon .nd2 support" dev-python/pims-nd2
}
