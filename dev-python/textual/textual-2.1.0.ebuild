# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Modern Text User Interface framework"
HOMEPAGE="https://textual.textualize.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND=">=dev-python/markdown-it-py-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/rich-13.3.3[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-4.2.2[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.4.0[${PYTHON_USEDEP}]
"
BDEPEND="test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		dev-python/linkify-it-py[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# https://gitlab.archlinux.org/archlinux/packaging/packages/python-textual/-/blob/main/PKGBUILD?ref_type=heads
	tests/snapshot_tests/test_snapshots.py
	tests/text_area/test_languages.py
)

python_test() {
	# https://gitlab.archlinux.org/archlinux/packaging/packages/python-textual/-/blob/main/PKGBUILD?ref_type=heads
	epytest -k 'not textual_env_var'
}

pkg_postinst() {
	optfeature_header "Extra syntax support:"
	optfeature "bindings for python" ">=dev-python/tree-sitter-0.23.0"
	optfeature "suppor for python" ">=dev-python/tree-sitter-python-0.23.0"
	optfeature "suppor for markdown" ">=dev-python/tree-sitter-markdown-0.3.0"
	optfeature "suppor for json" ">=dev-python/tree-sitter-json-0.24.0"
	optfeature "suppor for toml" ">=dev-python/tree-sitter-toml-0.6.0"
	optfeature "suppor for yaml" ">=dev-python/tree-sitter-yaml-0.6.0"
	optfeature "suppor for html" ">=dev-python/tree-sitter-html-0.23.0"
	optfeature "suppor for css" ">=dev-python/tree-sitter-css-0.23.0"
	optfeature "suppor for javascript" ">=dev-python/tree-sitter-javascript-0.23.0"
	optfeature "suppor for rust" ">=dev-python/tree-sitter-rust-0.23.0"
	optfeature "suppor for go" ">=dev-python/tree-sitter-go-0.23.0"
	optfeature "suppor for regex" ">=dev-python/tree-sitter-regex-0.24.0"
	optfeature "suppor for xml" ">=dev-python/tree-sitter-xml-0.7.0"
	optfeature "suppor for sql" ">=dev-python/tree-sitter-sql-0.3.0"
	optfeature "suppor for java" ">=dev-python/tree-sitter-java-0.23.0"
	optfeature "suppor for bash" ">=dev-python/tree-sitter-bash-0.23.0"
}
