# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 pypy3_11 )

inherit distutils-r1

DESCRIPTION="TLS sockets, key generation, encryption, decryption, signing, verification"
HOMEPAGE="https://github.com/wbond/oscrypto"
SRC_URI="https://github.com/wbond/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/wbond/oscrypto/commit/ebbc944485b278192b60080ea1f495e287efb4f8.patch -> ${P}-fix-openssl-3.0.10.patch
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+test"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND="dev-libs/openssl
	>=dev-python/asn1crypto-1.5.1[${PYTHON_USEDEP}]
"

DOCS=( docs {changelog,readme}.md )

PATCHES=(
	"${DISTDIR}"/${P}-fix-openssl-3.0.10.patch
	"${FILESDIR}"/${P}-replace-removed-imp-module.patch
)

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# https://gitlab.archlinux.org/archlinux/packaging/packages/python-oscrypto/-/blob/main/PKGBUILD
	# https://github.com/wbond/oscrypto/issues/73
	tests/test_tls.py::TLSTests::test_tls_connect_dh1024
	tests/test_tls.py::TLSTests::test_tls_error_client_cert_required
	tests/test_tls.py::TLSTests::test_tls_error_domain_mismatch
	tests/test_tls.py::TLSTests::test_tls_error_san_mismatch
	tests/test_tls.py::TLSTests::test_tls_error_wildcard_mismatch
	tests/test_tls.py::TLSTests::test_tls_extra_trust_roots
	tests/test_tls.py::TLSTests::test_tls_wildcard_success
	# https://github.com/wbond/oscrypto/issues/80
	tests/test_tls.py::TLSTests::test_tls_error_http
	tests/test_tls.py::TLSTests::test_tls_error_weak_dh_params
)
