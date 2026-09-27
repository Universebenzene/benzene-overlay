# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYPI_VERIFY_REPO=https://github.com/aio-libs/aiobotocore
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Async client for aws services using botocore and aiohttp"
HOMEPAGE="https://aiobotocore.aio-libs.org"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="httpx httpx2"

RDEPEND=">=dev-python/aiohttp-3.14.0[${PYTHON_USEDEP}]
	>=dev-python/aioitertools-0.5.1[${PYTHON_USEDEP}]
	>=dev-python/botocore-1.43.66[${PYTHON_USEDEP}]
	>=dev-python/jmespath-0.7.1[${PYTHON_USEDEP}]
	>=dev-python/multidict-6.0.0[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.1[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.14.0[${PYTHON_USEDEP}]
	>=dev-python/wrapt-1.10.10[${PYTHON_USEDEP}]
	httpx? (
		>=dev-python/anyio-4.11.0[${PYTHON_USEDEP}]
		>=dev-python/httpx-0.25.1[${PYTHON_USEDEP}]
	)
	httpx2? (
		>=dev-python/anyio-4.11.0[${PYTHON_USEDEP}]
		>=dev-python/httpx2-2.0[${PYTHON_USEDEP}]
	)
"
BDEPEND=">=dev-python/hatch-fancy-pypi-readme-24.1.0[${PYTHON_USEDEP}]
	test? (
		dev-python/awscrt[${PYTHON_USEDEP}]
		dev-python/dill[${PYTHON_USEDEP}]
		dev-python/docker[${PYTHON_USEDEP}]
		dev-python/docutils[${PYTHON_USEDEP}]
		dev-python/flask-cors[${PYTHON_USEDEP}]
		dev-python/httpx[${PYTHON_USEDEP}]
		dev-python/httpx2[${PYTHON_USEDEP}]
		dev-python/moto[${PYTHON_USEDEP}]
		dev-python/openapi-spec-validator[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/tiny-proxy[${PYTHON_USEDEP}]
		dev-python/trustme[${PYTHON_USEDEP}]
		>=dev-python/anyio-4.11.0[${PYTHON_USEDEP}]
	)
"

PATCHES=( "${FILESDIR}/${PN}-3.3.0-fix-duplicate-server-header.patch" )

#EPYTEST_XDIST=1
EPYTEST_PLUGINS=( anyio pytest-mock time-machine )
distutils_enable_tests pytest
distutils_enable_sphinx docs

EPYTEST_IGNORE=(
	# test_lambda uses moto.awslambda, which requires a running Docker service
	# See: https://github.com/spulec/moto/issues/3276
	tests/test_lambda.py
)

python_test() {
	epytest -m "not localonly"
}
