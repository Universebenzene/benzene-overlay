# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Settings management using Pydantic"
HOMEPAGE="https://docs.pydantic.dev/latest/concepts/pydantic_settings"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="toml yaml"

RDEPEND=">=dev-python/pydantic-2.7.0[${PYTHON_USEDEP}]
	>=dev-python/python-dotenv-0.21.0[${PYTHON_USEDEP}]
	toml? ( >=dev-python/tomli-2.0.1[${PYTHON_USEDEP}] )
	yaml? ( >=dev-python/pyyaml-6.0.1[${PYTHON_USEDEP}] )
"
BDEPEND="test? (
		dev-python/pytest-examples[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

#EPYTEST_IGNORE=(
#	# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pydantic-settings/-/blob/main/PKGBUILD
#	# we don't yet have azure integration in the repos
#	tests/test_source_azure_key_vault.py
#)

EPYTEST_DESELECT=(
	# ModuleNotFoundError: No module named 'azure'
	tests/test_docs.py::test_docs_examples[docs/index.md:1803-1847]
)
