# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="SSH Filesystem -- Async SSH/SFTP backend for fsspec"
HOMEPAGE="https://github.com/fsspec/sshfs"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/fsspec-2021.8.1[${PYTHON_USEDEP}]
	<dev-python/asyncssh-3[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/setuptools-scm-6.3.1[${PYTHON_USEDEP}]
	test? (
		dev-python/cryptography[${PYTHON_USEDEP}]
		$(python_gen_cond_dep 'dev-python/importlib-metadata[${PYTHON_USEDEP}]' python3_{11..13})
		dev-python/mock-ssh-server[${PYTHON_USEDEP}]
		dev-python/typing-extensions[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

python_prepare_all() {
	use $(python_gen_useflags python3_14) && { sed -i '/importlib_/s/importlib_/\importlib./' tests/test_sshfs.py || die ; }

	distutils-r1_python_prepare_all
}
