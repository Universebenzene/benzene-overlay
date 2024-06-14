# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 #git-r3

COMMIT="468627ea13ed4c3043dc67ccc1ff16089fdb7b25"

DESCRIPTION="State machine implementation for Python objects"
HOMEPAGE="https://github.com/nsi-iff/fluidity"
#EGIT_REPO_URI="https://github.com/nsi-iff/${PN}.git"
#EGIT_COMMIT="468627e"
SRC_URI="https://github.com/nsi-iff/${PN}/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-python/should-dsl[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${PN}-${COMMIT}"

python_test() {
	local PYTHONPATH="${BUILD_DIR}/lib"
	# Copied from https://github.com/nsi-iff/fluidity/blob/master/tox.ini
	${EPYTHON} spec/callable_support_spec.py || die "Tests failed with ${EPYTHON}"
	${EPYTHON} spec/callback_order_spec.py || die "Tests failed with ${EPYTHON}"
	${EPYTHON} spec/configuration_spec.py || die "Tests failed with ${EPYTHON}"
	${EPYTHON} spec/event_parameters_spec.py || die "Tests failed with ${EPYTHON}"
	${EPYTHON} spec/event_spec.py || die "Tests failed with ${EPYTHON}"
	${EPYTHON} spec/guard_spec.py || die "Tests failed with ${EPYTHON}"
	${EPYTHON} spec/individuation_spec.py || die "Tests failed with ${EPYTHON}"
	${EPYTHON} spec/one_event_multiple_transitions_spec.py || die "Tests failed with ${EPYTHON}"
	${EPYTHON} spec/state_action_spec.py || die "Tests failed with ${EPYTHON}"
	${EPYTHON} spec/state_spec.py || die "Tests failed with ${EPYTHON}"
	${EPYTHON} spec/transition_action_spec.py || die "Tests failed with ${EPYTHON}"
	${EPYTHON} spec/boolean_state_getters_spec.py || die "Tests failed with ${EPYTHON}"
}
