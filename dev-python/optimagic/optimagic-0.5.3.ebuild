# Copyright 1999-2026 Gentoo Authors
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
		dev-python/bokeh[${PYTHON_USEDEP}]
		dev-python/iminuit[${PYTHON_USEDEP}]
		dev-python/statsmodels[${PYTHON_USEDEP}]
		dev-python/jinja2[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/seaborn[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

EPYTEST_IGNORE=(
	# Needs bayes_opt
	tests/optimagic/optimizers/test_bayesian_optimizer.py
)

EPYTEST_DESELECT=(
	# Needs DFO-LS
	#tests/optimagic/optimization/test_many_algorithms.py::test_nag_dfols_starting_at_optimum
	# Need altair
	'tests/optimagic/visualization/test_backends.py::test_line_plot_all_backends[altair]'
	'tests/optimagic/visualization/test_convergence_plot.py::test_convergence_plot_options[True-options13]'
	'tests/optimagic/visualization/test_convergence_plot.py::test_convergence_plot_options[False-options13]'
	'tests/optimagic/visualization/test_history_plots.py::test_criterion_plot_different_backends[altair]'
	'tests/optimagic/visualization/test_history_plots.py::test_params_plot_different_backends[altair]'
	'tests/optimagic/visualization/test_slice_plot.py::test_slice_plot[sphere_loglike-kwargs1-altair]'
	'tests/optimagic/visualization/test_slice_plot.py::test_slice_plot[sphere_loglike-kwargs2-altair]'
	'tests/optimagic/visualization/test_slice_plot.py::test_slice_plot[sphere_loglike-kwargs3-altair]'
	'tests/optimagic/visualization/test_slice_plot.py::test_slice_plot[sphere_loglike-kwargs4-altair]'
	'tests/optimagic/visualization/test_slice_plot.py::test_slice_plot[sphere_loglike-kwargs6-altair]'
	'tests/optimagic/visualization/test_slice_plot.py::test_slice_plot[sphere_loglike-kwargs5-altair]'
	'tests/optimagic/visualization/test_slice_plot.py::test_slice_plot[sphere-kwargs8-altair]'
	'tests/optimagic/visualization/test_slice_plot.py::test_slice_plot[sphere_loglike-kwargs7-altair]'
	'tests/optimagic/visualization/test_slice_plot.py::test_slice_plot[sphere-kwargs9-altair]'
	'tests/optimagic/visualization/test_slice_plot.py::test_slice_plot[sphere-kwargs10-altair]'
	'tests/optimagic/visualization/test_slice_plot.py::test_slice_plot[sphere-kwargs12-altair]'
	'tests/optimagic/visualization/test_slice_plot.py::test_slice_plot[sphere-kwargs11-altair]'
	'tests/optimagic/visualization/test_slice_plot.py::test_slice_plot[sphere-kwargs13-altair]'
	'tests/optimagic/visualization/test_slice_plot.py::test_slice_plot[sphere-kwargs14-altair]'
	'tests/optimagic/visualization/test_slice_plot.py::test_slice_plot[sphere-kwargs15-altair]'
	'tests/optimagic/visualization/test_profile_plot.py::test_profile_plot_options[options5]'
	'tests/optimagic/visualization/test_slice_plot.py::test_slice_plot[sphere_loglike-kwargs0-altair]'
)

python_test() {
	# import file mismatch
	[[ -d src/${PN} ]] && { mv src/{,_}${PN} || die ; }
	epytest
	[[ -d src/${PN} ]] && { mv src/{_,}${PN} || die ; }
}
