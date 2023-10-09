# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin}"
MY_P="${MY_PN}-${PV}"
CONDA_FORGE_URI="https://api.anaconda.org/download/conda-forge"

DESCRIPTION="Tiny version of mamba, the fast conda package installer (binary version)"
HOMEPAGE="https://github.com/mamba-org/mamba"
SRC_URI="amd64? ( ${CONDA_FORGE_URI}/${MY_PN}/${PV}/linux-64/${MY_P}-0.tar.bz2 -> ${P}-amd64.tar.bz2 )
	arm64? ( ${CONDA_FORGE_URI}/${MY_PN}/${PV}/linux-aarch64/${MY_P}-0.tar.bz2 -> ${P}-arm64.tar.bz2 )
"
LICENSE="BSD"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND="${DEPEND}
	!dev-util/micromamba
"

S="${WORKDIR}"

QA_PREBUILT="usr/bin/${PN%-bin}"

src_install() {
	dobin bin/${MY_PN}
}

src_test() {
	einfo "Testing with ${S}/bin/${MY_PN}"
	PATH="${S}/bin:${PATH}" sh info/test/run_test.sh || die "test suite failed"
}
