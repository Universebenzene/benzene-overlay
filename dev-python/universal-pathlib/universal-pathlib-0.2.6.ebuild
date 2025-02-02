# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi optfeature

DESCRIPTION="pathlib api extended to use fsspec backends"
HOMEPAGE="https://github.com/fsspec/universal_pathlib"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND=">=dev-python/fsspec-2024.3.1[${PYTHON_USEDEP}]"
BDEPEND=">=dev-python/setuptools-scm-8[${PYTHON_USEDEP}]
	test? (
		dev-python/cheroot[${PYTHON_USEDEP}]
		dev-python/fsspec[${PYTHON_USEDEP}]
		dev-python/moto[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/s3fs[${PYTHON_USEDEP}]
		dev-python/smbprotocol[${PYTHON_USEDEP}]
		dev-python/webdav4[${PYTHON_USEDEP}]
		dev-python/wsgidav[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# botocore.exceptions.EndpointConnectionError:
	# Could not connect to the endpoint URL: "http://127.0.0.1:5555/test_bucket"
	upath/tests/implementations/test_s3.py
)

python_install_all() {
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/notebooks"
		docinto notebooks
		dodoc -r notebooks/.
	fi

	distutils-r1_python_install_all
}

pkg_postinst() {
	optfeature "RFC 2397 style data URLs" ">=dev-python/fsspec-2023.12.2"
	optfeature "Google Cloud Storage" dev-python/gcsfs
	optfeature "AWS S3" dev-python/s3fs
	optfeature "SFTP and SSH filesystems" dev-python/paramiko
	optfeature "SMB filesystems" dev-python/smbprotocol
	optfeature "WebDAV-based filesystem on top of HTTP(S)" "dev-python/webdav4[fsspec]"
}
