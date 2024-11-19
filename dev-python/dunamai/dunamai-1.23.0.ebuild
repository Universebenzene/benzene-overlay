# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Dynamic versioning library and CLI"
HOMEPAGE="https://dunamai.readthedocs.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
PROPERTIES="test_network"
RESTRICT="test"
RDEPEND=">=dev-python/packaging-20.9[${PYTHON_USEDEP}]"
BDEPEND="test? (
		dev-vcs/fossil
		dev-vcs/git
		dev-vcs/mercurial
		dev-vcs/subversion
	)
"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# https://gitlab.archlinux.org/archlinux/packaging/packages/python-dunamai/-/blob/main/PKGBUILD
	# skipping annoying ones that require messing with global git config
	tests/integration/test_dunamai.py::test__version__from_git__with_annotated_tags
	tests/integration/test_dunamai.py::test__version__from_git__with_lightweight_tags
	tests/integration/test_dunamai.py::test__version__from_git__with_mixed_tags
	tests/integration/test_dunamai.py::test__version__from_git__with_nonchronological_commits
	tests/integration/test_dunamai.py::test__version__from_git__gitflow
	tests/integration/test_dunamai.py::test__version__from_git__exclude_decoration
	tests/integration/test_dunamai.py::test__version__from_git__broken_ref
)
