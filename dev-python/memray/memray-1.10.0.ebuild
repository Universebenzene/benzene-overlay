# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1 pypi

DESCRIPTION="A memory profiler for Python applications"
HOMEPAGE="https://bloomberg.github.io/memray"
SRC_URI="https://github.com/bloomberg/memray/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz
	$(python_gen_useflags python3_12)? ( $(pypi_wheel_url ${PN} ${PV} "cp312" "cp312-manylinux_2_17_x86_64.manylinux2014_x86_64") )
	$(python_gen_useflags python3_11)? ( $(pypi_wheel_url ${PN} ${PV} "cp311" "cp311-manylinux_2_17_x86_64.manylinux2014_x86_64") )
"
#	$(python_gen_useflags python3_10)? ( $(pypi_wheel_url ${PN} ${PV} "cp310" "cp310-manylinux_2_12_x86_64.manylinux2010_x86_64") )

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"	# Test phase runs with fails

RDEPEND=">=dev-python/jinja2-2.9[${PYTHON_USEDEP}]
	>=dev-python/rich-11.2.0[${PYTHON_USEDEP}]
	app-arch/lz4
	sys-libs/libunwind
"
BDEPEND="test? (
		dev-python/ipython[${PYTHON_USEDEP}]
		dev-debug/gdb
		llvm-core/lldb
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-argparse dev-python/furo dev-python/ipython

EPYTEST_DESELECT=(
	# Stucked tests
	tests/integration/test_processes.py::test_allocations_with_multiprocessing_following_fork
	tests/integration/test_processes.py::test_pymalloc_allocations_after_fork
)

python_compile() {
	if use $(python_gen_useflags python3_12); then
		local _pytag="cp312"
		local _abitag="cp312-manylinux_2_17_x86_64.manylinux2014_x86_64"
	elif use $(python_gen_useflags python3_11); then
		local _pytag="cp311"
		local _abitag="cp311-manylinux_2_17_x86_64.manylinux2014_x86_64"
	#elif use $(python_gen_useflags python3_10); then
	#	local _pytag="cp310"
	#	local _abitag="cp310-manylinux_2_12_x86_64.manylinux2010_x86_64"
	fi
	distutils_wheel_install "${BUILD_DIR}/install" \
		"${DISTDIR}"/$(pypi_wheel_name "${PN}" "${PV}" "${_pytag}" "${_abitag}")
}

python_test() {
	# ImportError: cannot import name 'AllocationRecord' from 'memray._memray' (unknown location)
	mv src/{,_}${PN} || die
	mv src/_${PN}/_te{s,t}t.py || die
	epytest
	mv src/_${PN}/_te{t,s}t.py || die
	mv src/{_,}${PN} || die
}
