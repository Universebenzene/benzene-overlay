# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="SSH Filesystem -- Async SSH/SFTP backend for fsspec"
HOMEPAGE="https://github.com/fsspec/sshfs"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# paramiko[server] is hard masked

RDEPEND=">=dev-python/fsspec-2021.8.1[${PYTHON_USEDEP}]
	<dev-python/asyncssh-3[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/setuptools-scm-6.3.1[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/cryptography[${PYTHON_USEDEP}]
		dev-python/importlib-metadata[${PYTHON_USEDEP}]
		dev-python/mock-ssh-server[${PYTHON_USEDEP}]
		dev-python/typing-extensions[${PYTHON_USEDEP}]
		net-analyzer/openbsd-netcat
		virtual/openssh
	)
"

distutils_enable_tests pytest
