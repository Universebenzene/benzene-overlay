# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Interactive plots and applications in the browser from Python"
HOMEPAGE="https://bokeh.org"
SRC_URI+=" https://github.com/bokeh/bokeh/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/contourpy-1.2[${PYTHON_USEDEP}]
	>=dev-python/jinja2-2.9[${PYTHON_USEDEP}]
	>=dev-python/narwhals-1.13[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.16[${PYTHON_USEDEP}]
	>=dev-python/packaging-16.8[${PYTHON_USEDEP}]
	>=dev-python/pandas-1.2[${PYTHON_USEDEP}]
	>=dev-python/pillow-7.1.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.10[${PYTHON_USEDEP}]
	>=dev-python/tornado-6.2[${PYTHON_USEDEP}]
	>=sci-geosciences/xyzservices-2021.09.1[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/colorama[${PYTHON_USEDEP}]
	test? (
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/json5[${PYTHON_USEDEP}]
		dev-python/networkx[${PYTHON_USEDEP}]
		dev-python/nbconvert[${PYTHON_USEDEP}]
		dev-python/pyarrow[${PYTHON_USEDEP}]
		dev-python/pygraphviz[${PYTHON_USEDEP}]
		<dev-python/pytest-asyncio-0.23[${PYTHON_USEDEP}]
		dev-python/requests-unixsocket[${PYTHON_USEDEP}]
		dev-python/selenium[${PYTHON_USEDEP}]
		dev-python/toml[${PYTHON_USEDEP}]
		dev-python/typing-extensions[${PYTHON_USEDEP}]
		dev-vcs/git
		net-libs/nodejs[npm]
	)
"

EPYTEST_PLUGINS=( pytest-{asyncio,timeout} )
distutils_enable_tests pytest

src_unpack() {
	use test && { mkdir gh-test || die ; pushd gh-test || die ; unpack ${P}.gh.tar.gz ; popd || die ; }
	default
}

python_prepare_all(){
	sed -i -e "/^name =/a version = \"${PV}\"" -e '/^dynamic =/d' pyproject.toml || die
	distutils-r1_python_prepare_all
}

python_test() {
	# From openSUSE
	local SKIP_TESTS="not test_bokehjs and not test_ext_commands"
	# too many flaky timeouts on obs servers
	local SKIP_TESTS+=" and not test_examples"
	# testfile not available
	local SKIP_TESTS+=" and not test_with_INLINE_resources"
	local SKIP_TESTS+=" and not test_with_CDN_resources"
	local SKIP_TESTS+=" and not test_with_Server_resources"
	local SKIP_TESTS+=" and not test_with_Server_resources_dev"
	local SKIP_TESTS+=" and not test_cross"
	# does not expect pytest-$binsuffix
	local SKIP_TESTS+=" and not test_detect_current_filename"
	# cannot open socket / address already in use / no pattern detected
	local SKIP_TESTS+=" and not (test_server and test_address)"
	local SKIP_TESTS+=" and not (test_serve and printed)"
	local SKIP_TESTS+=" and not test__ioloop_not_forcibly_stopped"
	# not json5 serializable
	local SKIP_TESTS+=" and not test_defaults and not test_bool"
	# flaky timeouts
	local SKIP_TESTS+=" and not (test_deprecation and (test_since or test_message))"
	local SKIP_TESTS+=" and not (test_document_lifecycle and test_document_on_session_destroyed_exceptions)"
	# test can't list modules correctly in test environment
	local SKIP_TESTS+=" and not (codebase and combined)"
	# extraneous fields
	local SKIP_TESTS+=" and not test_serialization_data_models"
	# linting and code structure irrelevant for rpm package
	local SKIP_TESTS+=" and not test_ruff and not test_isort and not test_eslint and not test_code_quality and not test_no_request_host"
	# no driver (chromedriver only x86_64)
	local SKIP_TESTS+=" and not Test_webdriver_control and not test_adding_periodic_twice"
	# fails when tested with pytest-xdist
	local SKIP_TESTS+=" and not (TestModelCls and test_get_class)"
	local SKIP_TESTS+=" and not test_external_js_and_css_resource_ordering"
	# No vermin pkg
	local SKIP_TESTS+=" and not test_vermin"
	# network
	local SKIP_TESTS+=" and not test__use_provided_session_header_autoload"
	local SKIP_TESTS+=" and not test_contour and not test_sampledata__util"
	epytest -m "not selenium" "${WORKDIR}"/gh-test/${P} -k "${SKIP_TESTS}"
}
