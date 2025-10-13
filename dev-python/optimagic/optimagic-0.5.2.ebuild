# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Tools to solve difficult numerical optimization problems."
HOMEPAGE="https://optimagic.readthedocs.io"
SRC_URI="https://github.com/optimagic-dev/optimagic/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
#IUSE="+test"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND="dev-python/cloudpickle[${PYTHON_USEDEP}]
	dev-python/joblib[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/plotly[${PYTHON_USEDEP}]
	>=dev-python/pybaum-0.1.2[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.2.1[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-1.3[${PYTHON_USEDEP}]
	dev-python/annotated-types[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/hatch-vcs[${PYTHON_USEDEP}]
	test? (
		dev-python/statsmodels[${PYTHON_USEDEP}]
		dev-python/jinja2[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/seaborn[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

EPYTEST_IGNORE=(
	# Needs bayes_opt
	tests/optimagic/optimizers/test_bayesian_optimizer.py
)

EPYTEST_DESELECT=(
	# Needs DFO-LS
	tests/optimagic/optimization/test_many_algorithms.py::test_nag_dfols_starting_at_optimum
)
