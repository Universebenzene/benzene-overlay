# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Async client for aws services using botocore and aiohttp"
HOMEPAGE="http://aiobotocore.readthedocs.io"
SRC_URI="https://github.com/aio-libs/aiobotocore/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="awscli boto3"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND=">=dev-python/aiohttp-3.8.0[${PYTHON_USEDEP}]
	>=dev-python/aioitertools-0.5.1[${PYTHON_USEDEP}]
	dev-python/botocore[${PYTHON_USEDEP}]
	>=dev-python/wrapt-1.10.10[${PYTHON_USEDEP}]
	awscli? ( app-admin/awscli[${PYTHON_USEDEP}] )
	boto3? ( dev-python/boto3[${PYTHON_USEDEP}] )
"
BDEPEND="test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/dill[${PYTHON_USEDEP}]
		dev-python/flask-cors[${PYTHON_USEDEP}]
		dev-python/moto[${PYTHON_USEDEP}]
		dev-python/openapi-spec-validator[${PYTHON_USEDEP}]
		dev-python/pip[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs

EPYTEST_IGNORE=(
	# test_lambda uses moto.awslambda, which requires a running Docker service
	# See: https://github.com/spulec/moto/issues/3276
	# test_version checks lower and upper bounds for dependencies in setup.py,
	# and they are patched away
	tests/test_lambda.py
	tests/test_version.py
)

python_prepare_all() {
	use doc && { eapply "${FILESDIR}"/${PN}-2.5.0-fix-doc-title-underline.patch; mkdir -p docs/_static || die ; \
#		sed -i "/language\ = /s/None/'en'/" docs/conf.py || die ; \
	}

	distutils-r1_python_prepare_all
}

python_test() {
	epytest -m moto
}
