# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 edo pypi

DESCRIPTION="PKCS#11 (Cryptoki) support for Python"
HOMEPAGE="
	https://pypi.org/project/python-pkcs11
	https://github.com/danni/python-pkcs11
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/asn1crypto-0.22.0[${PYTHON_USEDEP}]"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		dev-libs/openssl
		dev-libs/softhsm
		dev-python/cryptography[${PYTHON_USEDEP}]
		dev-python/oscrypto[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-rtd-theme

# https://github.com/pyauth/python-pkcs11/pull/176
PATCHES=( "${FILESDIR}"/${P}-use-functools-cached-property.patch )

python_prepare_all() {
	use doc && { mkdir docs/_static || die ; \
#		sed -i "/language\ = /s/None/'en'/" docs/conf.py || die ; \
	}

	# test_sign_eddsa and test_self_sign_certificate always fail in our build environment
	# (https://github.com/danni/python-pkcs11/issues/63#issuecomment-526812900)
	use test && eapply "${FILESDIR}"/${P}-mark-tests-as-xfail.patch

	distutils-r1_python_prepare_all
}

python_test() {
	[[ -d ${PN/python-} ]] && { mv {,_}${PN/python-} || die ; }
	epytest
	[[ -d _${PN/python-} ]] && { mv {_,}${PN/python-} || die ; }
}

src_test() {
	local -x PKCS11_MODULE="${BROOT}/usr/$(get_libdir)/softhsm/libsofthsm2.so"
	local -x PKCS11_TOKEN_LABEL="TEST"
	local -x PKCS11_TOKEN_PIN="1234"
	local -x PKCS11_TOKEN_SO_PIN="5678"

	mkdir -p "${HOME}/.config/softhsm2" || die
	cat > "${HOME}/.config/softhsm2/softhsm2.conf" <<- EOF || die "Failed to create config"
		directories.tokendir = ${T}
		objectstore.backend = file
	EOF

	edo softhsm2-util --init-token --free \
		--label ${PKCS11_TOKEN_LABEL} \
		--pin ${PKCS11_TOKEN_PIN} \
		--so-pin ${PKCS11_TOKEN_SO_PIN}

	distutils-r1_src_test
}
