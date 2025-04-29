# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Highly concurrent networking library"
HOMEPAGE="
	https://pypi.org/project/eventlet/
	https://github.com/eventlet/eventlet/
"

LICENSE="MIT"
SLOT="0"
#KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"
KEYWORDS="~amd64 ~riscv ~x86"	# thrift
IUSE="examples"

RDEPEND=">=dev-python/dnspython-1.15.0[${PYTHON_USEDEP}]
	>=dev-python/greenlet-1.0[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/hatch-vcs-0.3[${PYTHON_USEDEP}]
	test? (
		dev-python/httplib2[${PYTHON_USEDEP}]
		dev-python/psycopg:2[${PYTHON_USEDEP}]
		dev-python/pyopenssl[${PYTHON_USEDEP}]
		dev-python/pyzmq[${PYTHON_USEDEP}]
	)
"

#PATCHES=(
#	"${FILESDIR}/eventlet-0.25.1-tests.patch"
#	"${FILESDIR}/eventlet-0.30.0-tests-socket.patch"
#	"${FILESDIR}/eventlet-0.30.2-test-timeout.patch"
#	"${FILESDIR}/${PN}-0.33.2-python310.patch"
#)

distutils_enable_tests pytest
distutils_enable_sphinx doc/source dev-python/sphinxcontrib-apidoc \
	dev-python/py \
	dev-python/pyopenssl \
	dev-python/psycopg:2 \
	dev-python/pyzmq \
	dev-python/thrift

src_prepare() {
#	# increase timeout - #791748
#	sed -e '/eventlet.sleep/s/0.1/5.0/' -i tests/isolated/patcher_fork_after_monkey_patch.py || die
	use doc && { mkdir -p doc/source/_static || die ; }

	distutils-r1_src_prepare
}

python_install_all() {
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/examples"
		docinto examples
		dodoc -r examples/.
	fi

	distutils-r1_python_install_all
}

pkg_postinst() {
	optfeature "non-blocking HTTP support" dev-python/httplib2
	optfeature "non-blocking PostgreSQL support" dev-python/psycopg:2
	optfeature "non-blocking SSL support" dev-python/pyopenssl
	optfeature "non-blocking ZeroMQ support" dev-python/pyzmq
}
