# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

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

RDEPEND=">=dev-python/aiohttp-3.9.2[${PYTHON_USEDEP}]
	>=dev-python/aioitertools-0.5.1[${PYTHON_USEDEP}]
	>=dev-python/botocore-1.37.2[${PYTHON_USEDEP}]
	>=dev-python/jmespath-0.7.1[${PYTHON_USEDEP}]
	>=dev-python/multidict-6.0.0[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.1[${PYTHON_USEDEP}]
	>=dev-python/wrapt-1.10.10[${PYTHON_USEDEP}]
	awscli? ( app-admin/awscli[${PYTHON_USEDEP}] )
	boto3? ( dev-python/boto3[${PYTHON_USEDEP}] )
"
BDEPEND="test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/dill[${PYTHON_USEDEP}]
		dev-python/docker[${PYTHON_USEDEP}]
		dev-python/docutils[${PYTHON_USEDEP}]
		dev-python/flask-cors[${PYTHON_USEDEP}]
		dev-python/moto[${PYTHON_USEDEP}]
		dev-python/openapi-spec-validator[${PYTHON_USEDEP}]
		dev-python/pip[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/time-machine[${PYTHON_USEDEP}]
	)
"

EPYTEST_XDIST=1
distutils_enable_tests pytest
distutils_enable_sphinx docs

EPYTEST_IGNORE=(
	# test_lambda uses moto.awslambda, which requires a running Docker service
	# See: https://github.com/spulec/moto/issues/3276
	tests/test_lambda.py
)

EPYTEST_DESELECT=(
	# https://gitlab.archlinux.org/archlinux/packaging/packages/python-aiobotocore/-/blob/main/PKGBUILD
	'tests/test_patches.py::test_patches[BaseClient._make_api_call-digests12]'
	'tests/test_patches.py::test_patches[Config-digests21]'
	'tests/test_patches.py::test_patches[EndpointRulesetResolver._get_provider_params-digests117]'
	'tests/test_patches.py::test_patches[Session.create_client-digests123]'
	'tests/test_patches.py::test_patches[Waiter.wait-digests191]'
)

python_prepare_all() {
	# Work-around test failures with moto 5.x
	# See: https://github.com/aio-libs/aiobotocore/issues/1108
	#use test && { eapply "${FILESDIR}"/${PN}-2.12.3-moto-5.x.diff ; sed -i "s/pip._vendor.//" tests/test_version.py || die ; }
	use test && { sed -i "s/pip._vendor.//" tests/test_version.py || die ; }

	distutils-r1_python_prepare_all
}

python_test() {
	epytest -m "not localonly"
}
