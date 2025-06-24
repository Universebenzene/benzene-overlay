# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{{11..14},{13..14}t} )
#PYTHON_COMPAT=( python3_{{11..12},{13..14}{,t}} )

inherit distutils-r1 pypi

DESCRIPTION="Python bindings to Zstandard (zstd) compression library"
HOMEPAGE="https://pyzstd.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/zstd:="
RDEPEND="${DEPEND}
	$(python_gen_cond_dep 'dev-python/typing-extensions[${PYTHON_USEDEP}]' python3_{11,12})
"

distutils_enable_tests pytest

python_prepare_all() {
	sed -i 's/pyzstd_pep517/setuptools.build_meta/' pyproject.toml || die
	rm -r zstd || die
	distutils-r1_python_prepare_all
}

python_configure_all() {
	DISTUTILS_ARGS=( --dynamic-link-zstd )
}
