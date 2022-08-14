# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Distributed scheduler for Dask"
HOMEPAGE="https://distributed.dask.org"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
	doc? (
		https://raw.githubusercontent.com/dask/distributed/${PV}/docs/source/conf.py -> ${P}-conf.py
		https://raw.githubusercontent.com/dask/distributed/${PV}/docs/source/images/task-state.svg -> ${P}-d-task-state.svg
		https://raw.githubusercontent.com/dask/distributed/${PV}/docs/source/images/worker-task-state.svg -> ${P}-d-worker-task-state.svg
		https://raw.githubusercontent.com/dask/distributed/${PV}/docs/source/images/worker-dep-state.svg -> ${P}-d-worker-dep-state.svg
		https://raw.githubusercontent.com/dask/distributed/${PV}/docs/source/images/memory-sampler.svg -> ${P}-d-memory-sampler.svg
	)
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# Test phase runs with fails

RDEPEND=">dev-python/click-6.6[${PYTHON_USEDEP}]
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
	>=dev-python/toolz-0.8.2[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	>=dev-python/zict-0.1.3[${PYTHON_USEDEP}]
	www-servers/tornado[${PYTHON_USEDEP}]
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
		for ivg in "${DISTDIR}"/*-d-*; do { cp ${ivg} "${S}"/docs/source/images/${ivg##*-d-} || die ; } ; done ; }

	distutils-r1_python_prepare_all
}
