# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Meta-package providing oldest supported Numpy for given Python version"
HOMEPAGE="https://github.com/scipy/oldest-supported-numpy"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]"

#distutils_enable_tests nose

python_prepare() {
	sed -i "/${EPYTHON#python}/s/==/>=/" setup.cfg || die
}

#python_prepare_all() {
##   DISTUTILS_IN_SOURCE_BUILD is not supported in PEP517 mode
#	for py3i in {11..13}; do
#		use $(python_gen_useflags python3_${py3i}) && { sed -i "/3.${py3i}/s/==/>=/" setup.cfg || die ; }
#	done
#	distutils-r1_python_prepare_all
#}
