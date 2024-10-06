# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Shared python utilities for https://github.com/agurvich 's packages"
HOMEPAGE="https://github.com/agurvich/abg_python"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/scipy[${PYTHON_USEDEP}]
	dev-python/h5py[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-3.5[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

python_prepare_all() {
	sed -i 's/np.AxisError/np.exceptions.AxisError/g' src/abg_python/array_utils.py || die

	distutils-r1_python_prepare_all
}
