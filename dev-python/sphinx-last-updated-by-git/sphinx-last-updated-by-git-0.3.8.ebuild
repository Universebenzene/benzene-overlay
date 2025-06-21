# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RF_COMMIT="23d25d0b7ac4604b7a9545420b2f9de84daabe73"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Get the last updated time for each Sphinx page from Git"
HOMEPAGE="https://github.com/mgeier/sphinx-last-updated-by-git"
SRC_URI+=" test? ( https://github.com/mgeier/test-repo-for-sphinx-last-updated-by-git/archive/${RF_COMMIT}.tar.gz -> ${P}-repo_full-${RF_COMMIT}.tar.gz )"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/sphinx-1.8[${PYTHON_USEDEP}]
	dev-vcs/git
"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# AUR
	tests/test_example_repo.py
	tests/test_singlehtml.py
)

python_prepare_all() {
	use test && { cp -r "${WORKDIR}"/test-repo-for-sphinx-last-updated-by-git-${RF_COMMIT} tests/repo_full || die ; }
	distutils-r1_python_prepare_all
}

python_test() {
	# AUR
	epytest -k 'not untracked_source_files'
}
