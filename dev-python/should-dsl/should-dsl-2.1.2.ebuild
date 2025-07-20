# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{{11..14},{13..14}t} )
#PYTHON_COMPAT=( python3_{{11..12},{13..14}{,t}} )

COMMIT="ded0323344f21311f366ffc711b65245aafc11f1"

inherit distutils-r1

DESCRIPTION="Should assertions in Python as clear and readable as possible"
HOMEPAGE="https://should-dsl.info"
SRC_URI="https://github.com/nsi-iff/${PN}/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

S="${WORKDIR}/${PN}-${COMMIT}"

python_test() {
	local PYTHONPATH="${BUILD_DIR}/lib"
	${EPYTHON} run_all_examples.py || die "Tests failed with ${EPYTHON}"
}
