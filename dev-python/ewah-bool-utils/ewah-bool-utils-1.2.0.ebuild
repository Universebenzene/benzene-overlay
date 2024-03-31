# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="EWAH Bool Array utils for yt"
HOMEPAGE="https://github.com/yt-project/ewah_bool_utils"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-python/numpy-1.19.3[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND=">=dev-python/cython-3.0[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
distutils_enable_sphinx docs

python_prepare_all() {
	use doc && { mkdir docs/_static || die ; eapply "${FILESDIR}"/${PN}-1.0.2-fix-title-underline.patch ; \
#		sed -i "/language\ = /s/None/'en'/" docs/conf.py || die ;
	}

	distutils-r1_python_prepare_all
}

python_compile_all() {
#	ModuleNotFoundError: No module named 'ewah_bool_utils.ewah_bool_wrap'
	use doc && [[ -d ${PN//-/_} ]] && { mv {,_}${PN//-/_} || die ; }
	sphinx_compile_all
	[[ -d _${PN//-/_} ]] && { mv {_,}${PN//-/_} || die ; }
}

python_test() {
#	ModuleNotFoundError: No module named 'ewah_bool_utils.ewah_bool_wrap'
	[[ -d ${PN//-/_} ]] && { mv {,_}${PN//-/_} || die ; }
	epytest
	[[ -d _${PN//-/_} ]] && { mv {_,}${PN//-/_} || die ; }
}
