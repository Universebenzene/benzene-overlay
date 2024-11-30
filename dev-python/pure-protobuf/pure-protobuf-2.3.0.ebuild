# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Implementation of Protocol Buffers with dataclass-based schema's"
HOMEPAGE="https://github.com/eigenein/protobuf"
SRC_URI="https://github.com/eigenein/protobuf/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="dev-python/hatch-vcs[${PYTHON_USEDEP}]
	test? ( dev-python/pytest-benchmark[${PYTHON_USEDEP}] )
"

S="${WORKDIR}/protobuf-${PV}"

distutils_enable_tests pytest

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

python_prepare_all() {
	sed -i -e "s/0.0.0/${PV}/" -e "/enable/s/true/false/" -e '/--cov/d' pyproject.toml || die

	distutils-r1_python_prepare_all
}
