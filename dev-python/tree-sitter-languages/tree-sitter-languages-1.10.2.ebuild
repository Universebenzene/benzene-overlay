# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Binary Python wheels for all tree sitter languages"
HOMEPAGE="https://github.com/grantjenks/py-tree-sitter-languages"
SRC_URI="https://github.com/grantjenks/py-tree-sitter-languages/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	$(python_gen_useflags python3_12)? ( $(pypi_wheel_url ${PN} ${PV} "cp312" "cp312-manylinux_2_17_x86_64.manylinux2014_x86_64") )
	$(python_gen_useflags python3_11)? ( $(pypi_wheel_url ${PN} ${PV} "cp311" "cp311-manylinux_2_17_x86_64.manylinux2014_x86_64") )
	$(python_gen_useflags python3_10)? ( $(pypi_wheel_url ${PN} ${PV} "cp310" "cp310-manylinux_2_17_x86_64.manylinux2014_x86_64") )
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/tree-sitter[${PYTHON_USEDEP}]"

S="${WORKDIR}/py-${P}"

distutils_enable_tests pytest

python_compile() {
	if use $(python_gen_useflags python3_12); then
		local _pytag="cp312"
		local _abitag="cp312-manylinux_2_17_x86_64.manylinux2014_x86_64"
	elif use $(python_gen_useflags python3_11); then
		local _pytag="cp311"
		local _abitag="cp311-manylinux_2_17_x86_64.manylinux2014_x86_64"
	elif use $(python_gen_useflags python3_10); then
		local _pytag="cp310"
		local _abitag="cp310-manylinux_2_17_x86_64.manylinux2014_x86_64"
	fi
	distutils_wheel_install "${BUILD_DIR}/install" \
		"${DISTDIR}"/$(pypi_wheel_name "${PN}" "${PV}" "${_pytag}" "${_abitag}")
}

python_test() {
	# ModuleNotFoundError: No module named 'tree_sitter_languages.core'
	local _PN=$(pypi_normalize_name ${PN})
	[[ -d ${_PN} ]] && { mv {,_}${_PN} || die ; }
	epytest
	[[ -d _${_PN} ]] && { mv {_,}${_PN} || die ; }
}
