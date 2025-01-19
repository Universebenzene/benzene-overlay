# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Distributed scheduler for Dask"
HOMEPAGE="https://distributed.dask.org"
SRC_URI="https://github.com/dask/distributed/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"	# pyarrow, memray no x86
RESTRICT="test"	# Test phase runs with fails

RDEPEND=">dev-python/click-8.0[${PYTHON_USEDEP}]
	>=dev-python/cloudpickle-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/dask-2025.1.0[${PYTHON_USEDEP}]
	>=dev-python/jinja2-2.10.3[${PYTHON_USEDEP}]
	>=dev-python/locket-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/msgpack-1.0.2[${PYTHON_USEDEP}]
	>=dev-python/packaging-20.0[${PYTHON_USEDEP}]
	>=dev-python/psutil-5.8.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.4.1[${PYTHON_USEDEP}]
	>=dev-python/sortedcontainers-2.0.5[${PYTHON_USEDEP}]
	>=dev-python/tblib-1.6.0[${PYTHON_USEDEP}]
	>=dev-python/toolz-0.11.2[${PYTHON_USEDEP}]
	>=dev-python/tornado-6.2.0[${PYTHON_USEDEP}]
	>=dev-python/urllib3-1.26.5[${PYTHON_USEDEP}]
	>=dev-python/zict-3.0.0[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/versioneer[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest-timeout[${PYTHON_USEDEP}]
		dev-python/aiohttp[${PYTHON_USEDEP}]
		dev-python/asyncssh[${PYTHON_USEDEP}]
		dev-python/bokeh[${PYTHON_USEDEP}]
		dev-python/flaky[${PYTHON_USEDEP}]
		dev-python/h5py[${PYTHON_USEDEP}]
		dev-python/ipywidgets[${PYTHON_USEDEP}]
		dev-python/jupyter-server[${PYTHON_USEDEP}]
		dev-python/lz4[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/memray[${PYTHON_USEDEP}]
		dev-python/netcdf4[${PYTHON_USEDEP}]
		dev-python/numba[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/paramiko[${PYTHON_USEDEP}]
		dev-python/pyarrow[${PYTHON_USEDEP}]
		dev-python/python-snappy[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
		dev-python/uvloop[${PYTHON_USEDEP}]
		dev-python/zstandard[${PYTHON_USEDEP}]
		sci-geosciences/xyzservices[${PYTHON_USEDEP}]
	)
"

EPYTEST_XDIST=1
distutils_enable_tests pytest
distutils_enable_sphinx docs/source dev-python/dask-sphinx-theme dev-python/numpydoc \
	dev-python/sphinx-click \
	dev-python/sphinx-design \
	dev-python/memray

EPYTEST_DESELECT=(
	distributed/cli/tests/test_dask_scheduler.py
	distributed/cli/tests/test_dask_spec.py
	distributed/cli/tests/test_dask_worker.py
	distributed/cli/tests/test_tls_cli.py
	"distributed/comm/tests/test_comms.py::test_tls_comm_closed_implicit[tornado]"
	distributed/deploy/tests/test_local.py::test_defaults_5
	distributed/deploy/tests/test_old_ssh.py
	distributed/deploy/tests/test_subprocess.py
	distributed/tests/test_client.py::test_computation_object_code_dask_compute
	distributed/tests/test_init.py::test_git_revision
	distributed/tests/test_queues.py::test_queue_in_task
	distributed/tests/test_steal.py::test_steal_twice
	distributed/tests/test_variable.py::test_variable_in_task
	distributed/tests/test_worker_memory.py::test_fail_to_pickle_execute_1
	"distributed/tests/test_active_memory_manager.py::test_RetireWorker_with_actor[True]"
	# TypeError: _FlakyPlugin._make_test_flaky() got an unexpected keyword argument 'reruns'
	distributed/comm/tests/test_ws.py
	distributed/deploy/tests/test_slow_adaptive.py::test_scale_up_down
	distributed/diagnostics/tests/test_progress.py::test_many_Progress
	distributed/diagnostics/tests/test_progress.py::test_AllProgress
	distributed/diagnostics/tests/test_progress.py::test_AllProgress_lost_key
	distributed/tests/test_client.py::test_profile
	distributed/tests/test_worker.py::test_statistical_profiling
)

python_prepare_all() {
	use doc && { sed -i -e "/github/s/GH\#/GH\%s\#/" docs/source/conf.py || die ; \
#		sed -i "/language\ = /s/None/'en'/" docs/source/conf.py || die ; \
	}
	sed -i -e '/--cov/d' pyproject.toml || die

	distutils-r1_python_prepare_all
}

python_test() {
	epytest --runslow -m "not avoid_ci and not gpu and not extra_packages"
}
