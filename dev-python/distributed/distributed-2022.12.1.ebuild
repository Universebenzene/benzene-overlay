# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..10} )

GIT_RAW_URI="https://github.com/dask/distributed/raw/${PV}"

inherit distutils-r1

DESCRIPTION="Distributed scheduler for Dask"
HOMEPAGE="https://distributed.dask.org"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
	doc? (
		${GIT_RAW_URI}/docs/source/conf.py -> ${P}-conf.py
		${GIT_RAW_URI}/docs/source/images/task-state.svg -> ${P}-d-task-state.svg
		${GIT_RAW_URI}/docs/source/images/worker-cancel-state1.svg -> ${P}-d-worker-cancel-state1.svg
		${GIT_RAW_URI}/docs/source/images/worker-cancel-state2.svg -> ${P}-d-worker-cancel-state2.svg
		${GIT_RAW_URI}/docs/source/images/worker-dep-state.svg -> ${P}-d-worker-dep-state.svg
		${GIT_RAW_URI}/docs/source/images/worker-execute-state.svg -> ${P}-d-worker-execute-state.svg
		${GIT_RAW_URI}/docs/source/images/worker-forget-state.svg -> ${P}-d-worker-forget-state.svg
		${GIT_RAW_URI}/docs/source/images/worker-scatter-state.svg -> ${P}-d-worker-scatter-state.svg
		${GIT_RAW_URI}/docs/source/images/worker-state-machine.svg -> ${P}-d-worker-state-machine.svg
		${GIT_RAW_URI}/docs/source/images/memory-sampler.svg -> ${P}-d-memory-sampler.svg
	)
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# Test phase runs with fails

RDEPEND=">dev-python/click-7.0[${PYTHON_USEDEP}]
	>=dev-python/cloudpickle-1.5.0[${PYTHON_USEDEP}]
	dev-python/dask[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	>=dev-python/locket-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/msgpack-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-20.0[${PYTHON_USEDEP}]
	>=dev-python/psutil-5.0[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	>dev-python/sortedcontainers-2.0.1[${PYTHON_USEDEP}]
	>=dev-python/tblib-1.6.0[${PYTHON_USEDEP}]
	>=dev-python/toolz-0.10.0[${PYTHON_USEDEP}]
	>=dev-python/tornado-6.0.3[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	>=dev-python/zict-0.1.3[${PYTHON_USEDEP}]
"
BDEPEND="test? (
		dev-python/bokeh[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests nose
distutils_enable_sphinx docs/source dev-python/dask-sphinx-theme dev-python/numpydoc dev-python/sphinx-click

python_prepare_all() {
	use doc && { cp {"${DISTDIR}"/${P}-,"${S}"/docs/source/}conf.py || die ; mkdir -p "${S}"/docs/source/images || die ; \
		for ivg in "${DISTDIR}"/*-d-*; do { cp ${ivg} "${S}"/docs/source/images/${ivg##*-d-} || die ; } ; done ; \
		sed -i -e "/github/s/GH\#/GH\%s\#/" docs/source/conf.py || die ; }

	distutils-r1_python_prepare_all
}
